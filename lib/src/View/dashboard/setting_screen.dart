import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lino_parents/src/Controller/all_controllers.dart';
import 'package:lino_parents/src/Model/repository.dart';
import 'package:lino_parents/src/View/widgets/app_snackbar.dart';
import 'package:lino_parents/src/View/widgets/app_submit_button.dart';
import 'package:lino_parents/src/View/widgets/gradient_section.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:geolocator/geolocator.dart';
import 'package:state_extended/state_extended.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  StateX<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends StateX<SettingScreen> {
  late AllController _con;
  late TextEditingController hourController, minuteController;
  late FocusNode hourFocusNode, minuteFocusNode;
  late bool learnLock, playLock;
  LocationPermission? permission;
  final String parentName = localDb.value.parentName!;
  final String childName = localDb.value.childName!;
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    _con = AllController();
    hourController = TextEditingController();
    minuteController = TextEditingController();
    hourFocusNode = FocusNode();
    minuteFocusNode = FocusNode();
    loadTimeDuration();
    learnLock = localDb.value.playLock!;
    playLock = localDb.value.learnLock!;
    getData();
  }

  void getData() async {
    Position pos = await getCurrentLocation();
    socket = IO.io(
      baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.onConnect((_) {
      dynamic data = {
        "userId": localDb.value.uid,
        "userType": "parent",
        "latitude": pos.latitude.toString(),
        "longitude": pos.longitude.toString(),
      };
      socket.emit('login', data);
    });

    socket.onConnectError((data) {
      print("Connect Error: $data");
    });

    socket.onDisconnect((_) {
      print("Disconnected");
    });
    socket.connect();
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied');
    }

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }

  Future<void> updateTimeDuration() async {
    final int hour = int.tryParse(hourController.text) ?? 0;
    final int minute = int.tryParse(minuteController.text) ?? 0;
    bool success = await _con.saveTimeDurationContro(hour, minute);
    if (success) {
      AppSnackBar.show(
        context,
        message: "Settings saved successfully",
        backgroundColor: const Color(0xff7C3AED),
      );
    } else {
      AppSnackBar.show(
        context,
        message: "Something went wrong",
        backgroundColor: Colors.red,
      );
    }
    hourController.clear();
    minuteController.clear();
  }

  Future<void> loadTimeDuration() async {
    final minutes = await _con.getTimeDurationContro();
    if (minutes != null) {
      setState(() {
        final hour = minutes ~/ 60;
        final minute = minutes % 60;

        hourController.text = hour.toString().padLeft(2, '0');
        minuteController.text = minute.toString().padLeft(2, '0');
      });
    }
  }

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    hourFocusNode.dispose();
    minuteFocusNode.dispose();
    socket.disconnect();
    socket.clearListeners();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          socket.disconnect();
          socket.clearListeners();
          socket.dispose();
          exit(0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: size.width * 0.01),
            child: SizedBox(
              width: size.width * 0.2,
              height: size.height * 0.12,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(
                Icons.chat,
                size: size.width * .09,
                color: Color(0xff7C3AED),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/chatDates');
              },
            ),
            SizedBox(width: size.width * 0.04),
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(children: [const GradientBottomSection(), _contentSection(size)]),
      ),
    );
  }

  Widget _contentSection(Size size) {
    return SizedBox(
      height: size.height,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.02,
        ),
        child: SingleChildScrollView(child: _form(size)),
      ),
    );
  }

  Widget _form(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _staticLabel(parentName, size),
        SizedBox(height: size.height * 0.025),

        _staticLabel(childName, size),
        SizedBox(height: size.height * 0.035),

        _lockTile(
          size: size,
          title: "Lock Learn Section",
          subtitle: "Enable/Disable learn section",
          value: learnLock,
          onTap: () {
            setState(() => learnLock = !learnLock);
            socket.emit("learn-lock", {
              "userId": localDb.value.uid!,
              "status": learnLock,
            });
          },
        ),
        SizedBox(height: size.height * 0.035),

        _lockTile(
          size: size,
          title: "Lock Play Section",
          subtitle: "Enable/Disable play section",
          value: playLock,
          onTap: () {
            setState(() => playLock = !playLock);
            socket.emit("play-lock", {
              "userId": localDb.value.uid,
              "status": playLock,
            });
          },
        ),
        SizedBox(height: size.height * 0.035),

        _timeControlBox(size),
        SizedBox(height: size.height * 0.035),

        AppPrimaryButton(
          text: "Save Settings",
          backgroundColor: Colors.white,
          textColor: const Color(0xff7C3AED),
          onPressed: updateTimeDuration,
        ),
        SizedBox(height: size.height * 0.02),
      ],
    );
  }

  Widget _staticLabel(String value, Size size) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.04,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width * 0.03),
        border: Border.all(color: const Color(0xffE2A9FF), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: size.width * 0.05,
            ),
          ),
        ],
      ),
    );
  }

  Widget _lockTile({
    required Size size,
    required String title,
    required String subtitle,
    required bool value,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.014,
        horizontal: size.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffA855F7),
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.048,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.04,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: size.width * 0.125,
              height: size.height * 0.03,
              padding: EdgeInsets.all(size.width * 0.009),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * 0.036),
                color: Colors.white,
              ),
              child: Align(
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: size.width * 0.05,
                  height: size.height * 0.05,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: value ? const Color(0xff7C3AED) : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeControlBox(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
        horizontal: size.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffA855F7),
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Control App Usage",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: size.width * 0.048,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          _timeField(size, "Hour", hourController),
          SizedBox(height: size.height * 0.01),
          _timeField(size, "Minutes", minuteController),
        ],
      ),
    );
  }

  Widget _timeField(Size size, String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: size.height * 0.005,
              horizontal: size.width * 0.04,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size.width * 0.04),
              borderSide: BorderSide.none,
            ),
            hintText: controller.text,
            hintStyle: TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
