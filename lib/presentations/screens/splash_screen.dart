import 'package:ai_chat/config/app_colors.dart';
import 'package:ai_chat/constants/app_constants.dart';
import 'package:ai_chat/constants/app_path.dart';
import 'package:ai_chat/presentations/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    handleNavigation();
  }

  Future<void> handleNavigation() async{
    Future.delayed(AppConstants.durationSplash, (){
      Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (_) => const HomeScreen()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Lottie.asset(AppPath.lottieLoading, width: AppConstants.width, height: 100, repeat: true),
        ),
      ),
    );
  }
}

