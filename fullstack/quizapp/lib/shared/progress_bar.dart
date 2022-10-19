import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  final double value, height;
  const AnimatedProgressBar({
    super.key,
    required this.height,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints box) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: box.maxWidth,
          child: Stack(
            children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                height: height,
                width: box.maxWidth * _floor(value),
                decoration: BoxDecoration(
                  color: _colorGen(value),
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

double _floor(double value, [min = 0.0]) {
  return value.sign <= min ? min : value;
}

Color _colorGen(double value) {
  int rbg = (value * 255).toInt();
  return Colors.deepOrange.withGreen(rbg).withRed(255 - rbg);
}
