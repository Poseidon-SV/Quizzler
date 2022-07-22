import 'package:flutter/material.dart';

// import 'question.dart'; Not in use anymore
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

// TODO: Add 'TODO' in every large project you build to highlight your goal or anything \\
///    You can find your todos in the tab below
/// OOP 4 pillars:
///   Abstraction
///   Encapsulation
///   Inheritance
///   Polymorphism >> Read (@overide, super., etc.)
/// Alert button
/// Dart constructor

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
  List<Widget> scorekeeper = [];

  // List<String> questions = [
  //   'You can lead a cow down stairs but not up stairs.',
  //   'Approximately one quarter of human bones are in the feet.',
  //   'A slug\'s blood is green.'
  // ];
  // List<bool> answers = [false, true, true];
  //
  // Question q1 = Question(q:'You can lead a cow down stairs but not up stairs.', a:false);

  // List <Question> questionBank = [
  //   Question(q:'You can lead a cow down stairs but not up stairs.', a:false),
  //   Question(q:'Approximately one quarter of human bones are in the feet.', a:true),
  //   Question(q:'A slug\'s blood is green.', a:true)
  // ];

  // int questionNum = 0; Is shifted to quiz_brain.dart and secured

  void checkAns(bool userPickedAns) {
    bool correctAnswer = quizBrain.getQuestionAns();
    setState(
      () {
        if (correctAnswer == userPickedAns) {
          quizBrain.getNextQuestionNum();
          scorekeeper.add(
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          );
        } else {
          quizBrain.getNextQuestionNum();
          scorekeeper.add(
            Icon(
              Icons.close_rounded,
              color: Colors.red,
            ),
          );
        }
        ;
      },
    );

    /// Alert button
    bool questionsCompleted = quizBrain.isFinished();
    if (questionsCompleted == true) {
      print("True");
      Alert(
        context: context,
        style: AlertStyle(
          backgroundColor: Color.fromARGB(400, 300, 300, 300),
          titleStyle: TextStyle(
            color: Colors.grey[500],
          ),
          animationType: AnimationType.shrink,
        ),
        type: AlertType.success,
        // title: "RFLUTTER ALERT",
        title: "Great, You have completed the quiz!!",
        buttons: [
          DialogButton(
            child: Text(
              "Restart Quiz",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                quizBrain.reset();
                scorekeeper.clear();
              });
            },
            width: 220,
          )
        ],
      ).show();
    } else {
      print("false");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
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
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
              onPressed: () {
                //The user picked True.
                // bool correctAnswer = quizBrain.getQuestionAns();
                // if (correctAnswer == true) {
                //   print('Correct');
                // } else {
                //   print('Wrong');
                // }
                // setState(() {
                //   quizBrain.getNextQuestionNum();
                //   scorekeeper.add(
                //     Icon(
                //       Icons.check_circle,
                //       color: Colors.green,
                //     ),
                //   );
                // });
                checkAns(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                // bool correctAnswer = quizBrain.getQuestionAns();
                // if (correctAnswer == false) {
                //   print('Correct');
                // } else {
                //   print('Wrong');
                // }
                // setState(() {
                //   // questionNum++;
                //   quizBrain.getNextQuestionNum();
                //   // if (quizBrain.getNextQuestionNum() < 13){
                //   scorekeeper.add(
                //     Icon(
                //       Icons.close_rounded,
                //       color: Colors.red,
                //     ),
                //       // };
                //   );
                // });
                checkAns(false);
              },
            ),
          ),
        ),
        Row(children: scorekeeper),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
