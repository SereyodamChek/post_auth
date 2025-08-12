import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  static const String ID = 'reportScreen';
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Report'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryCard(
                  title: "Total Sales",
                  value: "\$12,300",
                  icon: Icons.attach_money,
                  color: Colors.green,
                ),
                _buildSummaryCard(
                  title: "Orders",
                  value: "243",
                  icon: Icons.shopping_cart,
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryCard(
                  title: "Returns",
                  value: "12",
                  icon: Icons.undo,
                  color: Colors.redAccent,
                ),
                _buildSummaryCard(
                  title: "Customers",
                  value: "87",
                  icon: Icons.person,
                  color: Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Text(
              "Top Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Table/List of products
            _buildProductRow("Nike Air Max", 120, 34),
            _buildProductRow("Adidas Hoodie", 80, 21),
            _buildProductRow("iPhone Case", 50, 15),
            _buildProductRow("Gaming Mouse", 75, 19),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 28, color: color),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color),
              ),
              const SizedBox(height: 4),
              Text(title, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductRow(String name, int sales, int orders) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.shopping_bag)),
      title: Text(name),
      subtitle: Text("Sold: $sales • Orders: $orders"),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
