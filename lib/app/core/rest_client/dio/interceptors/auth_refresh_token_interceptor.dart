import 'package:cuidapet/app/core/exception/expire_token_exception.dart';
import 'package:cuidapet/app/core/helpers/constants.dart';
import 'package:cuidapet/app/core/logger/app_logger.dart';
import 'package:cuidapet/app/core/rest_client/rest_client_exception.dart';
import 'package:dio/dio.dart';

import '../../../../modules/core/auth/auth_store.dart';
import '../../../local_storage/local_storage.dart';
import '../../rest_client.dart';

class AuthRefreshTokenInterceptor extends Interceptor {
  final AuthStore _authStore;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final RestClient _restClient;
  final AppLogger _log;

  AuthRefreshTokenInterceptor({
    required AuthStore authStore,
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required RestClient restClient,
    required AppLogger log,
  })  : _authStore = authStore,
        _localStorage = localStorage,
        _localSecureStorage = localSecureStorage,
        _restClient = restClient,
        _log = log;

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    try {
      final respStatusCode = err.response?.statusCode ?? 0;
      final reqPath = err.requestOptions.path;

      if (respStatusCode == 403 || respStatusCode == 401) {
        if (reqPath != '/auth/refresh') {
          final authRequired = err.requestOptions
                  .extra[Constants.REST_CLIENT_AUTH_REQUIRED_KEY] ??
              false;

          if (authRequired) {
            _log.append('################ Refresh token ################');
            await _refreshToken(err);
            await _retryRequest(err, handler);
          } else {
            throw err;
          }
        } else {
          throw err;
        }
      } else {
        throw err;
      }
    } on ExpireTokenException {
      _authStore.logout();
      handler.next(err);
    } on DioException catch (e) {
      handler.next(e);
    } catch (e, s) {
      _log.error('Erro restClient', e, s);
      handler.next(err);
    } finally {
      _log.closeAppend();
    }
  }

  Future<void> _refreshToken(DioException err) async {
    try {
  final refreshToken = await _localSecureStorage
      .read(Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY);
  
  if (refreshToken == null) {
    throw ExpireTokenException();
  }
  
  final resultRefresh = await _restClient.auth().put('/auth/refresh', data: {
    'refresh_toke': refreshToken,
  });
  
  await _localStorage.write<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY,
      resultRefresh.data['access_token']);
  
  await _localSecureStorage.write(Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY,
      resultRefresh.data['access_token']);
} on RestClientException catch (e, s) {
  _log.error('Erro ao tentar fazer refresh token', e, s);
  throw ExpireTokenException();

}
  }

  Future<void> _retryRequest(
      DioException err, ErrorInterceptorHandler handler) async {
    _log.append('##################### Retry request #####################');
    final requestOptions = err.requestOptions;
    final result = await _restClient.request(
      requestOptions.path,
      method: requestOptions.method,
      data: requestOptions.data,
      headers: requestOptions.headers,
      querryParameters: requestOptions.queryParameters,
    );

    handler.resolve(
      Response(
        requestOptions: requestOptions,
        data: result.data,
        statusCode: result.statusCode,
        statusMessage: result.statusMensage,
      ),
    );
  }
}
