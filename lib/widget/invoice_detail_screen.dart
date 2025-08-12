import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final Map<String, dynamic> invoice;

  const InvoiceDetailScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> purchasedProducts = [
      {'name': 'គ្រឿងអេឡិចត្រូនិច A', 'qty': 2, 'price': 30.0},
      {'name': 'គ្រឿងអេឡិចត្រូនិច B', 'qty': 1, 'price': 60.0},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ព័ត៌មានលម្អិតវិក័យប័ត្រ',
          style: GoogleFonts.kantumruyPro(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 58, 92, 231),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🧾 Invoice Summary Header
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'លេខវិក័យប័ត្រ: ${invoice['invoiceId']}',
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'អតិថិជន: ${invoice['customerName']}',
                    style: GoogleFonts.kantumruyPro(),
                  ),
                  Text(
                    'កាលបរិច្ឆេទ: ${invoice['date']}',
                    style: GoogleFonts.kantumruyPro(),
                  ),
                  Text(
                    'ស្ថានភាព: ${invoice['status']}',
                    style: GoogleFonts.kantumruyPro(),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 📦 Product List
          Text(
            'បញ្ជីផលិតផល:',
            style: GoogleFonts.kantumruyPro(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...purchasedProducts.map((product) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 181, 196, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: const Color.fromARGB(255, 58, 92, 231),
                  ),
                ),
                title: Text(
                  product['name'],
                  style: GoogleFonts.kantumruyPro(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'ចំនួន: ${product['qty']}',
                  style: GoogleFonts.kantumruyPro(fontWeight: FontWeight.w600),
                ),
                trailing: Text(
                  '\$${product['price'].toStringAsFixed(2)}',
                  style: GoogleFonts.kantumruyPro(fontWeight: FontWeight.w600),
                ),
              ),
            );
          }),

          const Divider(),

          // 💰 Total
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'សរុប: \$${invoice['total'].toStringAsFixed(2)}',
              style: GoogleFonts.kantumruyPro(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
