import 'package:flutter/material.dart';
import 'package:kantin_app/widgets/form_food_input.dart';

class FormFood extends StatelessWidget {
  const FormFood({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
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
                    const FormFoodInput(
                      label: "Kategori Produk",
                      placeholder: "Makanan",
                    ),
                    const FormFoodInput(
                      label: "Image",
                      placeholder: "Choose file",
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
}
