import 'package:cuidapet/app/modules/address/address_module.dart';
import 'package:cuidapet/app/modules/auth/auth_module.dart';
import 'package:cuidapet/app/modules/core/core_module.dart';
import 'package:cuidapet/app/modules/home/home_module.dart';
import 'package:cuidapet/app/modules/supplier/supplier_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/schedules/schedules_module.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => const [];

  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/auth/', module: AuthModule()),
        ModuleRoute('/home/', module: HomeModule()),
        ModuleRoute('/address/', module: AddressModule()),
        ModuleRoute('/supplier/', module: SupplierModule()),
        ModuleRoute('/schedules/', module: SchedulesModule()),
        
      ];
}
