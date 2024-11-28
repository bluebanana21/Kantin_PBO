import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kantin_app/main.dart';

class FormFood extends StatefulWidget {
  const FormFood({super.key});

  @override
  State<FormFood> createState() => _FormFoodState();
}

class _FormFoodState extends State<FormFood> {
  File? _imageFile;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? _selectedCategory; // To store the selected category
  final List<String> _categories = [
    "Drinks",
    "Snacks",
    "Main Course",
    "Desserts"
  ]; // Example categories

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future<String?> uploadImage(String path) async {
    if (_imageFile == null) return null;

    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final uploadPath = 'uploads/$fileName';

    final response = await supabase.storage
        .from('foodImages')
        .upload(uploadPath, _imageFile!);

    return supabase.storage.from('foodImages').getPublicUrl(uploadPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    onPressed: () {},
                    mini: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.person_outline,
                        color: Colors.black, size: 25),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Price"),
                  ),

                  // Dropdown for category selection
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      hint: const Text("Select Category"),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                      items: _categories
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Category",
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: pickImage,
                    child: const Text("pick image"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final name = _nameController.text;
                          final price = int.tryParse(_priceController.text);
                          final category = _selectedCategory;

                          var imageUrl = await uploadImage('uploads');
                          if (imageUrl == null) return;

                          // if (name.isEmpty ||
                          //     price == null ||
                          //     category == null) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //       content: Text("Please complete all fields!"),
                          //     ),
                          //   );
                          //   return;
                          // }

                          await supabase.from('Makanan').insert({
                            'Nama': name,
                            'Harga': price,
                            'Kategori': category,
                            'Image_url': imageUrl,
                          });

                          setState(() {
                            _nameController.clear();
                            _priceController.clear();
                            _selectedCategory = null;
                            imageUrl = null;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 100,
                            vertical: 15,
                          ),
                          backgroundColor: Colors.blue, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
