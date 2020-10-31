import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // ignore: non_constant_identifier_names
  List<Icon> ScoreKeeper = [];
  QuizBrain brain = QuizBrain();
  int Score = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  brain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, color: Colors.grey.shade900),
                ),
              ),
            )),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                bool correctAnswer = brain.getQuestionAnswer();
                setState(() {
                  if (correctAnswer == true) {
                    ScoreKeeper.add(Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 15.0,
                    ));
                    Score++;
                  } else {
                    ScoreKeeper.add(
                      Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 15.0,
                      ),
                    );
                  }
                  if (brain.lastQuestion()) {
                    Alert(
                      context: context,
                      type: AlertType.info,
                      title: "You finished the quiz !!",
                      desc: "your score is " + Score.toString() + "/15",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Restart",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              brain.setQuestionnumber(0);
                              ScoreKeeper.clear();
                              Navigator.pop(context);
                              Score = 0;
                            });
                          },
                          color: Color.fromRGBO(0, 179, 134, 1.0),
                          radius: BorderRadius.circular(0.0),
                        ),
                      ],
                    ).show();
                  } else {
                    brain.nextQuestion();
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                bool correctAnswer = brain.getQuestionAnswer();
                setState(() {
                  if (correctAnswer == false) {
                    ScoreKeeper.add(Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 15.0,
                    ));
                    Score++;
                  } else {
                    ScoreKeeper.add(
                      Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 15.0,
                      ),
                    );
                  }

                  if (brain.lastQuestion()) {
                    Alert(
                      context: context,
                      type: AlertType.info,
                      title: "You finished the quiz !!",
                      desc: "your score is " + Score.toString() + "/15",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Restart",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              brain.setQuestionnumber(0);
                              ScoreKeeper.clear();
                              Navigator.pop(context);
                              Score = 0;
                            });
                          },
                          color: Color.fromRGBO(0, 179, 134, 1.0),
                          radius: BorderRadius.circular(0.0),
                        ),
                      ],
                    ).show();
                  } else {
                    brain.nextQuestion();
                  }
                });
              },
            ),
          ),
        ),
        Row(
          children: ScoreKeeper,
        ),
      ],
    );
  }
}
