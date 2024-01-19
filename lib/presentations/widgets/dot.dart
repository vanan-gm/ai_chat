import 'package:ai_chat/config/app_colors.dart';
import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final double size;
  const Dot({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
       decoration: const BoxDecoration(
         shape: BoxShape.circle,
         color: AppColors.brightBlue,
       ),
    );
  }
}
