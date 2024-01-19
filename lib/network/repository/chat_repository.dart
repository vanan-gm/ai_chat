import 'package:ai_chat/constants/app_path.dart';
import 'package:ai_chat/model/chat_message.dart';
import 'package:ai_chat/network/helper/dio_helper.dart';
import 'package:dio/dio.dart';

class ChatRepository{
  final Dio _dio = DioHelper.dio;

  Future<ChatMessage> getMessage({required String question}) async{
    final Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "user",
          "content": question,
        }
      ]
    };
    final Response<Map<String, dynamic>> response = await _dio.post(AppPath.endPoint, data: body);
    if(response.statusCode == 200){
      return ChatMessage.fromJson(response.data!);
    }else{
      return ChatMessage();
    }
  }
}