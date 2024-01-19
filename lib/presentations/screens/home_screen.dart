import 'dart:math';

import 'package:ai_chat/config/app_colors.dart';
import 'package:ai_chat/config/app_styles.dart';
import 'package:ai_chat/constants/app_constants.dart';
import 'package:ai_chat/constants/app_path.dart';
import 'package:ai_chat/model/chat_message.dart';
import 'package:ai_chat/network/repository/chat_repository.dart';
import 'package:ai_chat/presentations/widgets/asset_icon.dart';
import 'package:ai_chat/presentations/widgets/chat_text_field.dart';
import 'package:ai_chat/presentations/widgets/jumping_dots.dart';
import 'package:ai_chat/presentations/widgets/ripple_effect.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _globalKey = GlobalKey();
  final ValueNotifier<List<ChatMessage>> _listMessages = ValueNotifier([]);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  late Size searchBarSize;

  Future<void> getMessage({required String question}) async{
    _listMessages.value = _listMessages.value..add(ChatMessage(
      id: Random().nextInt(1000).toString(),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      chatMessage: question,
      userType: UserType.user,
    ));
    _isLoading.value = true;
    final ChatRepository repository = ChatRepository();
    final message = await repository.getMessage(question: question);
    _isLoading.value = false;
    _listMessages.value = _listMessages.value..add(message);
    scrollToTheEnd();
  }

  void removeFocus() => FocusScope.of(context).unfocus();

  void scrollToTheEnd(){
    if(_scrollController.hasClients && _scrollController.offset >= _scrollController.position.maxScrollExtent){
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent + searchBarSize.height);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      searchBarSize = getBoxSize(_globalKey.currentContext!);
      setState(() {});
    });
  }

  Size getBoxSize(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    return box.size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chat Application', style: AppStyles.defaultStyle(fontWeight: FontWeight.w600),),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => removeFocus,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppConstants.paddingDefault,
              horizontal: AppConstants.paddingDefault,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _listMessages,
                    builder: (context, messages, _) => messages.isNotEmpty ? ValueListenableBuilder(
                      valueListenable: _isLoading,
                      builder: (context, isLoading, _){
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: isLoading ? messages.length + 1 : messages.length,
                          itemBuilder: (context, index){
                            return isLoading && index >= messages.length ? Padding(
                              padding: EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
                              child: const JumpingDots()
                            )
                              : getMessageBox(messages[index]);
                          }
                        );
                      },
                    ) : lottieWaiting(),
                  ),
                ),
                Container(
                  key: _globalKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: ChatTextField(
                          controller: _textController,
                          onSend: () async{
                            removeFocus();
                            scrollToTheEnd();
                            getMessage(question: _textController.text.trim());
                            _textController.text = '';
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: AppConstants.paddingSmall),
                        child: RippleEffect(
                          onPressed: (){},
                          child: const AssetIcon(icon: AppPath.icMic, color: AppColors.grey, size: AppConstants.iconSizeBig),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget lottieWaiting() => Lottie.asset(AppPath.lottieWaiting, width: AppConstants.width, height: 100, repeat: true);

  Widget getMessageBox(ChatMessage chat){
    final isUserChat = chat.userType == UserType.user;
    return Align(
      alignment: isUserChat ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(AppConstants.paddingSmall),
        margin: EdgeInsets.only(
          bottom: AppConstants.paddingLarge,
          right: isUserChat ? 0.0 : AppConstants.paddingSuperHuge,
          left: isUserChat ? AppConstants.paddingSuperHuge : 0.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radiusContainer).copyWith(
            bottomLeft: isUserChat ? const Radius.circular(AppConstants.radiusContainer) : const Radius.circular(0.0),
            bottomRight: isUserChat ? const Radius.circular(0.0) : const Radius.circular(AppConstants.radiusContainer),
          ),
          color: isUserChat ? AppColors.brightBlue : AppColors.grey.withOpacity(.2),
        ),
        child: Text(chat.chatMessage, style: AppStyles.defaultStyle(textColor: isUserChat ? AppColors.white : AppColors.black),),
      ),
    );
  }
}

