// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:post_auth/view/side_bar_screens/Post/get_screen.dart';
import 'package:post_auth/view/side_bar_screens/Post/post_screen.dart';
import 'package:post_auth/view/side_bar_screens/admin/login_screen.dart';
import 'package:post_auth/view/side_bar_screens/buyer_screen.dart';
import 'package:post_auth/view/side_bar_screens/dashboard_screen.dart';
import 'package:post_auth/view/side_bar_screens/payment_screen.dart';
import 'package:post_auth/view/side_bar_screens/profile_screen.dart';
import 'package:post_auth/view/side_bar_screens/report_screen.dart';
import 'package:post_auth/view/side_bar_screens/setting_screen.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = DashboardScreen();

  screenSelector(AdminMenuItem item) {
    switch (item.route) {
      case DashboardScreen.ID:
        setState(() => _selectedScreen = DashboardScreen());
        break;
      case PostScreen.ID:
        setState(() => _selectedScreen = PostScreen());
        break;
      case GetScreen.ID:
        setState(() => _selectedScreen = GetScreen());
        break;
      case PaymentScreen.ID:
        setState(() => _selectedScreen = PaymentScreen());
        break;
      case BuyerScreen.ID:
        setState(() => _selectedScreen = BuyerScreen());
        break;
      case ReportScreen.ID:
        setState(() => _selectedScreen = ReportScreen());
        break;
      case SettingScreen.ID:
        setState(() => _selectedScreen = SettingScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/image/image.png', fit: BoxFit.cover),
        ),
        AdminScaffold(
          appBar: AppBar(
            elevation: 0.5,
            flexibleSpace: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/image/image.png', // Background image
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(
                    0.2,
                  ), // Optional: dark overlay for readability
                ),
              ],
            ),
            title: Text(
              'Online Shop',
              style: GoogleFonts.kantumruyPro(
                fontSize: 20,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'logout') {
                    final shouldLogout = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Log out'),
                        content: const Text(
                          'Are you sure you want to log out?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Yes'),
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
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'profile',
                      child: ListTile(
                        leading: const Icon(FontAwesomeIcons.user),
                        title: const Text('Profile'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'settings',
                      child: ListTile(
                        leading: Icon(FontAwesomeIcons.cog),
                        title: const Text('Settings'),
                        onTap: () {
                          // Close the popup menu
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'logout',
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.signOutAlt,
                          color: Colors.redAccent,
                        ),
                        title: Text('Logout'),
                      ),
                    ),
                  ];
                },
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/image/me.jpg'),
                      radius: 16,
                    ),
                    SizedBox(width: 8),
                    Text('Admin', style: TextStyle(color: Colors.black87)),
                    Icon(Icons.arrow_drop_down, color: Colors.black87),
                    SizedBox(width: 16),
                  ],
                ),
              ),
            ],
          ),
          body: _selectedScreen,
          sideBar: SideBar(
            header: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/image/me.jpg'),
                    radius: 26,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'admin@admin.com',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            items: const [
              AdminMenuItem(
                title: 'Dashboard',
                route: DashboardScreen.ID,
                icon: CupertinoIcons.home,
              ),
              AdminMenuItem(
                title: 'Posts',
                route: PostScreen.ID,
                icon: CupertinoIcons.paperplane_fill,
              ),
              AdminMenuItem(
                title: 'Products',
                route: GetScreen.ID,
                icon: CupertinoIcons.cube_box_fill,
              ),
              AdminMenuItem(
                title: 'Orders',
                route: PaymentScreen.ID,
                icon: CupertinoIcons.cart_fill,
              ),
              AdminMenuItem(
                title: 'Customers',
                route: BuyerScreen.ID,
                icon: CupertinoIcons.person_2_fill,
              ),
              AdminMenuItem(
                title: 'Reports',
                route: ReportScreen.ID,
                icon: CupertinoIcons.chart_bar_fill,
              ),
              AdminMenuItem(
                title: 'Settings',
                route: SettingScreen.ID,
                icon: CupertinoIcons.settings_solid,
              ),
            ],

            selectedRoute: DashboardScreen.ID,
            onSelected: screenSelector,
          ),
        ),
      ],
    );
  }
}
