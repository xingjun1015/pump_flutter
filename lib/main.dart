import 'package:flutter/material.dart';
import 'package:gym_app_flutter/data/database.dart';
import 'package:gym_app_flutter/pages/create_workout.dart';
import 'package:gym_app_flutter/pages/edit_workout.dart';
import 'package:gym_app_flutter/pages/workout_detail.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  await Hive.initFlutter();

  // open a box
  await Hive.openBox('gymBox');
  gymDatabase db = gymDatabase();

  db.loadData();

  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Pixeloid'),
    initialRoute: '/',
    routes: {
      '/': (context) => const Home(),
      '/workout_detail': (context) => const WorkoutDetailScreen(),
      '/create_workout': (context) => const CreateWorkoutScreen(),
      '/edit_workout': (context) => const EditWorkoutScreen(),
    },
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    gymDatabase db = gymDatabase();
    var workoutList = db.loadData();
    var workoutKeyList = db.loadKeys();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Pump'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        child: ListView.builder(
          itemCount: workoutList.length,
          itemBuilder: (context, index) {
            return Card(
              child: TextButton(
                onPressed: () async {
                  // Go to detail page
                  await Navigator.pushNamed(context, '/workout_detail', arguments: {
                    'id': workoutKeyList[index],
                    'title': workoutList[index][0],
                    'workouts': workoutList[index][1],
                    'workoutIcon': workoutList[index][2],
                  });

                  setState(() {});
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workoutList[index][0],
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        for (Map workout in workoutList[index][1])
                          Text(
                            workout['name'],
                            style: TextStyle(color: Colors.grey[600]),
                          )
                      ],
                    ),
                    leading: SizedBox(
                      height: 60,
                      width: 60,
                      child: Image(
                          image: AssetImage(workoutList[index][2])),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/create_workout');
          setState(() {});
        },
        backgroundColor: Colors.grey[900],
        child: const Icon(Icons.add),
      ),
    );
  }
}
