import 'dart:async';
import 'package:flutter/material.dart';
import 'package:workout/List/myList.dart';
import 'package:workout/model/exerciseModel.dart';
import 'package:after_layout/after_layout.dart';
import 'package:workout/screens/Home.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';


class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> with AfterLayoutMixin<ExercisePage> {

  static int index=0;
  bool isPlaying = false;
  bool isPaused = false;
  AudioPlayerState playerState;
  static int audioIndex = 1;
  //static List<int> time = [10,10,1,1,1];
  bool countdownActive =true;
  bool isBreak = false;
  int breakTime = 5;
  int initialCountdown = 3;
  static List<ExerciseModel> exeList = myList;
  int intialTimer = int.parse(exeList[index].duration);  
  // time[index];
  String displayTime;
  AudioCache cache = AudioCache();
  AudioPlayer player = AudioPlayer();

  @override
  void afterFirstLayout(BuildContext context){
    startCountdown();
  }
  

  myDialog(BuildContext context){
    return showDialog(context: context, builder:(context){
      return AlertDialog(
        title: Text('You have completed all the exercises!!!'),
        content: Icon(Icons.thumb_up, color: Colors.greenAccent[700],),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(context, 
                MaterialPageRoute(builder: (BuildContext context) => Home()), 
                (Route<dynamic> route) => false);
            },
            child: Text('Great!!'),
          )
        ],
      );
    }, barrierDismissible: false);
  }

  void startTimer() async
  {
    
    if(!isPlaying)
    {
      if(playerState == AudioPlayerState.STOPPED)
      {
        setState(() {
          if(audioIndex==6)
          {
            audioIndex = 1;
          }else{
            audioIndex = (audioIndex +1) ;
          }
      });
      }
      player = await cache.loop('song$audioIndex.mp3');
      isPlaying = true;
      player.onPlayerStateChanged.listen((AudioPlayerState s){
        print('player state: $s');
        setState(() {
          playerState = s;
        });
      });
    }
    Timer.periodic(
      Duration(seconds: 1), 
      (Timer t){
        if(intialTimer <2)
        {
          t.cancel();
          setState(() {
            isBreak = true;
            index ++;
            breakTime = 5;
          });
          breakTimer();
        }
        else if(intialTimer<60)
        {
          setState(() {
            intialTimer --;
            displayTime = intialTimer.toString();
          });
        }
        else{
          setState(() {
            int m = intialTimer ~/ 60;
            int s = intialTimer - (60 * m);
            setState(() {
              intialTimer -- ;
              displayTime = m.toString() + ':' + s.toString();
            });
          });
        }
    });
  }

  void breakTimer(){
    if(isPlaying)
    {
      player.stop();
      setState(() {
        isPlaying = false;
      });
      
    }
    Timer.periodic(Duration(seconds: 1), (Timer t) async {
      if(breakTime<2)
      {
        t.cancel();
        if(index>=5)
        {
          setState(() {
            index = 0;
          });
          return await myDialog(context);
        }
        setState(() {
          isBreak = false;
          intialTimer = int.parse(exeList[index].duration);
        });
        startTimer();
      }else{
        setState(() {
          breakTime --;
        });
      }
    });
  }

  void startCountdown(){
    Timer.periodic(
      Duration(seconds: 1), 
      (Timer t){
        debugPrint('${exeList[0].name}');
        if(initialCountdown < 2)
        {
          t.cancel();
          setState(() {
            countdownActive = false;
          });
          startTimer();
          
        }else{
          setState(() {
            initialCountdown -- ;
          });
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return countdownActive ? 
      Material(
        type: MaterialType.transparency,
        child: Container(
          color: Colors.blue,
          child: Center(
            child: Text(
              '$initialCountdown', 
              style: TextStyle(
                fontSize: 60
              ),
            ),  
          ),
        ),
      ) : isBreak? Material(
        type: MaterialType.transparency,
        child: Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.only(left:20.0, right: 20, top: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Break!!',
                    style: TextStyle(
                      fontSize: 60,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Wipe you sweat off and be ready for next exercise in: ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '$breakTime', 
                    style: TextStyle(
                      fontSize: 60
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ) : Scaffold(
      appBar: AppBar(
        title: Text('${exeList[index].name}'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Image.asset('assets/${exeList[index].pic}.png'),
          SizedBox(height: 6,),
          Text(
            '$displayTime',
            style: TextStyle(
              color: Colors.red,
              fontSize: 60
              
            ),
          )
        ],
      ),
    );
  }
}