import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_auth/view/side_bar_screens/admin/login_screen.dart';
import 'package:post_auth/view/side_bar_screens/profile_screen.dart';

class SettingScreen extends StatefulWidget {
  static const String ID = 'settingScreen';
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = false;
  bool notificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/background.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          ListView(
            children: [
              const SizedBox(height: 20),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 17, 134, 230),
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: const Text('My Account'),
                subtitle: const Text('Profile, Orders, Wishlist'),
                trailing: const Icon(FontAwesomeIcons.arrowRight),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
              const Divider(),
              SwitchListTile(
                value: notificationEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationEnabled = value;
                  });
                },
                title: const Text('Notifications'),
                secondary: const Icon(FontAwesomeIcons.bell),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(FontAwesomeIcons.language),
                title: const Text('Language'),
                subtitle: const Text('English'),
                onTap: () {
                  // You can add language selection logic here
                },
                trailing: const Icon(FontAwesomeIcons.arrowRight),
              ),
              const Divider(),
              SwitchListTile(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
                title: const Text('Dark Mode'),
                secondary: const Icon(FontAwesomeIcons.moon),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(FontAwesomeIcons.questionCircle),
                title: const Text('Help & Support'),
                trailing: const Icon(FontAwesomeIcons.arrowRight),
                onTap: () {
                  // Navigate to support screen
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.signOutAlt,
                  color: Colors.red,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () async {
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Log out',
                        style: GoogleFonts.kantumruyPro(color: Colors.black),
                      ),
                      content: Text(
                        'Are you sure you want to log out?',
                        style: GoogleFonts.kantumruyPro(color: Colors.black),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text(
                            'Yes',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  );
                  if (shouldLogout == true) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
