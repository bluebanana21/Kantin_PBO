import 'package:flutter/material.dart';
import 'package:kantin_app/main.dart';

class FoodCard extends StatelessWidget {
  final dynamic id;
  final dynamic category;
  final dynamic image;
  final dynamic name;
  final dynamic price;

  const FoodCard({
    super.key,
    required this.id,
    required this.category,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      width: 50,
      height: 120,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centers content vertically
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20), // Image border
            child: SizedBox(
              width: 100, // Adjust width to match the container or desired size
              height: 100, // Adjust height to keep it proportional
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              ),
            ),
          ),
          const SizedBox(height: 8), // Add spacing between image and text
          Text(name, textAlign: TextAlign.center), // Ensures centered text
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(price),
                Transform.scale(
                  scale: 0.7,
                  child: IconButton(
                    onPressed: () async {
                      print("moved to cart");
                      await supabase.from('cart').insert(
                        {
                          'food_id': id,
                          'food_name': name,
                          'food_price': price,
                          'food_category': category,
                          'food_image': image,
                        },
                      );
                    },
                    icon: const Icon(Icons.add),
                    iconSize: 25,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
