import 'package:flutter/material.dart';

class FormFoodInput extends StatelessWidget {
  final dynamic label;
  final dynamic placeholder;

  const FormFoodInput({
    super.key,
    required this.label,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              // color: Colors.red,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: placeholder,
              filled: true,
              fillColor: Colors.white60,
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none, // Remove the border line
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none, // Remove the border line
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none, // Remove the border line
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
