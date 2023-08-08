import 'package:flutter/material.dart';

class ExerciseController {
  final TextEditingController name;
  final TextEditingController weight;
  final TextEditingController set;
  final TextEditingController repeat;

  ExerciseController({
    required this.name,
    required this.weight,
    required this.set,
    required this.repeat,
  });
}