import 'package:flutter/material.dart';
import 'package:grocery_management/pages/components/app_button.dart';
import 'package:grocery_management/pages/components/app_text_field.dart';
import 'package:grocery_management/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    super.key,
    required this.onTap,
  });

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
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
            AppButton(
              text: "Login",
              onTap: () => login(context),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: onTap,
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
