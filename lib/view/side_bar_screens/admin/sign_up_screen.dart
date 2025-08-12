import 'package:flutter/material.dart';
import 'package:post_auth/service/auth_service.dart';
import 'package:post_auth/view/side_bar_screens/admin/login_screen.dart';
import 'package:post_auth/widget/my_button.dart';
import 'package:post_auth/widget/snack_bar.dart';
import 'package:post_auth/widget/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signUpUser() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthService().signUpUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _nameController.text.trim(),
    );

    if (!mounted) return; // ✅ Prevents context errors

    if (res == "successfully signed up") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      showSnackBar(context, res);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: height / 2.0,
                  child: Image.asset('assets/image/authentication.png'),
                ),
                TextFieldInput(
                  textEditingController: _nameController,
                  hintText: 'User Name',
                  icon: Icons.person,
                ),
                TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Email or Phone Number',
                  icon: Icons.email,
                ),
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                ),
                MyButton(
                  onTap: isLoading ? null : signUpUser,
                  text: isLoading ? "Signing Up..." : "Sign Up",
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
