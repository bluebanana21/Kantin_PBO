import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kantin_app/widgets/form_food_input.dart';

class FormFood extends StatelessWidget {
  FormFood({super.key});

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                    const FormFoodInput(
                      label: "Nama Produk",
                      placeholder: "Masukan Nama Produk",
                    ),
                    const FormFoodInput(
                      label: "Harga",
                      placeholder: "Masukan Harga",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "data",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white60,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    BorderSide.none, // Remove the border line
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    BorderSide.none, // Remove the border line
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    BorderSide.none, // Remove the border line
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: const Text("Pilih kategori"),
                                isDense: true,
                                isExpanded: true,
                                items: const [
                                  DropdownMenuItem(
                                    value: "Makanan",
                                    child: Text("Makanan"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Minuman",
                                    child: Text("Minuman"),
                                  ),
                                ],
                                onChanged: (newValue) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Select Image",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            onTap: _pickImage,
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(color: Colors.transparent),
                              ),
                              child: _selectedImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: Image.file(
                                        _selectedImage!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        "Tap to select an image",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Action for the Checkout button
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
      ),
    );
  }

  void setState(Null Function() param0) {}

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
}
