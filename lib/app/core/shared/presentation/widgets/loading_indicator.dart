import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        size: 70,
        spinnerMode: true,
        customWidths: CustomSliderWidths(
          trackWidth: 5,
          progressBarWidth: 8,
          shadowWidth: 10,
        ),
        customColors: CustomSliderColors(
          dynamicGradient: true,
          trackColor: const Color(0xFFF1F3F4),
          progressBarColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
