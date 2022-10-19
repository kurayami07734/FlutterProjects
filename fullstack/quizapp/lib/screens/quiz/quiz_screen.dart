import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/screens/quiz/question_pages.dart';
import 'package:quizapp/services/firestore.dart';
import 'package:quizapp/shared/loading.dart';
import 'package:quizapp/shared/progress_bar.dart';
import '../../services/models.dart';
import './quiz_state.dart';

class QuizScreen extends StatelessWidget {
  final String quizId;
  const QuizScreen({super.key, required this.quizId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: FutureBuilder<Quiz>(
        future: FirestoreService().getQuiz(quizId),
        builder: (context, snapshot) {
          var state = Provider.of<QuizState>(context);
          if (!snapshot.hasData || snapshot.hasError) {
            return const LoadingScreen();
          }
          var quiz = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: AnimatedProgressBar(
                value: state.progress,
                height: 8,
              ),
              leading: IconButton(
                icon: const Icon(FontAwesomeIcons.xmark),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: state.controller,
              onPageChanged: (idx) =>
                  state.progress = (idx) / (quiz.questions.length + 1),
              itemBuilder: (context, idx) {
                if (idx == 0) {
                  return StartPage(quiz: quiz);
                } else if (idx == quiz.questions.length + 1) {
                  return EndPage(quiz: quiz);
                }
                return QuestionPage(
                  question: quiz.questions[idx - 1],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
