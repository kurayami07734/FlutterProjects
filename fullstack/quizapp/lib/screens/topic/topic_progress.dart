import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/shared/progress_bar.dart';

import '../../services/models.dart';

class TopicProgressBar extends StatelessWidget {
  final Topic topic;
  const TopicProgressBar({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    return Row(
      children: [
        _progressCount(topic, report),
        Expanded(
          child: AnimatedProgressBar(
            height: 8,
            value: _calculateProgress(topic, report),
          ),
        )
      ],
    );
  }
}

Widget _progressCount(Topic topic, Report report) {
  return Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Text(
      "${report.topics[topic.id]?.length ?? 0} / ${topic.quizzes.length}",
      style: TextStyle(
        color: Colors.grey,
        fontSize: 10,
      ),
    ),
  );
}

double _calculateProgress(Topic topic, Report report) {
  try {
    int total = topic.quizzes.length;
    int completed = report.topics[topic.id].length;
    return completed / total;
  } catch (e) {
    return 0.0;
  }
}
