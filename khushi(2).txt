import 'package:flutter/material.dart';

class QuestionMCQ {
  String ques;
  List<String> options;
  int answerIndex;
  int? userAnswerIndex;

  QuestionMCQ({
    required this.ques,
    required this.options,
    required this.answerIndex,
  });

  void selectOption(int index) {
    userAnswerIndex = index;
  }
}

class TestMCQ {
  int index = 0;
  bool finished = false;
  List<QuestionMCQ> quesList = [];

  TestMCQ() {
    quesList = [
      QuestionMCQ(
        ques: 'What is the purpose of an operating system?',
        options: [
          'To manage hardware resources',
          'To provide a user interface',
          'To run applications',
          'All of the above',
        ],
        answerIndex: 3,
      ),
      QuestionMCQ(
        ques: 'What is the role of the scheduler in an operating system?',
        options: [
          'To allocate resources to processes',
          'To manage file systems',
          'To handle user input',
          'To control the flow of data in a network',
        ],
        answerIndex: 0,
      ),
      QuestionMCQ(
        ques: 'Which memory management technique is used by modern operating systems?',
        options: [
          'Paging',
          'Segmentation',
          'Swapping',
          'All of the above',
        ],
        answerIndex: 3,
      ),
      QuestionMCQ(
        ques: 'What is a shell in the context of operating systems?',
        options: [
          'A protective layer for the kernel',
          'A user interface to access the kernel services',
          'A part of the CPU',
          'A type of file system',
        ],
        answerIndex: 1,
      ),
      QuestionMCQ(
        ques: 'Which scheduling algorithm is commonly used for time-sharing systems?',
        options: [
          'First-Come-First-Serve (FCFS)',
          'Shortest Job Next (SJN)',
          'Round Robin',
          'Priority Scheduling',
        ],
        answerIndex: 2,
      ),
      QuestionMCQ(
        ques: 'What is a deadlock in the context of operating systems?',
        options: [
          'A situation where a process never completes its execution',
          'A condition where two or more processes cannot proceed because each is waiting for the other',
          'A system crash caused by a software bug',
          'A security vulnerability in the operating system',
        ],
        answerIndex: 1,
      ),
    ];
  }

  int getScore() {
    int score = 0;
    for (QuestionMCQ q in quesList) {
      if (q.userAnswerIndex != null && q.userAnswerIndex == q.answerIndex) {
        score++;
      }
    }
    return score;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      home: QuizAppMCQ(),
    );
  }
}

class QuizAppMCQ extends StatefulWidget {
  const QuizAppMCQ({Key? key}) : super(key: key);

  @override
  _QuizAppMCQState createState() => _QuizAppMCQState();
}

class _QuizAppMCQState extends State<QuizAppMCQ> {
  TestMCQ _test = TestMCQ();

  Widget _quizStatus() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: Iterable<int>.generate(_test.quesList.length).toList().map((idx) {
          if (_test.quesList[idx].userAnswerIndex == null)
            return Container(
              color: _test.index == idx ? Colors.yellow : null,
              child: IconButton(
                icon: Icon(Icons.check_box_outline_blank, color: Color.fromARGB(255, 1, 5, 37), size: 38.0),
                onPressed: () => setState(() => _test.index = idx),
              ),
            );
          else
            return (_test.quesList[idx].userAnswerIndex == _test.quesList[idx].answerIndex)
                ? Container(
                    color: _test.index == idx ? Colors.yellow : null,
                    child: IconButton(
                      icon: Icon(
                        Icons.done_rounded,
                        color: Colors.green,
                        size: 38.0,
                      ),
                      onPressed: () => setState(() => _test.index = idx),
                    ),
                  )
                : Container(
                    color: _test.index == idx ? Colors.yellow : null,
                    child: IconButton(
                      icon: Icon(
                        Icons.clear_rounded,
                        color: Color(0xFFE83651),
                        size: 38.0,
                      ),
                      onPressed: () => setState(() => _test.index = idx),
                    ),
                  );
        }).toList(),
      ),
    );
  }

  Widget _quizComplete() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Material(
          color: Color.fromARGB(255, 152, 149, 171),
          elevation: 50,
          child: Container(
            height: 200,
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text(
                  'You have successfully completed the quiz!',
                  textScaleFactor: 2.0,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'Score = ${_test.getScore()}/${_test.quesList.length}',
                  textScaleFactor: 2.0,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => setState(() => _test = TestMCQ()),
                      child: const Text(
                        'Restart',
                        textScaleFactor: 1.5,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() => _test.finished = false),
                      child: const Text(
                        'Continue',
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 200,
        ),
        _quizStatus(),
      ],
    );
  }

  Widget _getQuestionPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              child: const Text(
                'Finish Test',
                textScaleFactor: 2,
              ),
              onPressed: () => setState(() => _test.finished = true),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _test.quesList[_test.index].ques,
                  style: TextStyle(fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                for (int i = 0; i < _test.quesList[_test.index].options.length; i++)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _test.quesList[_test.index].selectOption(i);
                        if (_test.index < _test.quesList.length - 1) {
                          _test.index++;
                        }
                      });
                    },
                    child: Text(_test.quesList[_test.index].options[i]),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      elevation: MaterialStateProperty.all<double>(5.0),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15.0)),
                    ),
                  ),
              ],
            ),
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
          ),
        ),
        Divider(
          height: 0.0,
          thickness: 2.0,
        ),
        SizedBox(
          height: 40.0,
        ),
        _quizStatus(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Quiz',
          textScaleFactor: 2,
        ),
        backgroundColor: Color.fromARGB(255, 231, 86, 14),
      ),
      body: _test.finished ? _quizComplete() : _getQuestionPage(),
    );
  }
}
