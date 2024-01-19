import 'package:ai_chat/constants/app_path.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio get dio => Dio()
    ..options.baseUrl = AppPath.url
    ..options.headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${AppPath.apiKey}"
    }
    ..options.validateStatus = (status) => status! < 500;
}
