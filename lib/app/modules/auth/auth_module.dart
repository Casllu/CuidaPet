import 'package:cuidapet/app/modules/auth/home/auth_home_page.dart';
import 'package:cuidapet/app/modules/auth/login/login_module.dart';
import 'package:cuidapet/app/modules/auth/register/register_module.dart';
import 'package:cuidapet/app/repositories/user/user_repository.dart';
import 'package:cuidapet/app/repositories/user/user_repository_impl.dart';
import 'package:cuidapet/app/services/users/user_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../repositories/social/social_repository.dart';
import '../../repositories/social/social_repository_impl.dart';
import '../../services/users/user_service_impl.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<SocialRepository>((i) => SocialRepositoryImpl()),
        Bind.lazySingleton<UserRepository>((i) => UserRepositoryImpl(
              log: i(), //CoreModule
              restClient: i(), //CoreModule
            )),
        Bind.lazySingleton<UserService>((i) => UserServiceImpl(
              log: i(), // CoreModule
              userRepository: i(), // AuthModule
              localStorage: i(), // CoreModule
              localSecureStorage: i(),
              socialRepository: i(), // CoreModule
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, __) => AuthHomePage(
                  authStore: Modular.get(),
                )),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/register', module: RegisterModule()),
      ];
}
