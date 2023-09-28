import 'package:cuidapet/app/entities/address_entity.dart';
import 'package:cuidapet/app/models/place_model.dart';

abstract class AddressRepository {
  Future<List<PlaceModel>> finAddressByGooglePlaces(String addressPattern);
  Future<List<AddressEntity>> getAddress();
  Future<int> saveAddress(AddressEntity entity);
  Future<void> deleteAll();
}