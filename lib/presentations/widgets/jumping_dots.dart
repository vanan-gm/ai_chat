import 'package:ai_chat/constants/app_constants.dart';
import 'package:ai_chat/presentations/widgets/dot.dart';
import 'package:flutter/material.dart';

class JumpingDots extends StatefulWidget {
  final int numberOfDots;
  final double beginTweenValue;
  final double endTweenValue;
  const JumpingDots({super.key, this.numberOfDots = 3, this.beginTweenValue = 0.0, this.endTweenValue = 5.0});

  @override
  State<JumpingDots> createState() => _JumpingDotsState();
}

class _JumpingDotsState extends State<JumpingDots> with TickerProviderStateMixin{
  late List<AnimationController> _controllers;
  final List<Animation> _animations = [];

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  void _initAnimation(){
    _controllers = List.generate(widget.numberOfDots, (index) => AnimationController(vsync: this, duration: AppConstants.durationAnimation)).toList();
    for(int i = 0; i < widget.numberOfDots; i++){
      _animations.add(Tween<double>(begin: 0, end: -10).animate(_controllers[i]));
    }
    for(int i = 0; i < widget.numberOfDots; i++){
      _controllers[i].addStatusListener((status) {
        if(status == AnimationStatus.completed){
          _controllers[i].reverse();
          if(i != widget.numberOfDots - 1){
            _controllers[i + 1].forward();
          }
        }
        if(i == widget.numberOfDots - 1 && status == AnimationStatus.dismissed){
          _controllers.first.forward();
        }
      });
    }
    _controllers.first.forward();
  }

  @override
  void dispose() {
    for(var controller in _controllers){
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.numberOfDots, (index){
        return AnimatedBuilder(
          animation: _controllers[index],
          builder: (context, child){
            return Container(
              padding: EdgeInsets.all(AppConstants.paddingSmallest * .8),
              child: Transform.translate(
                offset: Offset(0, _animations[index].value),
                child: const Dot(size: 10),
              ),
            );
          }
        );
      }),
    );
  }
}
