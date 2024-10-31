import 'package:flutter/material.dart';

class FoodButton extends StatelessWidget {
  final dynamic image;
  final dynamic text;

  const FoodButton({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.all(10),
              child: FittedBox(
                fit: BoxFit.fill,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    image,
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(text),
      ],
    );
  }
}
