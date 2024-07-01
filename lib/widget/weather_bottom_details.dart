import '../models/dataModel.dart';
import 'package:flutter/material.dart';

class weather_details_widget extends StatelessWidget {
  weather_details_widget(
      {super.key,
      required this.color,
      required this.name,
      required this.Ms,
      required this.degree,
      required this.value});

  DataModels? dataModels;

  Color color;
  String name;
  bool Ms;
  bool degree;
  String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          value,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Ms
            ? Text("m/s", style: TextStyle(color: Colors.white, fontSize: 14))
            : Text(""),
        const SizedBox(
          height: 5,
        ),
        degree
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                        color: color, borderRadius: BorderRadius.circular(2)),
                  ),
                  Container(
                    width: 40,
                    height: 3,
                    color: Colors.white24,
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
