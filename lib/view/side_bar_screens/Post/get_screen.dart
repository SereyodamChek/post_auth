import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_auth/model/product_model.dart';
import 'package:post_auth/view/side_bar_screens/Post/edit_screen.dart';

class GetScreen extends StatefulWidget {
  static const String ID = 'getScreen';

  const GetScreen({super.key});

  @override
  State<GetScreen> createState() => _GetScreenState();
}

class _GetScreenState extends State<GetScreen> {
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  Future<void> fetchAll() async {
    final res = await http.get(
      Uri.parse(
        'https://post-product-beac8-default-rtdb.asia-southeast1.firebasedatabase.app/products.json',
      ),
    );
    if (res.statusCode == 200 && res.body != 'null') {
      final Map<String, dynamic> data = json.decode(res.body);
      final List<ProductModel> loaded = [];

      data.forEach((key, value) {
        loaded.add(
          ProductModel.fromJson({
            "id": key, // use Firebase's auto-generated key as ID
            ...value, // merge the remaining data
          }),
        );
      });

      setState(() {
        products = loaded;
      });
    } else {
      setState(() {
        products = [];
      });
    }
  }

  void _editProduct(ProductModel product) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditScreen(product: product)),
    );
  }

  void _deleteProduct(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this student?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final res = await http.delete(
      Uri.parse(
        'https://product2025-c3e57-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json',
      ),
    );
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Deleted successfully')));
      fetchAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: fetchAll,
      child: products.isEmpty
          ? ListView(
              children: const [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(.0),
                    child: Text("No products found."),
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(p.imageUrl),
                    ),
                    title: Text(p.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.category,
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                        Text(
                          "${p.price} \$",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: const Color.fromARGB(255, 28, 1, 237),
                          ),
                          onPressed: () => _editProduct(p),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: const Color.fromARGB(255, 242, 16, 0),
                          ),
                          onPressed: () => _deleteProduct(p.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
