import 'package:hive_flutter/adapters.dart';

class gymDatabase {

  final gymBox = Hive.box('gymBox');

  void createInitialData(){

    createData(
      [
        'Chest day',[
          {'name': 'Pushup', 'weight': '10', 'set': '5', 'repeat': '8'},
          {'name': 'Chest press', 'weight': '25', 'set': '5', 'repeat': '12'}
        ],'assets/icons/bench_press.png'
      ]
    );
    createData(
      [
        'Shoulder day',[
          {'name': 'Lateral raise', 'weight': '10', 'set': '5', 'repeat': '8'},
          {'name': 'Shoulder press', 'weight': '25', 'set': '5', 'repeat': '12'}
        ],'assets/icons/body.png'
      ]
    );
    createData(
      [
        'Leg day',[
          {'name': 'Squat', 'weight': '10', 'set': '5', 'repeat': '8'},
          {'name': 'Leg press', 'weight': '25', 'set': '5', 'repeat': '12'}
        ],'assets/icons/leg.png'
      ]
    );

  }

  void createData(item){
    gymBox.add(item);
  }

  loadKeys(){
    return gymBox.keys.toList();
  }

  loadData(){
    return gymBox.values.toList();
  }

  getDataByID(id){
    return gymBox.get(id);
  }

  void updateDataByID(id, data){
    gymBox.put(id, data);
  }

  void deleteDataByID(id){
    gymBox.delete(id);
  }

}