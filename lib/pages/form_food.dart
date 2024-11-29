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

  String? _selectedCategory;
  final List<String> _categories = [
    "Drinks",
    "Snacks",
    "Main Course",
    "Desserts"
  ];

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(
        () {
          _imageFile = File(image.path);
        },
      );
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
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    mini: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    mini: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Food Name",
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Price",
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: const Text("Select Category"),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      _selectedCategory = newValue;
                    },
                  );
                },
                items: _categories
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  labelText: "Category",
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _imageFile == null
                      ? const Center(
                          child: Text(
                            "Tap to pick image",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : Image.file(
                          _imageFile!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final name = _nameController.text;
                  final price = int.tryParse(_priceController.text);
                  final category = _selectedCategory;

                  var imageUrl = await uploadImage('uploads');
                  if (imageUrl == null) return;

                  await supabase.from('Makanan').insert(
                    {
                      'Nama': name,
                      'Harga': price,
                      'Kategori': category,
                      'Image_url': imageUrl,
                    },
                  );

                  setState(
                    () {
                      _nameController.clear();
                      _priceController.clear();
                      _selectedCategory = null;
                      imageUrl = null;
                    },
                  );

                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
