import 'package:flutter/material.dart';

class CartCard extends StatelessWidget {
  final dynamic image;
  final dynamic name;
  final dynamic price;
  final dynamic amount;

  const CartCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20), // Image border
            child: SizedBox.fromSize(
              size: const Size.fromRadius(48),
              // Image radius
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              Text(name),
              Text(price),
              Row(
                children: [
                  Transform.scale(
                    scale: 0.5,
                    child: FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.add),
                    ),
                  ),
                  Text("1"),
                  Transform.scale(
                    scale: 0.5,
                    child: FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.remove),
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
