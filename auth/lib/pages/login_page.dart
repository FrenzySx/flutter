import 'package:auth/components/my_button.dart';
import 'package:auth/components/my_textfield.dart';
import 'package:auth/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text(message));
      },
    );
  }

  Future<void> signInWithProvider(AuthProvider provider, String name) async {
    try {
      await FirebaseAuth.instance.signInWithProvider(provider);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'canceled' || e.code == 'web-context-canceled') return;
      showMessage('$name sign-in failed. Please try again');
    }
  }

  Future<void> signUserIn() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      showMessage('Please fill in both email and password');
      return;
    }

    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
        case 'user-not-found':
        case 'wrong-password':
          showMessage('Incorrect email or password');
          break;
        case 'invalid-email':
          showMessage('That email address looks invalid');
          break;
        case 'too-many-requests':
          showMessage('Too many attempts. Please try again later');
          break;
        default:
          showMessage('Something went wrong. Please try again');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> resetPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      showMessage(
        'Enter your email above first, then tap "Forgot your password?"',
      );
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (mounted) showMessage('Password reset email sent to $email');
    } on FirebaseAuthException catch (_) {
      showMessage(
        'Could not send reset email. Check the address and try again',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade100, Colors.grey.shade100],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  Icon(
                    Icons.lock_outline_rounded,
                    size: 90,
                    color: Colors.deepPurple.shade400,
                  ),

                  const SizedBox(height: 30),

                  Text(
                    'Welcome back, you\'ve been missed!',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),

                  const SizedBox(height: 25),

                  MyTextfield(
                    controller: emailController,
                    hintText: "Email",
                    obscuretext: false,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 10),

                  MytextfieldP(
                    controller: passwordController,
                    hintText: "Password",
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: resetPassword,
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  _isLoading
                      ? const CircularProgressIndicator()
                      : MyButton(onTap: signUserIn, text: 'Sign in'),

                  const SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.grey[400]),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),

                        Expanded(
                          child: Divider(thickness: 1, color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                          imagePath: 'lib/images1/google-logo.png',
                          onTap: () => signInWithProvider(
                            GoogleAuthProvider(),
                            'Google',
                          ),
                        ),
                        const SizedBox(width: 10),
                        SquareTile(
                          imagePath: 'lib/images1/747.png',
                          onTap: () =>
                              signInWithProvider(AppleAuthProvider(), 'Apple'),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.deepPurple.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
