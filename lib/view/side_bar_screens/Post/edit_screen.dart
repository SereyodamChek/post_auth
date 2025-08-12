import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:post_auth/model/product_model.dart';

class EditScreen extends StatefulWidget {
  static const String ID = 'editScreen';
  final String? imageUrl;
  final ProductModel product;
  static const String id = 'edit-product';

  const EditScreen({super.key, required this.product, this.imageUrl});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _descCtrl;
  late TextEditingController _priceCtrl;
  String? _selectedCategory;
  DateTime? _selectedDate;

  File? _imageFile;
  String? _existingImageUrl;

  // Make _categoryList static const since it never changes
  static const List<String> _categoryList = [
    'Phones',
    'Computers',
    'Beds/Chairs',
    'Watches',
    'Sports',
    'Toys',
  ];

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.product.name);
    _descCtrl = TextEditingController(text: widget.product.description);
    _priceCtrl = TextEditingController(text: widget.product.price.toString());
    // Initialize selected category safely
    _selectedCategory = _categoryList.contains(widget.product.category)
        ? widget.product.category
        : _categoryList.first;
    _selectedDate = widget.product.createdAt;
    _existingImageUrl = widget.product.imageUrl;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
      return;
    }

    try {
      String imageUrl = _existingImageUrl ?? "";

      if (_imageFile != null) {
        final cloudinary = CloudinaryPublic(
          'dk7rrqx1j',
          'ProductApp656',
          cache: false,
        );
        final cloudinaryRes = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            _imageFile!.path,
            folder: "Admin",
            resourceType: CloudinaryResourceType.Image,
          ),
        );
        imageUrl = cloudinaryRes.secureUrl;
      }

      final updatedProduct = ProductModel(
        id: widget.product.id,
        name: _nameCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        price: double.tryParse(_priceCtrl.text) ?? 0.0,
        category: _selectedCategory ?? '',
        imageUrl: imageUrl,
        createdAt: _selectedDate!,
      );

      final res = await http.put(
        Uri.parse(
          'https://post-product-beac8-default-rtdb.asia-southeast1.firebasedatabase.app/products/${widget.product.id}.json',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedProduct.toJson()),
      );

      if (res.statusCode == 200) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product updated successfully')),
        );
        Navigator.pop(context);
      } else {
        throw Exception('Failed to update');
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error updating product')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  prefixIcon: const Icon(Icons.shopping_bag),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descCtrl,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  prefixIcon: const Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _priceCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                  prefixIcon: const Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                validator: (v) => double.tryParse(v ?? '') == null
                    ? 'Enter valid price'
                    : null,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categoryList
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val),
                decoration: InputDecoration(
                  labelText: 'Category',
                  prefixIcon: const Icon(Icons.category),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  const SizedBox(width: 8),
                  Text(
                    _selectedDate != null
                        ? 'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}'
                        : 'No Date Chosen',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.date_range),
                    label: const Text('Pick Date'),
                    onPressed: _pickDate,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                  image: _imageFile != null
                      ? DecorationImage(
                          image: FileImage(_imageFile!),
                          fit: BoxFit.cover,
                        )
                      : _existingImageUrl != null && _existingImageUrl!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(_existingImageUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                ),
                child: (_imageFile == null &&
                        (_existingImageUrl == null || _existingImageUrl!.isEmpty))
                    ? Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 32,
                            color: Colors.grey[700],
                          ),
                          onPressed: _pickImage,
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 16),

              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Change Image"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.save),
                label: const Text("Update Product"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
