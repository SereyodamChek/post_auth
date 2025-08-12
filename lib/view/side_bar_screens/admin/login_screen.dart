import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post_auth/service/auth_service.dart';
import 'package:post_auth/view/main_screen.dart';
import 'package:post_auth/view/side_bar_screens/admin/sign_up_screen.dart';
import 'package:post_auth/widget/my_button.dart';
import 'package:post_auth/widget/snack_bar.dart';
import 'package:post_auth/widget/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  // This method will be used to handle the sign-up logic
  Future<void> loginUser() async {
    String res = await AuthService().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res == "successfully logged in") {
      setState(() {
        isLoading = true;
        // Navigate to the login screen or home screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      });
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
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
                  height: height / 2.1,
                  child: Image.asset('assets/image/authentication.png'),
                ),
                TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Email or Phone Number',
                  icon: FontAwesomeIcons.envelope,
                ),
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Password',
                  icon: FontAwesomeIcons.lock,
                  isPassword: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                MyButton(onTap: loginUser, text: "Login"),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
