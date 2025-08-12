// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PostScreen extends StatefulWidget {
  static const String ID = 'postScreen';
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namectrl = TextEditingController();
  final _descriptionctrl = TextEditingController();
  final _pricectrl = TextEditingController();

  final _categoryList = [
  'Phones',
  'Computers',
  'Beds/Chairs',
  'Watches',
  'Sports',
  'Toys',
];
String? _selectedCategory = null; // no category selected initially

  DateTime? _selectedDate;
  File? _imageFile;
  Uint8List? _image; // Store for Cloudinary upload

  @override
  void dispose() {
    _namectrl.dispose();
    _descriptionctrl.dispose();
    _pricectrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final imageBytes = await file.readAsBytes();

      setState(() {
        _imageFile = file;
        _image = imageBytes; // Store for Cloudinary upload
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      if (_imageFile == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please upload an image")));
        return;
      }

      try {
        final cloudinary = CloudinaryPublic(
          'dk7rrqx1j', // your Cloud name
          'ProductApp656', // your real unsigned upload preset
          cache: false,
        );

        CloudinaryResponse cloudinaryRes = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            _imageFile!.path,
            folder: "Admin", // optional
            resourceType: CloudinaryResourceType.Image,
          ),
        );

        Map<String, dynamic> productData = {
          'name': _namectrl.text,
          'description': _descriptionctrl.text,
          'price': double.tryParse(_pricectrl.text) ?? 0.0,
          'category': _selectedCategory,
          'imageUrl': cloudinaryRes.secureUrl, // Use the uploaded image URL
          'createdAt': DateTime.now().toIso8601String(),
        };

        final res = await http.post(
          Uri.parse(
            'https://post-product-beac8-default-rtdb.asia-southeast1.firebasedatabase.app/products.json',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(productData),
        );

        if (!mounted) return;

        if (res.statusCode == 200 || res.statusCode == 201) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Product added successfully')));
          _formKey.currentState!.reset();
          setState(() {
            _imageFile = null;
            _image = null; // Reset the image after successful upload
            _selectedCategory = 'Electronics'; // Reset to default category
            _selectedDate = null; // Reset date selection
          });
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to add product')));
        }
      } catch (e) {
        print("Upload error: $e");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error uploading image')));
      }
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a date')));
    }
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _buildFieldWithBorder({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
                children: [
                /// Image Upload
                InkWell(
                  onTap: _pickImage,
                  child: Container(
                  width: screenWidth,
                  height: 180,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    image: _imageFile != null
                      ? DecorationImage(
                        image: FileImage(_imageFile!),
                        fit: BoxFit.cover,
                      )
                      : null,
                  ),
                  child: _imageFile == null
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.grey,
                        ),
                        SizedBox(height: 8),
                        Text(
                        "បញ្ចូលរូបភាពផលិតផល",
                        style: TextStyle(color: Colors.grey),
                        ),
                      ],
                      )
                    : null,
                  ),
                ),

                /// Product Name
                _buildFieldWithBorder(
                  child: Row(
                  children: [
                    const Icon(Icons.shopping_bag, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                    child: TextFormField(
                      controller: _namectrl,
                      decoration: _inputDecoration("ឈ្មោះផលិតផល"),
                      validator: (v) =>
                        v!.isEmpty ? 'ត្រូវបញ្ចូលឈ្មោះផលិតផល' : null,
                    ),
                    ),
                  ],
                  ),
                ),

                /// Description
                _buildFieldWithBorder(
                  child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                    child: TextFormField(
                      controller: _descriptionctrl,
                      decoration: _inputDecoration("ពិពណ៌នាផលិតផល"),
                      maxLines: 3,
                      validator: (v) =>
                        v!.isEmpty ? 'ត្រូវបញ្ចូលពិពណ៌នា' : null,
                    ),
                    ),
                  ],
                  ),
                ),

                /// Price
                _buildFieldWithBorder(
                  child: Row(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                    child: TextFormField(
                      controller: _pricectrl,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration("តម្លៃ (USD)"),
                      validator: (v) {
                      if (v!.isEmpty) return 'ត្រូវបញ្ចូលតម្លៃ';
                      final price = double.tryParse(v);
                      return price == null ? 'តម្លៃមិនត្រឹមត្រូវ' : null;
                      },
                    ),
                    ),
                  ],
                  ),
                ),

                /// Category Dropdown
                _buildFieldWithBorder(
                  child: Row(
                  children: [
                    const Icon(Icons.category, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: _inputDecoration("ជ្រើសប្រភេទ"),
                      items: _categoryList
                        .map(
                        (c) =>
                          DropdownMenuItem(value: c, child: Text(c)),
                        )
                        .toList(),
                      onChanged: (v) =>
                        setState(() => _selectedCategory = v),
                    ),
                    ),
                  ],
                  ),
                ),

                /// Date Picker
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                  children: [
                    const Icon(Icons.date_range, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                    child: Text(
                      _selectedDate != null
                        ? 'កាលបរិច្ឆេទ: ${_selectedDate!.toLocal().toString().split(' ')[0]}'
                        : 'ជ្រើសកាលបរិច្ឆេទ',
                      style: const TextStyle(fontSize: 16),
                    ),
                    ),
                    ElevatedButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.date_range),
                    label: const Text(
                      "ជ្រើសកាលបរិច្ឆេទ",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                      ),
                    ),
                    ),
                  ],
                  ),
                ),

                const SizedBox(height: 10),

                /// Submit Button (width reduced)
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                  width: 180, // Set your desired width here
                  child: ElevatedButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.send, color: Colors.deepPurple),
                    label: const Text(
                    "Add Product",
                    style: TextStyle(color: Colors.deepPurple),
                    ),
                    style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 238, 238, 238),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    ),
                  ),
                  ),
                ),
                ],
            
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: InputBorder.none,
      labelStyle: const TextStyle(fontWeight: FontWeight.w500),
    );
  }
}
