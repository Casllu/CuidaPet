import '../../../models/supplier_services_Model.dart';

class ScheduleViewModel {
  final int supplierId;
  final List<SupplierServicesModel> sevices;
  
  ScheduleViewModel({
    this.supplierId = 0,
    this.sevices = const [],
  });
}
