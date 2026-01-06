import 'package:flutter/material.dart';
import 'package:state_extended/state_extended.dart';

class SettingScreenWidgets extends StatefulWidget {
  const SettingScreenWidgets({super.key});

  @override
  StateX<SettingScreenWidgets> createState() => _SettingScreenWidgetsState();
}

class _SettingScreenWidgetsState extends StateX<SettingScreenWidgets> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController parentController,
      childController,
      hourController,
      minuteController;
  late FocusNode parentFocusNode,
      childFocusNode,
      hourFocusNode,
      minuteFocusNode;
  late bool learnLock, playLock;

  @override
  void initState() {
    parentController = TextEditingController();
    childController = TextEditingController();
    hourController = TextEditingController(text: "01");
    minuteController = TextEditingController(text: "00");
    parentFocusNode = FocusNode();
    childFocusNode = FocusNode();
    hourFocusNode = FocusNode();
    minuteFocusNode = FocusNode();
    learnLock = false;
    playLock = false;
    super.initState();
  }

  @override
  void dispose() {
    parentController.dispose();
    childController.dispose();
    hourController.dispose();
    minuteController.dispose();
    parentFocusNode.dispose();
    childFocusNode.dispose();
    hourFocusNode.dispose();
    minuteFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: parentController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: size.height * 0.01,
                horizontal: size.width * 0.04,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.03),
                borderSide: const BorderSide(
                  color: Color(0xffE2A9FF),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.03),
                borderSide: const BorderSide(
                  color: Color(0xffE2A9FF),
                  width: 2,
                ),
              ),
              hintText: "Parent's Name",
              hintStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: size.width * 0.05,
              ),
            ),
            validator: (v) => v!.isEmpty ? "Parent name required" : null,
          ),
          SizedBox(height: size.height * 0.028),
          TextFormField(
            controller: childController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: size.height * 0.01,
                horizontal: size.width * 0.04,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.03),
                borderSide: const BorderSide(
                  color: Color(0xffE2A9FF),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.03),
                borderSide: const BorderSide(
                  color: Color(0xffE2A9FF),
                  width: 2,
                ),
              ),
              hintText: "Child's Name",
              hintStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: size.width * 0.05,
              ),
            ),
            keyboardType: TextInputType.name,
            validator: (v) => v!.isEmpty ? "Child name required" : null,
          ),
          SizedBox(height: size.height * 0.035),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.01,
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
                      "Lock Learn Section",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.048,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "Enable/Disable learn section",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => learnLock = !learnLock);
                  },
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
                      alignment: learnLock
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: size.width * 0.05,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: learnLock
                              ? const Color(0xff7C3AED)
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.035),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.01,
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
                      "Lock Play Section",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.048,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "Enable/Disable play section",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => playLock = !playLock);
                  },
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
                      alignment: playLock
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: size.width * 0.05,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: playLock
                              ? const Color(0xff7C3AED)
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.035),
          Container(
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
                Text(
                  "Hour",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                TextFormField(
                  controller: hourController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.04,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.04),
                      borderSide: BorderSide.none,
                    ),
                    hintText: hourController.text,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  "Minutes",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                TextFormField(
                  controller: minuteController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.04,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.04),
                      borderSide: BorderSide.none,
                    ),
                    hintText: minuteController.text,
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          SizedBox(
            width: double.infinity,
            height: size.height * 0.06,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.width * 0.04),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  debugPrint("Settings Saved");
                }
              },
              child: Text(
                "Save Settings",
                style: TextStyle(
                  color: Color(0xff7C3AED),
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.04,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }
}
