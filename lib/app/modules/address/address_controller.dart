// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet/app/core/ui/widgets/loader.dart';
import 'package:cuidapet/app/core/ui/widgets/messages.dart';
import 'package:cuidapet/app/entities/address_entity.dart';
import 'package:cuidapet/app/models/place_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cuidapet/app/core/life_cycle/controller_life_cycle.dart';

import '../../services/address/address_service.dart';

part 'address_controller.g.dart';

class AddressController = AddressControllerBase with _$AddressController;

abstract class AddressControllerBase with Store, ControllerLifeCycle {
  final AddressService _addressService;

  @readonly
  var _addresses = <AddressEntity>[];

  @readonly
  var _locationServiceUnavailable = false;

  @readonly
  LocationPermission? _locationPermission;

  @readonly
  PlaceModel? _placeModel;

  AddressControllerBase({
    required AddressService addressService,
  }) : _addressService = addressService;

  @override
  void onReady() {
    getAddresses();
  }

  @action
  Future<void> getAddresses() async {
    Loader.show();
    _addresses = await _addressService.getAddress();
    Loader.hide();
  }

  @action
  Future<void> myLocation() async {

    _locationPermission = null;
    _locationServiceUnavailable = false;

    final serviceEnable = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnable) {
      _locationServiceUnavailable = true;
      return;
    }

    final locationPermission = await Geolocator.checkPermission();

    switch (locationPermission) {
      case LocationPermission.denied:
        final permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          _locationPermission = permission;
          return;
        }

        break;
      case LocationPermission.deniedForever:
        _locationPermission = locationPermission;
        break;
      case LocationPermission.whileInUse:
      case LocationPermission.always:
      case LocationPermission.unableToDetermine:
        break;
    }

    Loader.show();
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final placemark = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: 'pt_BR');
    final place = placemark.first;
    final address = '${place.thoroughfare} ${place.subThoroughfare}';
    final placeModel = PlaceModel(
        address: address, lat: position.latitude, lng: position.longitude);
    Loader.hide();
    goToAddressDetail(placeModel);
  }

  Future<void> goToAddressDetail(PlaceModel place) async {
    final address = await Modular.to.pushNamed('/address/detail/', arguments: place);
    if(address is PlaceModel) { // Quer dizer que estou editando um endereço
      _placeModel = address;
    } else if(address is AddressEntity) { // Salvou um endereço
      selectAddress(address);
    }
    
  }

  Future<void> selectAddress(AddressEntity addressEntity) async {
    await _addressService.selectAddress(addressEntity);
    Modular.to.pop(addressEntity);
  }

  Future<bool> addressWasSelected() async {
    final address = await _addressService.getAddressSelected();

    if(address != null) {
      return true;
    } else {
      Messages.alert('Por favor selecione ou cadastre um endereço');
      return false;
    }
  }
}
