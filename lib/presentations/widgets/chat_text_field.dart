import 'package:ai_chat/config/app_colors.dart';
import 'package:ai_chat/config/app_styles.dart';
import 'package:ai_chat/constants/app_constants.dart';
import 'package:ai_chat/constants/app_path.dart';
import 'package:ai_chat/presentations/widgets/asset_icon.dart';
import 'package:ai_chat/presentations/widgets/ripple_effect.dart';
import 'package:flutter/material.dart';

class ChatTextField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  const ChatTextField({super.key, required this.controller, required this.onSend});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  bool _isTexting = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if(widget.controller.text.trim().isNotEmpty){
        setState(() => _isTexting = true);
      }else if(widget.controller.text.trim().isEmpty){
        setState(() => _isTexting = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: AppStyles.defaultStyle(),
      decoration: InputDecoration(
        hintText: 'Ask me anything..',
        hintStyle: AppStyles.defaultStyle(textColor: AppColors.grey),
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: AppConstants.paddingDefault,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: AppConstants.paddingSmall),
          child: RippleEffect(
            onPressed: _isTexting ? widget.onSend : null,
            child: RotatedBox(
              quarterTurns: 1,
              child: AssetIcon(icon: AppPath.icPlane, size: AppConstants.iconSizeBig, color: _isTexting ? AppColors.grey : AppColors.grey.withOpacity(.4)),
              // child: Image.asset(AppPath.icPlane, width: AppConstants.iconSizeBig, height: AppConstants.iconSizeBig, color: _isTexting ? AppColors.grey : AppColors.grey.withOpacity(.4),),
            ),
          ),
        ),
        suffixIconConstraints: BoxConstraints(maxHeight: AppConstants.paddingSuperHuge),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }

  OutlineInputBorder get border => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppConstants.radiusCard),
    borderSide: const BorderSide(color: AppColors.grey, width: 1.0),
  );
}
