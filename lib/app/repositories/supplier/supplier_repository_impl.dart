// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet/app/core/exception/failure.dart';
import 'package:cuidapet/app/core/logger/app_logger.dart';
import 'package:cuidapet/app/core/rest_client/rest_client_exception.dart';

import 'package:cuidapet/app/core/rest_client/rest_client.dart';
import 'package:cuidapet/app/models/supplier_categories_model.dart';
import 'package:cuidapet/app/models/supplier_model.dart';
import 'package:cuidapet/app/models/supplier_nearby_me_model.dart';
import 'package:cuidapet/app/models/supplier_services_Model.dart';

import '../../entities/address_entity.dart';
import './supplier_repository.dart';

class SupplierRepositoryImpl extends SupplierRepository {
  final RestClient _restClient;
  final AppLogger _log;

  SupplierRepositoryImpl({
    required RestClient restClient,
    required AppLogger log,
  })  : _restClient = restClient,
        _log = log;

  @override
  Future<List<SupplierCategoryModel>> getCategories() async {
    try {
      final result = await _restClient.auth().get('/categories/');

      return result.data
          ?.map<SupplierCategoryModel>(
            (categoryResponse) =>
                SupplierCategoryModel.fromMap(categoryResponse),
          )
          .toList();
    } on RestClientException catch (e, s) {
      final message = 'Erro ao buscar categorias dos fornecedores';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }

  @override
  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity address) async {
    try {
      final result =
          await _restClient.auth().get('/suppliers/', querryParameters: {
        'lat': address.lat,
        'lng': address.lng,
      });
      return result.data
          ?.map<SupplierNearbyMeModel>((supplierResponse) =>
              SupplierNearbyMeModel.fromMap(supplierResponse))
          .toList();
    } on RestClientException catch (e, s) {
      const message = 'Erro ao buscar fornecedores perto de mim';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }

  @override
  Future<SupplierModel> findById(int id) async {
    try {
      final result = await _restClient.auth().get('/suppliers/$id');

      return SupplierModel.fromMap(result.data);
    } on RestClientException catch (e, s) {
      var message = 'Erro ao buscar dados do fornecedor por id';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }

  @override
  Future<List<SupplierServicesModel>> findServices(int supplierId) async {
    try {
      final result =
          await _restClient.auth().get('/suppliers/$supplierId/services');
      final servicesList = result.data
              ?.map<SupplierServicesModel>(
                  (jService) => SupplierServicesModel.fromMap(jService))
              .toList() ??
          <SupplierServicesModel>[];

      return servicesList;
    } on RestClientException catch (e, s) {
      var message = 'Erro ao buscar serviços do fronecedor';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }
}
