import 'package:cuidapet/app/core/database/sqlite_connection_factory.dart';
import 'package:cuidapet/app/core/exception/failure.dart';
import 'package:cuidapet/app/core/helpers/environments.dart';
import 'package:cuidapet/app/entities/address_entity.dart';
import 'package:cuidapet/app/models/place_model.dart';
import 'package:google_place/google_place.dart';

import './address_repository.dart';

class AddressRepositoryImpl extends AddressRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  AddressRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<PlaceModel>> finAddressByGooglePlaces(
      String addressPattern) async {
    final googleApiKey = Environments.param('google_api_key');

    if (googleApiKey == null) {
      throw Failure(message: 'Google api key not found');
    }

    final googlePlace = GooglePlace(googleApiKey);
    final addressResult =
        await googlePlace.search.getTextSearch(addressPattern);
    final candidadtes = addressResult?.results;

    if (candidadtes != null) {
      return candidadtes.map<PlaceModel>((searchResult) {
        final location = searchResult.geometry?.location;
        final address = searchResult.formattedAddress;

        return PlaceModel(
          address: address ?? '',
          lat: location?.lat ?? 0,
          lng: location?.lng ?? 0,
        );
      }).toList();
    }
    return <PlaceModel>[];
  }

  @override
  Future<void> deleteAll() async {
    final sqliteConn = await _sqliteConnectionFactory.openConnection();
    await sqliteConn.delete('address');
  }

  @override
  Future<List<AddressEntity>> getAddress() async {
    final sqliteConn = await _sqliteConnectionFactory.openConnection();
    final result = await sqliteConn.rawQuery('select * from address');
    return result
        .map<AddressEntity>((address) => AddressEntity.fromMap(address))
        .toList();
  }

  @override
  Future<int> saveAddress(AddressEntity entity) async {
    final sqliteConn = await _sqliteConnectionFactory.openConnection();
    return await sqliteConn.rawInsert(
      'insert into address values(?,?,?,?,?)',
      [
        null,
        entity.address,
        entity.lat,
        entity.lng,
        entity.additional,
      ],
    );
  }
}
