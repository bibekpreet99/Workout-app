import 'package:workout/model/exerciseModel.dart';

class Elist{
  
  List<ExerciseModel> elist = [
    ExerciseModel(1,'300', 'Push Ups'), 
    ExerciseModel(2,'600', 'Abdominal Crunch'),
    ExerciseModel(3,'900', 'Crunches'),
    ExerciseModel(4,'300', 'Warm up'),
    ExerciseModel(5,'300', 'Toe Touch'),
    ExerciseModel(6,'480', 'Dumbell Pushups'),
    ExerciseModel(7,'900', 'Dumbell Lift'),
    ExerciseModel(8,'360', 'Ball Push Ups'),
    ExerciseModel(9,'720', 'Yoga'),
    ExerciseModel(10,'900', 'Weight Lifting'),
    ExerciseModel(11,'900', 'Weight Lifting 2'),
    ExerciseModel(12,'600', 'Weight Lifting 3'),
    ExerciseModel(13,'600', 'Weight Lifting 4'),
    ExerciseModel(14,'300', 'Crunches 2')
  ];

  List<ExerciseModel> requiredList = List();

  List<ExerciseModel> createList(){
    print(elist[0]);
    elist.shuffle();
    requiredList = [];
    for (var i = 1; i < 6; i++) {
      this.requiredList.add(elist[i]);
    }
    
    return requiredList;
  }
}


