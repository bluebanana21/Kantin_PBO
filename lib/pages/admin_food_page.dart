import 'package:flutter/material.dart';
import 'package:kantin_app/pages/form_food.dart';
import 'package:kantin_app/widgets/form_food_entry.dart';

class AdminFoodPage extends StatelessWidget {
  const AdminFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FormFood(),
                        ),
                      );
                    },
                    label: const Text(
                      "Add Food",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Foto"),
                      Text("Nama produk"),
                      Text("harga"),
                      Text("Aksi"),
                    ],
                  ),
                ),
                const Divider(),
                const FormFoodEntry(
                  image: "assets/burger.jpeg",
                  name: "Burger king medium",
                  price: "50.000",
                ),
                const Divider(),
                const FormFoodEntry(
                  image: "assets/burger.jpeg",
                  name: "Burger king medium",
                  price: "50.000",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
