import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_auth/widget/invoice_detail_screen.dart';

class BuyerScreen extends StatelessWidget {
  static const String ID = 'buyerScreen';

  const BuyerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final List<Map<String, dynamic>> invoiceList = [
      {
        'invoiceId': 'INV001',
        'customerName': 'Chan Dara',
        'date': '2025-07-20',
        'total': 120.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV002',
        'customerName': 'Sok Sreymom',
        'date': '2025-07-19',
        'total': 45.50,
        'status': 'Pending',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
      {
        'invoiceId': 'INV003',
        'customerName': 'Kim Veasna',
        'date': '2025-07-18',
        'total': 300.00,
        'status': 'Paid',
      },
    ];

    return Scaffold(
      // appBar: AppBar(title: const Text('បញ្ជីវិក័យប័ត្រ'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: invoiceList.length,
        itemBuilder: (context, index) {
          final invoice = invoiceList[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(FontAwesomeIcons.receipt),
              title: Text(
                'លេខវិក័យប័ត្រ: ${invoice['invoiceId']}',
                style: GoogleFonts.kantumruyPro(fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'អតិថិជន: ${invoice['customerName']}',
                    style: GoogleFonts.kantumruyPro(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'កាលបរិច្ឆេទ: ${invoice['date']}',
                    style: GoogleFonts.kantumruyPro(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'ស្ថានភាព: ${invoice['status']}',
                    style: GoogleFonts.kantumruyPro(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              trailing: Text(
                '\$${invoice['total'].toStringAsFixed(2)}',
                style: GoogleFonts.kantumruyPro(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InvoiceDetailScreen(invoice: invoice),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
