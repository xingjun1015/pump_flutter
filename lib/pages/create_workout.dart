import 'package:flutter/material.dart';
import 'package:gym_app_flutter/controller/exercise_controller.dart';
import 'package:gym_app_flutter/data/database.dart';
import 'package:gym_app_flutter/utils/exercise_card.dart';
import 'package:gym_app_flutter/utils/exercise_icon_selector.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({super.key});

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  final _titleController = TextEditingController();
  final _formCreateWorkoutKey = GlobalKey();

  // Image selector
  var _selectedImageIndex = 0;
  final _images = [
    "assets/icons/bench_press.png",
    "assets/icons/bicep.png",
    "assets/icons/body.png",
    "assets/icons/deadlift.png",
    "assets/icons/leg.png",
    "assets/icons/pullup.png",
    "assets/icons/pushup.png",
    "assets/icons/squat.png",
    "assets/icons/trendmill.png",
  ];

  var selectedImageName = 'assets/icons/bench_press.png';

  void showIconSelectorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Select an Icon',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: Wrap(
                spacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  for (int i = 0; i < _images.length; i++)
                    ExerciseIconSelector(
                      isSelected: _selectedImageIndex == i,
                      onTap: (selectedImageIndex) {
                        setState(() {
                          _selectedImageIndex = i;
                        });
                      },
                      imageAsset: _images[i],
                    ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.spaceAround,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              actions: [
                TextButton(
                  child: const Text('Confirm'),
                  onPressed: () {
                    Navigator.pop(context);
                    selectedImageName = _images[_selectedImageIndex];
                  },
                ),
                TextButton(
                  child:
                      const Text('Cancel', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
        }).then((value) => setState(() {}));
  }

  List listCard = [];
  List listController = [];

  void addExercise() {
    ExerciseController exerciseController = ExerciseController(
        name: TextEditingController(),
        weight: TextEditingController(),
        set: TextEditingController(),
        repeat: TextEditingController());
    listController.add(exerciseController);
    listCard.add(ExerciseCard(
      exerciseController: exerciseController,
    ));

    setState(() {});
  }

  void removeExercise() {
    ExerciseController lastController = listController.last;
    lastController.name.dispose();
    lastController.weight.dispose();
    lastController.set.dispose();
    lastController.repeat.dispose();

    listController.removeLast();
    listCard.removeLast();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    addExercise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Create Workout'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formCreateWorkoutKey,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    showIconSelectorDialog(context);
                  },
                  icon: Image.asset(selectedImageName),
                  iconSize: 70,
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  color: Colors.grey[800],
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: 'Title',
                          hintStyle:
                              TextStyle(letterSpacing: 1, color: Colors.white)),
                    ),
                  ),
                ),
                for (ExerciseCard card in listCard) card,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          addExercise();
                        },
                        child: const Text('Add')),
                    TextButton(
                        onPressed: listCard.length > 0
                            ? () {
                                removeExercise();
                              }
                            : null,
                        child: const Text('Remove')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              padding: const EdgeInsets.symmetric(vertical: 15)),
          child: const Text('Save'),
          onPressed: () {

            gymDatabase db = gymDatabase();
            List workoutList = [];

            for (var element in listController) {
              workoutList.add({
                'name': element.name.text,
                'weight': element.weight.text,
                'set': element.set.text,
                'repeat': element.repeat.text
              });
            }

            List inputDataArray = [
              _titleController.text, workoutList, selectedImageName
            ];

            db.createData(inputDataArray);

            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
