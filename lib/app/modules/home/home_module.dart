import 'package:cuidapet/app/modules/core/supplier/supplier_core_module.dart';
import 'package:cuidapet/app/modules/home/home_controller.dart';
import 'package:cuidapet/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => HomeController(
              addressService: i(),
              supplierService: i(),
            )),
      ];

  @override
  List<Module> get imports => [
        SupplierCoreModule(),
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute(Modular.initialRoute, child: (_, __) => const HomePage())];
}
