import 'package:dio/src/response.dart';

import '../all_packages.dart' hide Response;

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://www.freetogame.com/api/",
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {"Content-Type": "application/json"},
    ),
  );
}

class ApiService {
  Future<Response<dynamic>> getGames() async {
    return await DioClient.dio.get("games");
  } 
}
