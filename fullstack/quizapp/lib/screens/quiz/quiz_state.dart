import 'package:flutter/material.dart';
import 'package:quizapp/services/models.dart';

class QuizState with ChangeNotifier {
  double _progress = 0;
  Option? _selected;
  final PageController controller = PageController();
  double get progress => _progress;
  Option? get selected => _selected;
  set progress(double value) {
    _progress = value;
    notifyListeners();
  }

  set selected(Option? value) {
    _selected = value;
    notifyListeners();
  }

  void nextPage() async {
    await controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}
