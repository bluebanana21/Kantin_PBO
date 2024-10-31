import 'package:flutter/material.dart';
import 'package:kantin_app/widgets/cart_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    "Cart",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
              const SizedBox(
                height: 60,
              ),
              const Column(
                children: [
                  CartCard(
                    image: 'assets/burger.jpeg',
                    name: "burger king medium",
                    price: "50.000",
                    amount: "1",
                  ),
                  CartCard(
                    image: 'assets/burger.jpeg',
                    name: "burger king medium",
                    price: "50.000",
                    amount: "1",
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 40,
                            top: 30,
                            right: 40,
                            // bottom: 20,
                          ),
                          child: Text(
                            'Ringkasan Belanja',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 40,
                            top: 8,
                            right: 40,
                            // bottom: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'PPN 11%',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Text(
                                'Rp 10.000,00',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 40,
                            top: 8,
                            right: 40,
                            // bottom: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total belanja',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Rp 94.000,00',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 40,
                            top: 8,
                            right: 40,
                            // bottom: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Pembayaran',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Rp 104.000,00',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
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
                              'Checkout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
