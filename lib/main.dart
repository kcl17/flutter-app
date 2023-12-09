import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.indigo, // Change the primary color
      ),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to the Quiz App'),
        backgroundColor: Colors.indigo, // Change the app bar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Quiz App!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo, // Change the button color
              ),
              child: Text('Start Quiz', style: TextStyle(color: Colors.yellow)),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _submitted = false;

  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is UPF?',
      'options': ['User plane function', 'Unified protocol function', 'user protocol function', 'unified plane function'],
      'correctIndex': 0,
    },
    {
      'question': 'Which programming language is Flutter based on?',
      'options': ['Dart', 'Java', 'Python', 'C++'],
      'correctIndex': 0,
    },
    {
      'question': 'Who won the FIFA World Cup in 2018?',
      'options': ['Brazil', 'Germany', 'France', 'Argentina'],
      'correctIndex': 2,
    },
    {
      'question': 'Which country has won the most FIFA World Cup titles?',
      'options': ['Brazil', 'Germany', 'Italy', 'Argentina'],
      'correctIndex': 0,
    },
    {
      'question': 'In which year did Lionel Messi win his first Ballon d\'Or?',
      'options': ['2008', '2010', '2012', '2015'],
      'correctIndex': 2,
    },
    {
      'question': 'Which club has the most UEFA Champions League titles?',
      'options': ['Real Madrid', 'Barcelona', 'Bayern Munich', 'AC Milan'],
      'correctIndex': 0,
    },
    {
      'question': 'Who is the all-time top scorer in the English Premier League?',
      'options': ['Wayne Rooney', 'Alan Shearer', 'Thierry Henry', 'Frank Lampard'],
      'correctIndex': 1,
    },
    {
      'question': 'Which country hosted the first FIFA World Cup in 1930?',
      'options': ['Brazil', 'Italy', 'Uruguay', 'Germany'],
      'correctIndex': 2,
    },
  ];

  void _checkAnswer(int selectedIndex) {
    if (_currentIndex <= questions.length - 1 && !_submitted) {
      if (selectedIndex == questions[_currentIndex]['correctIndex']) {
        setState(() {
          _score++;
        });
      }
    }
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < questions.length - 1 && !_submitted) {
        _currentIndex++;
      } else if (_currentIndex == questions.length - 1) {
        _submitted = true;
        _submitQuiz();
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (_currentIndex > 0 && !_submitted) {
        _currentIndex--;
      }
    });
  }

  void _submitQuiz() {
    setState(() {
      _submitted = true;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Results'),
        content: Text('Your Score: $_score / ${questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              _restartQuiz();
              Navigator.pop(context);
            },
            child: Text('Restart Quiz', style: TextStyle(color: Colors.indigo)),
          ),
        ],
      ),
    );
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentIndex + 1}/${questions.length}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      questions[_currentIndex]['question'],
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    ...((questions[_currentIndex]['options'] as List<String>)
                        .asMap()
                        .entries
                        .map(
                          (entry) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                              onPressed: _submitted
                                  ? null
                                  : () {
                                      _checkAnswer(entry.key);
                                      _nextQuestion();
                                    },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.indigo,
                                textStyle: TextStyle(fontSize: 16),
                              ),
                              child: Text(entry.value),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      _previousQuestion();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                    ),
                    child:
                        Text('Previous', style: TextStyle(color: Colors.white)),
                  ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitted
                      ? null
                      : () {
                          _submitQuiz();
                        },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                  ),
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitted
                      ? () {
                          _restartQuiz();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                  ),
                  child: Text('Restart', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (_submitted)
              Center(
                child: Text(
                  'Your Score: $_score / ${questions.length}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_submitted) {
            _nextQuestion();
          }
        },
        child: Icon(Icons.navigate_next),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
