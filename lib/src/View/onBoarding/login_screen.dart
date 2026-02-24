import 'package:flutter/material.dart';
import 'package:lino_parents/src/Controller/all_controllers.dart';
import 'package:lino_parents/src/Model/Request/login_req.dart';
import 'package:lino_parents/src/Model/Response/login_res.dart';
import 'package:lino_parents/src/View/widgets/app_snackbar.dart';
import 'package:lino_parents/src/View/widgets/app_submit_button.dart';
import 'package:lino_parents/src/View/widgets/gradient_section.dart';
import 'package:state_extended/state_extended.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  StateX<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends StateX<LoginScreen> {
  late AllController _con;
  late TextEditingController _mobileController;
  late TextEditingController _passwordController;

  late FocusNode _mobileFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();
    _con = AllController();
    _mobileController = TextEditingController();
    _passwordController = TextEditingController();
    _mobileFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    _mobileFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  bool validate() {
    if (_mobileController.text.contains(" ")) {
      AppSnackBar.show(
        context,
        message: "Mobile number should not contain spaces",
        backgroundColor: Colors.red,
      );
      return false;
    }
    if (_mobileController.text.length != 10) {
      AppSnackBar.show(
        context,
        message: "Mobile number should be 10 digits",
        backgroundColor: Colors.red,
      );
      return false;
    } else {
      if (_mobileController.text.startsWith('0') ||
          _mobileController.text.startsWith('1') ||
          _mobileController.text.startsWith('2') ||
          _mobileController.text.startsWith('3') ||
          _mobileController.text.startsWith('4') ||
          _mobileController.text.startsWith('5')) {
        AppSnackBar.show(
          context,
          message: "Please enter valid mobile number",
          backgroundColor: Colors.red,
        );
        return false;
      }
    }

    if (_passwordController.text.isEmpty) {
      AppSnackBar.show(
        context,
        message: "Password required",
        backgroundColor: Colors.red,
      );
      return false;
    }

    if (!RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$',
    ).hasMatch(_passwordController.text)) {
      AppSnackBar.show(
        context,
        message: "Password must contain uppercase, lowercase, number & symbol",
        backgroundColor: Colors.red,
      );
      return false;
    }
    return true;
  }

  void loginFun() async {
    if (validate()) {
      try {
        LoginResponse res = await _con.loginContro(
          LoginRequest()
            ..mobile = _mobileController.text
            ..password = _passwordController.text,
        );

        if (res.success!) {
          AppSnackBar.show(
            context,
            message: res.msg!,
            backgroundColor: Colors.green,
          );
          Navigator.pushNamed(context, '/setting');
        } else {
          AppSnackBar.show(
            context,
            message: res.msg!,
            backgroundColor: Colors.red,
          );
        }
      } catch (e) {
        AppSnackBar.show(
          context,
          message: "Server error",
          backgroundColor: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [const GradientBottomSection(), _formSection(size)],
      ),
    );
  }

  Widget _formSection(Size size) {
    return SizedBox(
      height: size.height,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _logo(size),
                SizedBox(height: size.height * 0.02),
                _mobileField(size),
                SizedBox(height: size.height * 0.028),
                _passwordField(size),
                SizedBox(height: size.height * 0.04),
                AppPrimaryButton(
                  text: "Login",
                  backgroundColor: const Color(0xffAF52DE),
                  onPressed: () => loginFun(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo(Size size) {
    return SizedBox(
      width: size.width * 0.3,
      height: size.height * 0.2,
      child: Image.asset('assets/images/logo.png'),
    );
  }

  Widget _mobileField(Size size) {
    return TextField(
      controller: _mobileController,
      focusNode: _mobileFocus,
      keyboardType: TextInputType.phone,
      decoration: _inputDecoration(size, hint: "Mobile"),
      onSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocus),
    );
  }

  Widget _passwordField(Size size) {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocus,
      obscureText: true,
      decoration: _inputDecoration(size, hint: "Password"),
      onSubmitted: (_) => loginFun(),
    );
  }

  InputDecoration _inputDecoration(Size size, {required String hint}) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.04,
      ),
      enabledBorder: _border(size),
      focusedBorder: _border(size, width: 2),
      errorBorder: _border(size),
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xffAEAEAE),
        fontWeight: FontWeight.w400,
      ),
    );
  }

  OutlineInputBorder _border(Size size, {double width = 1.5}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(size.width * 0.03),
      borderSide: BorderSide(color: const Color(0xffE2A9FF), width: width),
    );
  }
}
