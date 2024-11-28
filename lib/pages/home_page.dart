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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    onPressed: () {},
                    mini: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:
                        const Icon(Icons.menu, color: Colors.black, size: 25),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    FoodButton(
                      image: "assets/burger.jpeg",
                      text: "All",
                    )
                  ],
                ),
                Column(
                  children: [
                    FoodButton(
                      image: "assets/burger.jpeg",
                      text: "Makanan",
                    )
                  ],
                ),
                Column(
                  children: [
                    FoodButton(
                      image: "assets/coke.png",
                      text: "Minuman",
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "All Food",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Flexible(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                children: [
                  const FoodCard(
                    image: 'assets/burger.jpeg',
                    name: "Burger King medium",
                    price: "50.000",
                  ),
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
                        return DataTable(
                          columns: const <DataColumn>[
                            DataColumn(label: Text("Image")),
                            DataColumn(label: Text("Name")),
                            DataColumn(label: Text("Price")),
                          ],
                          rows: data.map<DataRow>((item) {
                            final imageUrl = item['image_url'] ??
                                'https://via.placeholder.com/150';
                            return DataRow(
                              cells: [
                                DataCell(
                                  Image.network(
                                    imageUrl,
                                    width: 50,
                                    height: 50,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image),
                                  ),
                                ),
                                DataCell(Text(item['Nama'] ?? 'N/A')),
                                DataCell(
                                    Text(item['Harga']?.toString() ?? 'N/A')),
                              ],
                            );
                          }).toList(),
                        );
                      }
                    },
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
