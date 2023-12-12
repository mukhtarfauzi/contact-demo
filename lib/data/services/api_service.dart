import 'package:contact_demo/data/repositories/rest_client.dart';
import 'package:contact_demo/providers/auth.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiService {
  late RestClient restClient;
  final _dio = Dio();

  ApiService([AuthProvider? auth]) {
    final logger = Logger();
    _dio.interceptors.add(
      LogInterceptor(responseBody: true, requestBody: true),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          logger.w("${request.uri}\n${request.data}");
          if (auth?.auth != null && auth?.auth?.token != '') {
            request.headers['Authorization'] = 'Bearer ${auth?.auth?.token!}';
          }
          return handler.next(request);
        },
        onResponse: (response, handler) {
          logger.i(response);
          return handler.next(response);
        },
        onError: (e, handler) async {
          logger.e(e.response ?? e.error);
          if (e.response?.statusCode == 401) {
            if (auth?.auth != null && auth?.auth?.token != '') {
              auth!.logout();
            }
          }
          return handler.next(e);
        },
      ),
    );
    restClient = RestClient(_dio);
  }
}