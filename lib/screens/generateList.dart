import 'package:flutter/material.dart';
import 'package:workout/screens/exerciseList.dart';
import 'package:workout/List/myList.dart';

class GenerateList extends StatefulWidget {
  @override
  _GenerateListState createState() => _GenerateListState();
}

class _GenerateListState extends State<GenerateList> {  
 
  @override
  Widget build(BuildContext context)
   {
    return Column(
      children: myList.map((exdata){
        return ExerciseList(pic: exdata.pic, name: exdata.name, duration: exdata.duration);
      }).toList()
    );
  }
}