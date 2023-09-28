// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet/app/entities/address_entity.dart';
import 'package:cuidapet/app/models/supplier_categories_model.dart';
import 'package:cuidapet/app/models/supplier_model.dart';
import 'package:cuidapet/app/models/supplier_nearby_me_model.dart';
import 'package:cuidapet/app/models/supplier_services_Model.dart';
import 'package:cuidapet/app/repositories/supplier/supplier_repository.dart';

import './supplier_service.dart';

class SupplierServiceImpl extends SupplierService {
  final SupplierRepository _repository;
  
  SupplierServiceImpl({
    required SupplierRepository repository,
  }) : _repository = repository;

  
  
  @override
  Future<List<SupplierCategoryModel>> getCategories() => _repository.getCategories();

  @override
  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity address) => _repository.findNearBy(address);

  @override
  Future<SupplierModel> findById(int id) => _repository.findById(id);

  @override
  Future<List<SupplierServicesModel>> findServices(int supplierId) => _repository.findServices(supplierId);

}
