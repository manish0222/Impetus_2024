import 'package:flutter/material.dart';
// Import the correct class representing your QuizApp
// import 'package:guizz_app_start/guizzapp.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://slideplayer.com/6273590/21/images/slide_1.jpg',
              height: 500,
              width: 300,
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: 100,
              color: Colors.black,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  // Replace QuizApp with the correct class representing your quiz app
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const QuizApp()),
                  // );
                },
                child: const Text(
                  "START",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
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
