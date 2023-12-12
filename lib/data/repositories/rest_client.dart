import 'package:contact_demo/data/models/contact_list_model.dart';
import 'package:contact_demo/helpers/constant.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: baseApi)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(connectTimeout: const Duration(seconds: 900), );

    return _RestClient(dio, baseUrl: baseUrl);
  }

  @GET("/9cbc0889-47b2-40a0-aa5f-3b2e63fbf70e")
  Future<ContactList> getContact();
}
