import 'package:contact_demo/providers/auth_firebase.dart';
import 'package:contact_demo/data/repositories/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiService {
  late RestClient restClient;
  final _dio = Dio();

  ApiService([AuthFirebaseProvider? auth]) {
    final logger = Logger();
    _dio.interceptors.add(
      LogInterceptor(responseBody: true, requestBody: true),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          logger.w("${request.uri}\n${request.data}");
          // Notes: it will uses when you have dedicated rest API
          // if (auth != null && auth.currentUser?.refreshToken != '') {
          //   request.headers['Authorization'] = 'Bearer ${auth.currentUser?.refreshToken!}';
          // }
          return handler.next(request);
        },
        onResponse: (response, handler) {
          logger.i(response);
          return handler.next(response);
        },
        onError: (e, handler) async {
          logger.e(e.response ?? e.error);
          if (e.response?.statusCode == 401) {
            // Notes: if using rest API we can logout here
            // auth!.logout();
          }
          return handler.next(e);
        },
      ),
    );
    restClient = RestClient(_dio);
  }
}