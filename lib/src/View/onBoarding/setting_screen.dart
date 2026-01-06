import 'package:flutter/material.dart';
import 'package:lino_parents/src/View/widgets/app_snackbar.dart';
import 'package:lino_parents/src/View/widgets/app_submit_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController hourController, minuteController;
  late FocusNode hourFocusNode, minuteFocusNode;
  late bool learnLock, playLock;

  final String parentName = "Parent's Name";
  final String childName = "Child's Name";

  @override
  void initState() {
    super.initState();
    hourController = TextEditingController(text: "01");
    minuteController = TextEditingController(text: "00");
    hourFocusNode = FocusNode();
    minuteFocusNode = FocusNode();
    learnLock = false;
    playLock = false;
  }

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    hourFocusNode.dispose();
    minuteFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
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
      ),
      backgroundColor: Colors.white,
      body: Stack(children: [_gradientSection(size), _contentSection(size)]),
    );
  }

  Widget _gradientSection(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          height: size.height * .25,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffFFFFFF), Color(0xffAF52DE)],
            ),
          ),
        ),
      ],
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
    return Form(
      key: _formKey,
      child: Column(
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
            onTap: () => setState(() => learnLock = !learnLock),
          ),
          SizedBox(height: size.height * 0.035),

          _lockTile(
            size: size,
            title: "Lock Play Section",
            subtitle: "Enable/Disable play section",
            value: playLock,
            onTap: () => setState(() => playLock = !playLock),
          ),
          SizedBox(height: size.height * 0.035),

          _timeControlBox(size),
          SizedBox(height: size.height * 0.035),

          AppPrimaryButton(
            text: "Save Settings",
            backgroundColor: Colors.white,
            textColor: const Color(0xff7C3AED),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                AppSnackBar.show(
                  context,
                  message: "Settings saved successfully",
                  backgroundColor: const Color(0xff7C3AED),
                );
              }
            },
          ),
          SizedBox(height: size.height * 0.02),
        ],
      ),
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
