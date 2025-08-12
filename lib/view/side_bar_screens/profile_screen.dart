// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.black87, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 58, 92, 231),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Profile Picture and Name
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/image/me.jpg'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Dom",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Dom@gmail.com",
                    style: TextStyle(
                      color: Color.fromARGB(255, 112, 112, 112),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Profile Options
            ProfileOption(
              icon: FontAwesomeIcons.edit,
              iconcolor: const Color.fromARGB(255, 58, 92, 231),
              title: "Edit Profile",
              onTap: () {},
            ),
            ProfileOption(
              icon: FontAwesomeIcons.shoppingBag,
              iconcolor: const Color.fromARGB(255, 58, 92, 231),
              title: "My Orders",
              onTap: () {},
            ),
            ProfileOption(
              icon: FontAwesomeIcons.heart,
              iconcolor: const Color.fromARGB(255, 58, 92, 231),
              title: "Wishlist",
              onTap: () {},
            ),
            ProfileOption(
              icon: FontAwesomeIcons.locationArrow,
              iconcolor: const Color.fromARGB(255, 58, 92, 231),
              title: "Shipping Address",
              onTap: () {},
            ),
            ProfileOption(
              icon: FontAwesomeIcons.creditCard,
              iconcolor: const Color.fromARGB(255, 58, 92, 231),
              title: "Payment Methods",
              onTap: () {},
            ),
            ProfileOption(
              icon: FontAwesomeIcons.cog,
              iconcolor: const Color.fromARGB(255, 58, 92, 231),
              title: "Settings",
              onTap: () {},
            ),
            ProfileOption(
              icon: FontAwesomeIcons.signOutAlt,
              iconcolor: const Color.fromARGB(255, 236, 4, 23),
              title: "Logout",
              onTap: () {
                // Logout logic
              },
              color: Colors.red,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;
  final Color? iconcolor;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
    this.iconcolor,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconcolor ?? Colors.deepPurple),
      title: Text(title, style: TextStyle(color: color ?? Colors.black)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
