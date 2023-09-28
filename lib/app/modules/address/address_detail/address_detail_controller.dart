// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet/app/entities/address_entity.dart';
import 'package:cuidapet/app/models/place_model.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapet/app/services/address/address_service.dart';

import '../../../core/ui/widgets/loader.dart';

part 'address_detail_controller.g.dart';

class AddressDetailController = AddressDetailControllerBase
    with _$AddressDetailController;

abstract class AddressDetailControllerBase with Store {
  final AddressService _addressService;

  @readonly
  AddressEntity? _addressEntity;

  AddressDetailControllerBase({
    required AddressService addressService,
  }) : _addressService = addressService;

  Future<void> saveAddress(PlaceModel placeModel, String additional) async {
    Loader.show();
    final addressEntity = await _addressService.saveAddress(placeModel, additional);
    Loader.hide();
    _addressEntity = addressEntity;
  }
}
