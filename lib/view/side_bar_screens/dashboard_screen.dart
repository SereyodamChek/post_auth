import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  static const String ID = 'dashboardScreen';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/background.png',
              fit: BoxFit.cover,
              alignment: Alignment.center, // Ensures the top is always visible
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back, Admin 👋',
                  style: GoogleFonts.kantumruyPro(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),

                // Statistic Cards (use Wrap for responsive layout)
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    DashboardCard(
                      title: 'Total Users',
                      value: '1,230',
                      icon: CupertinoIcons.person_2,
                      color: Colors.blue,
                    ),
                    DashboardCard(
                      title: 'Products Sold',
                      value: '865',
                      icon: CupertinoIcons.shopping_cart,
                      color: const Color.fromARGB(255, 211, 191, 8),
                    ),
                    DashboardCard(
                      title: 'Payments',
                      value: '\$12.4K',
                      icon: CupertinoIcons.money_dollar_circle,
                      color: const Color.fromARGB(255, 0, 81, 255),
                    ),
                    DashboardCard(
                      title: 'Money Earned',
                      value: '\$18.9K',
                      icon: CupertinoIcons.money_dollar_circle_fill,
                      color: const Color.fromARGB(255, 10, 207, 36),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
                const Text(
                  'Recent Activity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                _buildRecentTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTable() {
    return Card(
      elevation: 3,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('User')),
            DataColumn(label: Text('Action')),
            DataColumn(label: Text('Date')),
          ],
          rows: const [
            DataRow(
              cells: [
                DataCell(Text('John Doe')),
                DataCell(Text('Placed an order')),
                DataCell(Text('2025-07-20')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Jane Smith')),
                DataCell(Text('Registered')),
                DataCell(Text('2025-07-19')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Alice Johnson')),
                DataCell(Text('Left a review')),
                DataCell(Text('2025-07-18')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 24, // Responsive width
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: color),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
