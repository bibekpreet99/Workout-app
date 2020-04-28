import 'package:flutter/material.dart';
import 'package:workout/screens/generateList.dart';
import 'package:workout/screens/exercisePage.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Workout for today'),
        centerTitle: true,
        backgroundColor: Colors.purple[700],
      ),
      body: ListView(
        children: <Widget>[
          GenerateList(),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
            child: FlatButton.icon(
              onPressed: (){
                Navigator.pushReplacementNamed( context, '/exercise');
              },
              color: Colors.greenAccent[700],
              icon: Icon(Icons.timer, size: 30,),
              label: Text(
                'Start Workout',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}