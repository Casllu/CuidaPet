import 'package:cuidapet/app/modules/auth/register/register_controller.dart';
import 'package:cuidapet/app/modules/auth/register/register_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => RegisterController(
              userService: i(), // AuthModule
              log: i(), // CoreModule
            ))
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute(Modular.initialRoute, child: (_, __) => RegisterPage())];
}
