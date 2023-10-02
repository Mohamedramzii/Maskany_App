import 'package:dio/dio.dart';

import '../../../core/constants.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) async {
    //     if (await _isConnected()) {
    //       handler.next(options);
    //     } else {
    //       handler.reject(DioError(
    //           error: 'No internet connection available.',
    //           requestOptions: options));
    //     }
    //   },
    // ));
    dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          // 'lang': 'en',
        },
        receiveDataWhenStatusError: true));
  }

  // static Future<bool> _isConnected() async {
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   return connectivityResult != ConnectivityResult.none;
  // }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    // String? lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      // 'lang': lang,
      'Authorization': token,
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
