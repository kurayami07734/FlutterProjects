import 'package:flutter/material.dart';
import 'package:quizapp/screens/quiz/quiz_state.dart';

import '../services/models.dart';

bottomSheet(BuildContext context, Option opt, QuizState state) {
  bool correct = opt.correct;
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.18,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(correct ? "Good job" : "Wrong"),
            Text(
              opt.detail,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white54,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (correct) {
                  state.nextPage();
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: correct ? Colors.green : Colors.red,
              ),
              child: Text(
                correct ? "Onward!" : "Try again",
                style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
