import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config.dart';
import '../home_page.dart';
import 'question.dart';
import '../userDetails.dart/user.dart';
import 'package:http/http.dart' as http;

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  bool questionscreen = true;
  int questionIndex = 0;
  int selectedAnswerIndex = -1;
  int noofCorrectAnswer = 0;
  bool start = true;

  MaterialStateProperty<Color?> checkAnswer(int buttonIndex) {
    if (selectedAnswerIndex != -1) {
      if (buttonIndex == allQuestions[questionIndex]["answerIndex"]) {
        return MaterialStateProperty.all(Colors.green);
      } else if (buttonIndex == selectedAnswerIndex) {
        return MaterialStateProperty.all(Colors.red);
      } else {
        return MaterialStateProperty.all(Color.fromARGB(255, 168, 168, 168));
      }
    } else {
      return MaterialStateProperty.all(Color.fromARGB(255, 175, 170, 170));
    }
  }

  void validateCurrentPage() {
    if (selectedAnswerIndex == -1) {
      return;
    }
    if (selectedAnswerIndex == allQuestions[questionIndex]["answerIndex"]) {
      noofCorrectAnswer = noofCorrectAnswer + 1;
    }
    if (selectedAnswerIndex != -1) {
      if (questionIndex == allQuestions.length - 1) {
        setState(() {
          questionscreen = false;
        });
      }

      selectedAnswerIndex = -1;
      setState(() {
        questionIndex = questionIndex + 1;
      });
    }
  }

  Scaffold isQuestionScreen() {
    if (questionscreen == true) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quiz App",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 114, 140, 244),
        ),
        // backgroundColor: Colors.grey,
        body: Column(
          children: [
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Questions: ",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${questionIndex + 1}/${allQuestions.length}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 80, width: 50),
            const SizedBox(height: 50),
            Container(
              width: 450,
              height: 60,
              color: Color.fromARGB(255, 159, 166, 255),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${allQuestions[questionIndex]["question"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: checkAnswer(0),
                fixedSize: MaterialStateProperty.all(Size.fromWidth(300)),
              ),
              onPressed: () {
                if (selectedAnswerIndex == -1) {
                  setState(() {
                    selectedAnswerIndex = 0;
                  });
                }
              },
              child: Text("A. ${allQuestions[questionIndex]['options'][0]}"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: checkAnswer(1),
                fixedSize: MaterialStateProperty.all(Size.fromWidth(300)),
              ),
              onPressed: () {
                if (selectedAnswerIndex == -1) {
                  setState(() {
                    selectedAnswerIndex = 1;
                  });
                }
              },
              child: Text("B. ${allQuestions[questionIndex]['options'][1]}"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: checkAnswer(2),
                fixedSize: MaterialStateProperty.all(Size.fromWidth(300)),
              ),
              onPressed: () {
                if (selectedAnswerIndex == -1) {
                  setState(() {
                    selectedAnswerIndex = 2;
                  });
                }
              },
              child: Text("C. ${allQuestions[questionIndex]['options'][2]}"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: checkAnswer(3),
                fixedSize: MaterialStateProperty.all(Size.fromWidth(300)),
              ),
              onPressed: () {
                if (selectedAnswerIndex == -1) {
                  setState(() {
                    selectedAnswerIndex = 3;
                  });
                }
              },
              child: Text("D. ${allQuestions[questionIndex]['options'][3]}"),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.forward, color: Colors.black),
          backgroundColor: Color.fromARGB(255, 114, 114, 229),
          onPressed: () {
            validateCurrentPage();
          },
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quiz App",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 74, 193, 233),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Congratulations!!!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "You have Completed the Test!!!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Your Score ${noofCorrectAnswer}/${allQuestions.length}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    Map<String, String> data = {
                      'email': userDetail['email'],
                      'score': noofCorrectAnswer.toString(),
                      'name': userDetail['name']
                    };
                    print("\n\n--\n${data}");
                    sendTestResult(data);
                    questionscreen = true;
                    questionIndex = 0;
                    selectedAnswerIndex = -1;
                    noofCorrectAnswer = 0;
                    start = true;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomePage(token: userDetail['token']),
                      ),
                    );
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  side: BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Go Home",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              OutlinedButton(
                onPressed: _launchURL,
                child: Text(
                  "Check Class Scores",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  // Function to send the test result to the backend
  Future<void> sendTestResult(Map<String, String> data) async {
    try {
      Uri url = Uri.parse(insert);

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Request successful, handle response if needed
        print('Test result sent successfully');
      } else {
        // Request failed, handle error
        print('Failed to send test result');
      }
    } catch (e) {
      // Error occurred during request
      print('Error: $e');
    }
  }

  _launchURL() async {
    Map<String, String> data = {
      'email': userDetail['email'],
      'score': noofCorrectAnswer.toString(),
      'name': userDetail['name']
    };
    print("\n\n--\n${data}");
    sendTestResult(data);
    questionscreen = true;
    questionIndex = 0;
    selectedAnswerIndex = -1;
    noofCorrectAnswer = 0;
    start = true;
    const url =
        'https://app.powerbi.com/groups/me/reports/0df36882-9fb9-4669-8f98-b268263378c0/ReportSection?experience=power-bi';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return isQuestionScreen();
  }
}
