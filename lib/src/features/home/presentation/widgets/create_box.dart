import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateBox extends StatelessWidget {
  String name;
  String subjectId;
  CreateBox({super.key, required this.name, required this.subjectId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            context.push("/studytopics/$subjectId");
          },
          child: Container(
            height: 140,
            width: 180,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(33, 150, 243, 1),
              border: BoxBorder.all(width: 8, color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                name,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
