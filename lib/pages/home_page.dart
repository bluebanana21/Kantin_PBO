import 'package:flutter/material.dart';
import 'package:kantin_app/widgets/food_button.dart';
import 'package:kantin_app/widgets/food_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
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
                    child: const Icon(Icons.menu, color: Colors.black, size: 25),
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
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: const Align(
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
                children: const [
                  FoodCard(
                    image: 'assets/burger.jpeg',
                    name: "Burger King medium",
                    price: "50.000",
                  ),
                  FoodCard(
                    image: 'assets/burger.jpeg',
                    name: "Burger King medium",
                    price: "50.000",
                  ),
                  FoodCard(
                    image: 'assets/burger.jpeg',
                    name: "Burger King medium",
                    price: "50.000",
                  ),
                  FoodCard(
                    image: 'assets/burger.jpeg',
                    name: "Burger King medium",
                    price: "50.000",
                  ),
                  FoodCard(
                    image: 'assets/burger.jpeg',
                    name: "Burger King medium",
                    price: "50.000",
                  ),
                  FoodCard(
                    image: 'assets/burger.jpeg',
                    name: "Burger King medium",
                    price: "50.000",
                  ),
                  FoodCard(
                    image: 'assets/burger.jpeg',
                    name: "Burger King medium",
                    price: "50.000",
                  ),
                  FoodCard(
                    image: 'assets/burger.jpeg',
                    name: "Burger King medium",
                    price: "50.000",
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
