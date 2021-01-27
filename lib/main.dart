import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz_brain.dart';

QuizBrain quiz_brain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
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
  List<Widget> score = [];

  int questionNum = 0;
  int totalScore = 0;

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
                // .keys.elementAt(questionNum % ques_ans_map.length),
                quiz_brain.getQuestionText(questionNum),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
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
                //The user picked true.
                setState(
                  () {
                    bool answer = quiz_brain.getQuestionAnswer(questionNum);
                    // print(answer);
                    // print(questionNum);
                    if (answer == true) {
                      totalScore++;
                      score.add(Icon(
                        Icons.check,
                        color: Colors.green,
                      ));
                    } else {
                      score.add(Icon(
                        Icons.close,
                        color: Colors.red,
                      ));
                    }
                    if (questionNum + 1 > quiz_brain.getQuestionLength() - 1) {
                      Alert(
                              context: context,
                              title: "End",
                              desc:
                                  "You have answered all the Questions!\nYour Score is: $totalScore.")
                          .show();
                      score.clear();
                      questionNum = 0;
                      totalScore = 0;
                    } else {
                      questionNum =
                          (questionNum + 1) % quiz_brain.getQuestionLength();
                    }
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  bool answer = quiz_brain.getQuestionAnswer(questionNum);

                  if (answer == false) {
                    totalScore++;
                    score.add(Icon(
                      Icons.check,
                      color: Colors.green,
                    ));
                  } else {
                    score.add(Icon(
                      Icons.close,
                      color: Colors.red,
                    ));
                  }

                  if (questionNum + 1 > quiz_brain.getQuestionLength() - 1) {
                    Alert(
                            context: context,
                            title: "End",
                            desc:
                                "Completed answering all the Questions!\n Your Score is $totalScore")
                        .show();
                    score.clear();
                    questionNum = 0;
                    totalScore = 0;
                  } else {
                    questionNum =
                        (questionNum + 1) % quiz_brain.getQuestionLength();
                  }
                });
              },
            ),
          ),
        ),
        Row(
          children: score,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
