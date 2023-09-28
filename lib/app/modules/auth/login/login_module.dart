import 'package:cuidapet/app/modules/auth/login/login_controller.dart';
import 'package:cuidapet/app/modules/auth/login/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => LoginController(
              userService: i(), // AuthModule
              log: i(), //CoreModule
            )),
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute(Modular.initialRoute, child: (_, __) => LoginPage())];
}
