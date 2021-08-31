import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:first_flutter_app/model/question.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  @override

  List questionBank = [
    Question.make("water is wet", true),
    Question.make("I am good", true),
    Question.make("ocean is purple", false),
    Question.make("You can kickflip", false)
  ];

  int _currQuestionIndex = 0;

  void _checkAnswer(bool userChoice){
    if(userChoice == questionBank[_currQuestionIndex].answer){
      _nextQuestion();

      final correctSnackBar = SnackBar(
        content: Text("Correct!"),
        duration: Duration(milliseconds: 800),
        );

      ScaffoldMessenger.of(context).showSnackBar(correctSnackBar);
    }else{
      final incorrectSnackBar = SnackBar(content: Text("incorrect, try again and again!"), duration: Duration(milliseconds: 1200),);
      ScaffoldMessenger.of(context).showSnackBar(incorrectSnackBar);
    }
  }
  void _lastQuestion(){
    setState(() {
      _currQuestionIndex = (_currQuestionIndex-1)%questionBank.length;
    });
  }
  void _nextQuestion(){
    setState(() {
      _currQuestionIndex = (_currQuestionIndex+1)%questionBank.length;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Time"),
        centerTitle: true,
        //backgroundColor: Colors.blueGrey,
      ),
      //backgroundColor: Colors.blueGrey,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child:Image.asset("images/flag.png",
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  //color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    //color: Colors.blueGrey.shade400,
                    style: BorderStyle.solid,
                  )
                ),
                height: 120,
                width:300,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                        questionBank[_currQuestionIndex].questionItself,
                        style:TextStyle(
                          //fontSize: 17,
                          //color: Colors.white,
                          fontStyle: FontStyle.italic,
                    )
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _lastQuestion(),
                  style: ButtonStyle(
                    //backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey.shade900),
                  ),
                  child: Text("LAST"),
                ),
                ElevatedButton(
                  onPressed: () => _checkAnswer(true),
                  style: ButtonStyle(
                    //backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey.shade900),
                  ),
                  child: Text("TRUE"),
                ),
                ElevatedButton(
                  onPressed: () => _checkAnswer(false),
                  style: ButtonStyle(
                    //backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey.shade900),
                  ),
                  child: Text("FALSE"),
                ),
                ElevatedButton(
                  onPressed: () => _nextQuestion(),
                  style: ButtonStyle(
                    //backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey.shade900),
                  ),
                  child: Text("SKIP"),
                ),
              ],
            ),
            Spacer(),
          ],
        )
      ),
    );
  }

  Container _qAndASection(){
    return Container(
      height: 120,
      child: Text("Our question")
    );
  }
}
