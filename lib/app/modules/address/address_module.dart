import 'package:cuidapet/app/modules/address/address_controller.dart';
import 'package:cuidapet/app/modules/address/address_detail/address_deteail_module.dart';
import 'package:cuidapet/app/modules/address/address_page.dart';
import 'package:cuidapet/app/modules/address/widgets/address_search_widget/address_search_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => AddressController(
              addressService: i(), // CoreModule
            )),
        Bind.lazySingleton(
          (i) => AddressSearchController(
            addressService: i(), // CoreModule
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, __) => AddressPage()),
        ModuleRoute('/detail', module: AddressDeteailModule()),
      ];
}
