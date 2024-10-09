import 'package:flutter/material.dart';
import 'package:grocery_management/services/auth_service.dart';

import 'components/app_button.dart';
import 'components/app_text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({
    super.key,
    required this.onTap,
  });

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final void Function()? onTap;

  void register(BuildContext context) async {
    final authService = AuthService();
    if (_passwordController.text == _confirmPwController.text) {
      try {
        authService.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              e.toString(),
            ),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Grocery Management",
              style: TextStyle(
                color: Colors.cyan[900],
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 25),
            AppTextField(
              hintText: "Email",
              obscureText: false,
              typeText: true,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            AppTextField(
              hintText: "Password",
              obscureText: true,
              typeText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 25),
            AppTextField(
              hintText: "Confirm Password",
              obscureText: true,
              typeText: true,
              controller: _confirmPwController,
            ),
            const SizedBox(height: 25),
            AppButton(
              text: "Register",
              onTap: () => register(context),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: onTap,
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
