import 'package:flutter/material.dart';
import 'package:quizapp/screens/quiz/quiz_screen.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/screens/quiz/quiz_badge.dart';

class QuizList extends StatelessWidget {
  final Topic topic;
  const QuizList({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: topic.quizzes.map((q) {
        return Card(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation: 4,
          margin: const EdgeInsets.all(4),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QuizScreen(quizId: q.id)));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(
                  q.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Text(
                  q.description,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.fade,
                ),
                leading: QuizBadge(topic: topic, quizId: q.id),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
