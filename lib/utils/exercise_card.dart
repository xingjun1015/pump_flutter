import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_app_flutter/controller/exercise_controller.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseController exerciseController;

  ExerciseCard(
      {super.key,
      required this.exerciseController,});

  @override
  Widget build(BuildContext context) {
    final nameController = exerciseController.name;
    final weightController = exerciseController.weight;
    final setController = exerciseController.set;
    final repeatController = exerciseController.repeat;

    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Exercise name',
                  hintStyle: TextStyle(
                    letterSpacing: 1,
                  )),
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                      controller: weightController,
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: 3,
                      decoration: const InputDecoration(
                        counterText: '',
                      )),
                ),
                const Text('kg'),
                const SizedBox(width: 30),
                Flexible(
                  flex: 2,
                  child: TextField(
                    controller: setController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    maxLength: 3,
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: 'Set',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('x'),
                const SizedBox(width: 10),
                Flexible(
                  flex: 2,
                  child: TextField(
                    controller: repeatController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    maxLength: 3,
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: 'Repeat',
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
