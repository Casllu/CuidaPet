
import 'package:cuidapet/app/entities/address_entity.dart';
import 'package:cuidapet/app/models/supplier_categories_model.dart';
import 'package:cuidapet/app/models/supplier_nearby_me_model.dart';
import 'package:cuidapet/app/models/supplier_services_Model.dart';

import '../../models/supplier_model.dart';

abstract class SupplierRepository {
  Future<List<SupplierCategoryModel>> getCategories();
  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity address);
  Future<SupplierModel> findById(int id);
  Future<List<SupplierServicesModel>> findServices(int supplierId);
}