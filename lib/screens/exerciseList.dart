import 'package:flutter/material.dart';

class ExerciseList extends StatelessWidget {

  final int pic;
  final String duration;
  final String name;
  ExerciseList({this.pic, this.duration, this.name});
  
  @override
  Widget build(BuildContext context) {
    return
      Card(
        elevation: 12,
        color: Colors.purple[400],
        margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Padding(
          padding: EdgeInsets.only(bottom: 40, top: 20),
          child: Column(
            children: <Widget>[
              Text(
                'Exercise: $name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ), 
              ),
              SizedBox(height: 6,),
              Image.asset(
                'assets/$pic.png',
                height: 200,
                width: 300,
              ),
              SizedBox(height: 6,),
              Text(
                'Duration: $duration',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
                ), 
              )
            ],
          ),
        )
      );
  }
}