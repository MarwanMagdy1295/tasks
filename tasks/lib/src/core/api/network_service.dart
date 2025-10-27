// // ignore_for_file: body_might_complete_normally_nullable

// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:tasks/src/core/services/prefs_service.dart';

// class NetworkService {
//   final PrefsService _prefsService;

//   NetworkService({required PrefsService prefsService})
//     : _prefsService = prefsService {
//     _init();
//   }

//   late final Dio dio;

//   final baseUrl = 'https://backend.alzawahed.net/api/v1/';
//   //'https://backendzawahed.globaldirections.sa/api/v1/';
//   void _init() {
//     final options = BaseOptions(
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//       baseUrl: baseUrl,
//       receiveTimeout: const Duration(seconds: 30),
//       connectTimeout: const Duration(seconds: 30),
//       sendTimeout: const Duration(seconds: 30),
//       receiveDataWhenStatusError: true,
//     );

//     dio = Dio(options);

//     final logger = LogInterceptor(
//       responseHeader: false,
//       responseBody: true,
//       requestBody: true,
//     );

//     final authExpiration = InterceptorsWrapper(
//       onError: (e, handler) async {
//         if (e.response?.statusCode == HttpStatus.unauthorized) {
//           // await di<UserRepository>().removeUser();
//           // AppRouter.i.refresh();
//           return handler.next(e);
//         }

//         return handler.next(e);
//       },
//     );

//     dio.interceptors.add(logger);
//     dio.interceptors.add(authExpiration);
//     dio.interceptors.add(
//       PrettyDioLogger(
//         requestHeader: true,
//         requestBody: true,
//         responseBody: true,
//         responseHeader: true,
//         error: true,
//         compact: true,
//         maxWidth: 90,
//       ),
//     );
//   }

//   Options? getHeader({bool? token}) {
//     if (token != null && token) {
//       return Options(
//         headers: {
//           'Authorization': 'Bearer di<PrefsService>().token.get()}',
//           // 'Authorization': 'Bearer ',
//           'Accept-Languag': _prefsService.locale.get(),
//         },
//       );
//     } else {
//       return Options(headers: {'Accept-Languag': _prefsService.locale.get()});
//     }
//   }

//   Future<Response> getData({
//     required String url,
//     Map<String, dynamic>? query,
//     String lang = 'en',
//     bool token = false,
//     bool queue = true,
//   }) async {
//     return await dio.get(
//       url,
//       queryParameters: query,
//       options: getHeader(token: token),
//     );
//   }

//   Future<Response> deleteData({
//     required String url,
//     Map<String, dynamic>? query,
//     String lang = 'en',
//     bool token = false,
//     bool queue = true,
//   }) async {
//     return await dio.delete(
//       url,
//       queryParameters: query,
//       options: getHeader(token: token),
//     );
//   }

//   Future<Response> postData({
//     required String url,
//     Map<String, dynamic>? query,
//     dynamic data,
//     String lang = 'ar',
//     bool token = false,
//     bool queue = true,
//   }) async {
//     return await dio.post(
//       url,
//       data: data,
//       queryParameters: query,
//       options: getHeader(token: token),
//     );
//   }

//   Future<Response> putData({
//     required String url,
//     Map<String, dynamic>? query,
//     Map<String, dynamic>? data,
//     String lang = 'ar',
//     bool token = false,
//     bool queue = true,
//   }) async {
//     return await dio.put(
//       url,
//       data: data,
//       queryParameters: query,
//       options: getHeader(token: token),
//     );
//   }

//   Future<Response> patchData({
//     required String url,
//     Map<String, dynamic>? query,
//     Map<String, dynamic>? data,
//     String lang = 'ar',
//     bool token = false,
//     bool queue = true,
//   }) async {
//     return await dio.patch(
//       url,
//       data: data,
//       queryParameters: query,
//       options: getHeader(token: token),
//     );
//   }
// }
