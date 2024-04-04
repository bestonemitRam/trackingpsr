import 'dart:async';
import 'package:flutter/material.dart';

class UpcountTimer extends StatefulWidget {
  @override
  _UpcountTimerState createState() => _UpcountTimerState();
}

class _UpcountTimerState extends State<UpcountTimer> {
  late Timer _timer;
  int _secondsElapsed = 0;

  @override
  void initState() 
  {
    super.initState();
    // Start the timer
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) 
  {
    return 
    StreamBuilder<int>(
      stream: Stream.periodic(Duration(seconds: 1), (x) => _secondsElapsed),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final seconds = snapshot.data!;
          final hours = seconds ~/ 3600;
          final minutes = (seconds ~/ 60) % 60;
          final remainingSeconds = seconds % 60;

          return Text(
            '$hours:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 24.0),
          );
        } else {
          return Text(
            'Loading...',
            style: TextStyle(fontSize: 24.0),
          );
        }
      },
    );
 
  }
}
