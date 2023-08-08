import 'package:flutter/material.dart';
import 'package:gym_app_flutter/data/database.dart';

class WorkoutDetailScreen extends StatefulWidget {
  const WorkoutDetailScreen({super.key});

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  var data;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text(data['title']),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_forever_rounded),
              onPressed: () {
                showDeleteConfirmationDialog(context, data['id']);
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage:
                      AssetImage(data['workoutIcon']),
                  radius: 100,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[800],
                ),
                child: IconButton(
                  icon: const Icon(Icons.edit_square),
                  color: Colors.white,
                  onPressed: () async {
                    // Edit workout
                    dynamic result = await Navigator.pushNamed(context, '/edit_workout', arguments: {
                      'id':data['id'],
                      'title':data['title'],
                      'workouts':data['workouts'],
                      'workoutIcon':data['workoutIcon'],
                    });

                    setState(() {
                      data['title']=result[0];
                      data['workouts']=result[1];
                      data['workoutIcon']=result[2];
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (Map workout in data['workouts'])
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '- ${workout['name']}: ${workout['weight']}kg',
                                  style: const TextStyle(letterSpacing: 0.5),
                                ),
                                Text(
                                  '${workout['set']} x ${workout['repeat']}',
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

showDeleteConfirmationDialog(BuildContext context, id) {
  
  AlertDialog alertDialog = AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded),
    title: const Text(
      'Delete Workout',
      style: TextStyle(fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    content: const Text(
      'Are you sure you want to delete this workout?',
      textAlign: TextAlign.center,
    ),
    actionsAlignment: MainAxisAlignment.spaceAround,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    actions: [
      TextButton(
        child: const Text('Delete', style: TextStyle(color: Colors.red)),
        onPressed: () {
          gymDatabase db = gymDatabase();
          db.deleteDataByID(id);
          
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
      ),
      TextButton(
        child: const Text('Cancel'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ],
  );

  showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      });
}