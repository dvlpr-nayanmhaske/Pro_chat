import 'package:commet_chat/core/services/locator.dart';
import 'package:commet_chat/core/services/tokens.dart';
import 'package:commet_chat/features/Authentication/bloc/Authentication_bloc.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiClient {
  late final Dio dio;
  late final Logger logger;

  final host = "http://localhost:3000/api/v1";

  ApiClient() {
    logger = Logger(
      printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5),
    );

    dio = Dio(
      BaseOptions(
        baseUrl: host,
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: Duration(seconds: 15),
        headers: {"Content-Type": "application/json"},
      ),
    );

    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = Tokens.accessToken;
          if (token != null) {
            options.headers['Authorization'] = "Bearer $token";
          }

          handler.next(options);
        },

        onResponse: (options, handler) async {
          if (options.statusCode == 401 && Tokens.refreshToken != null) {
            try {
              final token = await refreshTokens();

              try {
                final requestOptions = options.requestOptions;
                requestOptions.headers['Authorization'] = "Bearer $token";

                final retryResponse = await dio.fetch(requestOptions);
                handler.next(retryResponse);
              } on DioException catch (e) {
                if (e.response?.statusCode == 401) {
                  locator<AuthenticationBloc>().add(LogOutEvent());
                }
                return handler.reject(e);
              }
            } catch (e) {
              locator<AuthenticationBloc>().add(LogOutEvent());

              // CLEAR USER DATA
              handler.reject(
                DioException(
                  requestOptions: options.requestOptions,
                  message: e.toString(),
                ),
              );
            }
          }

          handler.next(options);
        },
      ),

      // FOR LOGGING
      InterceptorsWrapper(
        onRequest: (options, handler) {
          logger.d("SENDING REQUEST :  ${options.uri}");
          if (options.data != null) {
            logger.d("SENDING PAYLOAD");
            logger.d(options.data);
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          logger.d("RECEIVED RESPONSE : ");
          logger.d(response.data);

          handler.next(response);
        },
      ),
    ]);
  }

  Future<String?> refreshTokens() async {}
}
