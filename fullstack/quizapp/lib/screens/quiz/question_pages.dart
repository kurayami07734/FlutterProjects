import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/screens/quiz/quiz_state.dart';
import 'package:quizapp/services/firestore.dart';
import 'package:quizapp/shared/bottom_sheet.dart';
import '../../services/models.dart';

class QuestionPage extends StatelessWidget {
  final Question question;
  const QuestionPage({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<QuizState>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(question.text),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: question.options.map((opt) {
              return Container(
                height: 90,
                margin: const EdgeInsets.only(bottom: 10),
                color: Colors.black26,
                child: InkWell(
                  onTap: () {
                    state.selected = opt;
                    bottomSheet(context, opt, state);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          state.selected == opt
                              ? FontAwesomeIcons.circleCheck
                              : FontAwesomeIcons.circle,
                          size: 30,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              opt.value,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class StartPage extends StatelessWidget {
  final Quiz quiz;
  const StartPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<QuizState>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          quiz.title,
          style: Theme.of(context).textTheme.headline4,
        ),
        const Divider(),
        Expanded(child: Text(quiz.description)),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: state.nextPage,
              icon: const Icon(Icons.poll),
              label: const Text("Start quiz!"),
            )
          ],
        )
      ]),
    );
  }
}

class EndPage extends StatelessWidget {
  final Quiz quiz;
  const EndPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        Text(
          "Congratulations! You have completed ${quiz.title} quiz",
          textAlign: TextAlign.center,
        ),
        const Divider(),
        Image.asset('assets/congrats.gif'),
        const Divider(),
        ElevatedButton.icon(
          onPressed: () {
            FirestoreService().updateUserReport(quiz);
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/topics',
              (route) => false,
            );
          },
          icon: const Icon(FontAwesomeIcons.check),
          label: const Text("Mark Complete!"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        ),
      ]),
    );
  }
}
