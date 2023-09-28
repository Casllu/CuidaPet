import 'package:cuidapet/app/core/exception/failure.dart';
import 'package:cuidapet/app/core/exception/user_not_exists_exception.dart';
import 'package:cuidapet/app/models/social_login_type.dart';
import 'package:cuidapet/app/services/users/user_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/logger/app_logger.dart';
import '../../../core/ui/widgets/loader.dart';
import '../../../core/ui/widgets/messages.dart';
part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final UserService _userService;
  final AppLogger _log;

  LoginControllerBase({
    required UserService userService,
    required AppLogger log,
  })  : _userService = userService,
        _log = log;

  Future<void> login(String login, String password) async {
    try {
      Loader.show();
      await _userService.login(login, password);
      Loader.hide();
      Modular.to.navigate('/auth/');
    } on Failure catch (e, s) {
      final errorMesasge = e.message ?? 'Erro ao realizar login';
      _log.error(errorMesasge, e, s);
      Loader.hide();
      Messages.alert(errorMesasge);
    } on UserNotExistsException {
      const errorMesasge = 'Usuário não encontrado';
      _log.error(errorMesasge);
      Loader.hide();
      Messages.alert(errorMesasge);
    }
  }

  Future<void> socialLogin(SocialLoginType socialLoginType) async {
    try {
      Loader.show();
      await _userService.socialLogin(socialLoginType);
      Loader.hide();
      Modular.to.navigate('/auth/');
    } on Failure catch (e, s) {
      Loader.hide();
      _log.error('Erro ao realizar login', e, s);
      Messages.alert(e.message ?? 'Erro ao realizar login');
    }
  }
}
