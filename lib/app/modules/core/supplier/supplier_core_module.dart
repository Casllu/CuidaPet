import 'package:cuidapet/app/repositories/supplier/supplier_repository.dart';
import 'package:cuidapet/app/repositories/supplier/supplier_repository_impl.dart';
import 'package:cuidapet/app/services/supplier/supplier_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../services/supplier/supplier_service_impl.dart';

class SupplierCoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<SupplierRepository>(
            (i) => SupplierRepositoryImpl(
                  restClient: i(), // coreModule
                  log: i(), // coreModule
                ),
            export: true),
        Bind.lazySingleton<SupplierService>(
            (i) => SupplierServiceImpl(repository: i()),
            export: true),
      ];
}
