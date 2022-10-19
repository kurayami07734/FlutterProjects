import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/services/models.dart';

class QuizBadge extends StatelessWidget {
  final Topic topic;
  final String quizId;
  const QuizBadge({
    super.key,
    required this.topic,
    required this.quizId,
  });

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    List completed = report.topics[topic.id] ?? [];
    if (completed.contains(quizId)) {
      return const Icon(FontAwesomeIcons.checkDouble, color: Colors.green);
    }
    return const Icon(FontAwesomeIcons.solidCircle, color: Colors.grey);
  }
}
