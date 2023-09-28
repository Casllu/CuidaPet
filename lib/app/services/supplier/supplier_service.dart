import '../../entities/address_entity.dart';
import '../../models/supplier_categories_model.dart';
import '../../models/supplier_model.dart';
import '../../models/supplier_nearby_me_model.dart';
import '../../models/supplier_services_Model.dart';

abstract class SupplierService {
  Future<List<SupplierCategoryModel>> getCategories();
  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity address);
  Future<SupplierModel> findById(int id);
  Future<List<SupplierServicesModel>> findServices(int supplierId);
}
