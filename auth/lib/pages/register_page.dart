import 'package:auth/components/my_button.dart';
import 'package:auth/components/my_textfield.dart';
import 'package:auth/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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

  Future<void> signUserUp() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      showMessage('Please fill in all fields');
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showMessage('Passwords don\'t match');
      return;
    }

    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          showMessage('That password is too weak');
          break;
        case 'email-already-in-use':
          showMessage('An account already exists for that email');
          break;
        case 'invalid-email':
          showMessage('That email address looks invalid');
          break;
        default:
          showMessage('Something went wrong. Please try again');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
                    Icons.person_add_alt_1_rounded,
                    size: 90,
                    color: Colors.deepPurple.shade400,
                  ),

                  const SizedBox(height: 30),

                  Text(
                    'Let\'s create an account for you',
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

                  MytextfieldP(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                  ),

                  const SizedBox(height: 25),

                  _isLoading
                      ? const CircularProgressIndicator()
                      : MyButton(onTap: signUserUp, text: 'Sign up'),

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
                        'Already a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Login now',
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
