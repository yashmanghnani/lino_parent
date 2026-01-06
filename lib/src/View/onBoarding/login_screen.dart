import 'package:flutter/material.dart';
import 'package:lino_parents/src/View/widgets/app_snackbar.dart';
import 'package:lino_parents/src/View/widgets/app_submit_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  bool validate() {
    if (_emailController.text.isEmpty) {
      AppSnackBar.show(
        context,
        message: "Email required",
        backgroundColor: Colors.red,
      );
      return false;
    }

    if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(_emailController.text)) {
      AppSnackBar.show(
        context,
        message: "Enter valid email",
        backgroundColor: Colors.red,
      );
      return false;
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

  void loginFun() {
    if (validate()) {
      debugPrint("Login Success");
      Navigator.pushNamed(context, '/setting');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [_gradientSection(size), _formSection(size)]),
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
                _emailField(size),
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

  Widget _emailField(Size size) {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocus,
      keyboardType: TextInputType.emailAddress,
      decoration: _inputDecoration(size, hint: "Email Id"),
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
