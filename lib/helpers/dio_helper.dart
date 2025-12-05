import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dio;

  // Initialization method
  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'lang': 'en',
        },
        // Validate status: allows handling 400/404 errors manually without throwing exception
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    // Add LogInterceptor to view data in terminal
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  // Helper method to set Authorization header
  static void _setHeaders(String? token) {
    if (token != null && token.isNotEmpty) {
      _dio.options.headers['Authorization'] = token;
    } else {
      // Remove token if empty to avoid 404 errors from server
      _dio.options.headers.remove('Authorization');
    }
  }

  // 1. GET DATA
  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    _setHeaders(token);
    return await _dio.get(
      path,
      queryParameters: queryParameters,
    );
  }

  // 2. POST DATA
  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    _setHeaders(token);

    // --- MOCK SERVER LOGIC START ---
    if (path.contains('login')) {
      print("MOCK SERVER: Simulating Login Success");
      await Future.delayed(
          const Duration(seconds: 2)); // Simulate network delay
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 200,
        data: {
          "status": true,
          "message": "Login Successful (Mock Mode)",
          "data": {
            "id": 1,
            "name": "Mostafa",
            "email": body['email'] ?? "test@test.com",
            "phone": "0123456789",
            "image": "https://img.freepik.com/free-icon/user_318-159711.jpg",
            "points": 0,
            "credit": 0,
            "token": "mock_token_123456"
          }
        },
      );
    }

    if (path.contains('register')) {
      print("MOCK SERVER: Simulating Register Success");
      await Future.delayed(const Duration(seconds: 2));
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 200,
        data: {
          "status": true,
          "message": "Register Successful (Mock Mode)",
          "data": {
            "id": 1,
            "name": body['name'] ?? "Mostafa",
            "email": body['email'],
            "phone": body['phone'],
            "image": "https://img.freepik.com/free-icon/user_318-159711.jpg",
            "token": "mock_token_123456"
          }
        },
      );
    }
    // --- MOCK SERVER LOGIC END ---

    return await _dio.post(
      path,
      queryParameters: queryParameters,
      data: body,
    );
  }

  // 3. PUT DATA
  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    _setHeaders(token);
    return await _dio.put(
      path,
      queryParameters: queryParameters,
      data: body,
    );
  }

  // 4. DELETE DATA
  static Future<Response> deleteData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    _setHeaders(token);
    return await _dio.delete(
      path,
      queryParameters: queryParameters,
      data: body,
    );
  }
}
