import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});
  final void Function()? onTap;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _obscurePassword = true;
  bool _confirmObscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _confirmPwController.dispose();
    super.dispose();
  }

  void register() async {
    if (_pwController.text != _confirmPwController.text) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text('Passwords do not match.')),
      );
      return;
    }

    try {
      await _authService.signUp(
        email: _emailController.text.trim(),
        password: _pwController.text,
      );
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // LOGO
            Icon(
              Icons.message,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 50),
            // WELCOME BACK MESSAGE
            Text(
              'Want to sign in?',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),

            // PW TEXTFIELD
            MyTextfield(
              hintText: 'Email',
              obscureText: false,
              showSuffixIcon: false,
              controller: _emailController,
            ),

            const SizedBox(height: 10),
            //PW PASSWORD
            MyTextfield(
              hintText: 'Password',
              obscureText: _obscurePassword,
              showSuffixIcon: true,
              controller: _pwController,
              suffixIcon: _obscurePassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              onSuffixTap: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            const SizedBox(height: 10),
            MyTextfield(
              hintText: 'Confirm Password',
              obscureText: _confirmObscurePassword,
              showSuffixIcon: true,
              controller: _confirmPwController,
              suffixIcon: _confirmObscurePassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              onSuffixTap: () {
                setState(() {
                  _confirmObscurePassword = !_confirmObscurePassword;
                });
              },
            ),
            const SizedBox(height: 25),
            // LOGIN BUTTON
            MyButton(text: 'Sign in', onTap: register),
            const SizedBox(height: 25),
            // REGISTER NOW
            Row(
              mainAxisAlignment: .center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: widget.onTap,
                  child: Text(
                    'Login Now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
