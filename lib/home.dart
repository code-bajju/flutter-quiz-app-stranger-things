import 'package:flutter/material.dart';
import 'package:quiz/answer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      // adding to the score tracker on top
      _scoreTracker.add(
        answerScore
            ? Icon(
          Icons.check_circle,
          color: Colors.green,
        )
            : Icon(
          Icons.clear,
          color: Colors.redAccent,
        ),
      );
      //when the quiz ends
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    // what happens at the end of the quiz
    if (_questionIndex >= _questions.length) {
      _resetQuiz();
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Stranger Things quiz'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.redAccent, Colors.black]),
          ),
        ),
      ),
      body:
        Container(
          alignment: Alignment.center,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(image:DecorationImage(
          image: NetworkImage(
            'https://img.freepik.com/free-vector/white-red-diagonal-grunge-texture-background_1409-1747.jpg?w=1060&t=st=1668778069~exp=1668778669~hmac=4efec7f8d1209f316ad077ec0b7349514f57873a16938a4d1fc50723c2dba1a9'
          ),
          fit: BoxFit.cover,
          opacity: 30.0,
        ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                if (_scoreTracker.length == 0)
                  SizedBox(
                    height: 25.0,
                  ),
                if (_scoreTracker.length > 0) ..._scoreTracker
              ],
            ),
            Container(
              width: double.infinity,
              height: 130.0,
              margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://wallpapers.moviemania.io/phone/tv/66732/0b2e03/stranger-things-phone-wallpaper.jpg?w=820&h=1459'),
                  fit: BoxFit.cover,
                  opacity: 10,
                ),
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['question'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ...(_questions[_questionIndex]['answers']
            as List<Map<String, Object>>)
                .map(
                  (answer) => Answer(
                answerText: answer['answerText'],
                answerColor:
                answerWasSelected
                    ? answer['score']
                    ? Colors.green
                    : Colors.red
                    : null,
                answerTap: () {
                  // if answer was already selected then nothing happens onTap
                  if (answerWasSelected) {
                    return;
                  }
                  //answer is being selected
                  _questionAnswered(answer['score']);
                },
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              child: ElevatedButton(
              style:
              ElevatedButton.styleFrom(
                minimumSize: Size(200.00, 40.0),backgroundColor:Colors.red,shadowColor: Colors.red,
              ),
              onPressed: () {
                if (!answerWasSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Please select an answer before going to the next question'),
                  ));
                  return;

                }
                _nextQuestion();
              },
              child: Text(endOfQuiz ? 'Restart Quiz' : 'Next Question'),
            ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '${_totalScore.toString()}/${_questions.length}',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
            if (answerWasSelected && !endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: correctAnswerSelected ? Colors.green : Colors.redAccent,
                child: Center(
                  child: Text(
                    correctAnswerSelected
                        ? 'Well done,Sahi Pakde Hai!'
                        : 'Lol Galat  !:/',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if (endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    _totalScore > 4
                        ? 'Congratulations! Your final score is: $_totalScore'
                        : 'Your final score is: $_totalScore. Better luck next time!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: _totalScore > 4 ? Colors.green : Colors.redAccent,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

final _questions = const [
  {
    'question': 'Where is Stranger Things set?',
    'answers': [
      {'answerText': 'LOWA', 'score': false},
      {'answerText': 'INDIANA', 'score': true},
      {'answerText': 'CHINA', 'score': false},
    ],
  },
  {
    'question':
    'Who created Stranger Things?',
    'answers': [
      {'answerText': 'The Duffer Brothers', 'score': true},
      {'answerText': 'Alex Pina', 'score': false},
      {'answerText': 'Steven Knight', 'score': false},
    ],
  },
  {
    'question': 'In what year does the first season take place?',
    'answers': [
      {'answerText': '1987', 'score': false},
      {'answerText': '2000', 'score': false},
      {'answerText': '1982', 'score': true},
    ],
  },
  {
    'question': 'What food does Eleven love to eat?',
    'answers': [
      {'answerText': 'Hamburgers', 'score': true},
      {'answerText': 'French Fries', 'score': false},
      {'answerText': 'Pizza', 'score': false},
    ],
  },
  {
    'question':
    'Who is the leader of the the Hellfire Club?',
    'answers': [
      {'answerText': 'Eddie Munson', 'score': true},
      {'answerText': 'Dustin Henderson', 'score': false},
      {'answerText': 'Lucas Sinclair', 'score': false},
    ],
  },
  {
    'question': 'What is Vecna’s real name?',
    'answers': [
      {'answerText': 'Henry Creel', 'score': true},
      {'answerText': 'Winona Ryder', 'score': false},
      {'answerText': 'Alexie', 'score': false},
    ],
  },
  {
    'question': 'What number is Kali known as?',
    'answers': [
      {'answerText': 'Eight', 'score': true},
      {'answerText': 'Seven', 'score': false},
      {'answerText': 'Six', 'score': false},
    ],
  },
  {
    'question': 'What is Eleven’s biological mother’s name?',
    'answers': [
      {'answerText': 'Kyle Dixon', 'score': true},
      {'answerText': 'Terry Ives', 'score': false},
      {'answerText': 'Alexei', 'score': false},
    ],
  },
  {
    'question': 'Where did Bob Newby work?',
    'answers': [
      {'answerText': 'Radio Shack', 'score': true},
      {'answerText': 'karate Trainer', 'score': false},
      {'answerText': 'Pilot', 'score': false},
    ],
  },
];