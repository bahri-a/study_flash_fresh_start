import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateBox extends StatelessWidget {
  String name;

  CreateBox({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            context.push("/studytopics");
          },
          child: Container(
            height: 140,
            width: 180,
            decoration: BoxDecoration(
              color: Colors.blue,
              border: BoxBorder.all(width: 8, color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
