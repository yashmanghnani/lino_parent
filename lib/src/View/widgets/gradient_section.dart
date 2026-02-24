import 'package:flutter/material.dart';

class GradientBottomSection extends StatelessWidget {
  final double heightFactor;

  const GradientBottomSection({
    super.key,
    this.heightFactor = 0.25, // default 25% height
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: size.height * heightFactor,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFFFFFF), Color(0xffAF52DE)],
          ),
        ),
      ),
    );
  }
}