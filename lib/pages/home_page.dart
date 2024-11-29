import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kantin_app/main.dart';
import 'package:kantin_app/widgets/food_button.dart';
import 'package:kantin_app/widgets/food_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _imageFile;

  Future<List<dynamic>> fetchData() async {
    final response = await supabase.from('Makanan').select('*');
    return response as List<dynamic>;
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future uploadImage() async {
    if (_imageFile == null) return;

    final fileName = DateTime.now().millisecondsSinceEpoch;
    final path = 'uploads/$fileName';
    await supabase.storage.from('foodImages').upload(path, _imageFile!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {},
                      mini: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.menu, color: Colors.black),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {},
                      mini: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:
                          const Icon(Icons.person_outline, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FoodButton(
                      image: "assets/burger.jpeg",
                      text: "All",
                    ),
                    FoodButton(
                      image: "assets/burger.jpeg",
                      text: "Makanan",
                    ),
                    FoodButton(
                      image: "assets/coke.png",
                      text: "Minuman",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "All Food",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.05,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No data found');
                  } else {
                    final data = snapshot.data!;
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: size.width > 600 ? 3 : 2,
                          crossAxisSpacing: size.width * 0.04,
                          mainAxisSpacing: size.height * 0.02,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          final imageUrl = item['Image_url'] ??
                              'https://via.placeholder.com/150';
                          return FoodCard(
                            image: imageUrl,
                            name: item['Nama'] ?? 'N/A',
                            price: item['Harga'].toString() ?? 'N/A',
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
