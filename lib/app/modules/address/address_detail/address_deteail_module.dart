import 'package:cuidapet/app/modules/address/address_detail/address_detail_page.dart';
import 'package:cuidapet/app/modules/address/address_detail/address_detail_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressDeteailModule extends Module {

  @override
  List<Bind<Object>> get binds => [
    Bind.lazySingleton((i) => AddressDetailController(addressService: i()))
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => AddresDetailPage(place: args.data),
        ),
      ];
}
