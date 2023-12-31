import 'package:cuidapet/app/core/ui/extensions/theme_extensions.dart';
import 'package:cuidapet/app/models/supplier_model.dart';
import 'package:cuidapet/app/modules/supplier/supplier_controller.dart';
import 'package:flutter/material.dart';

class SupplierDetail extends StatelessWidget {
  final SupplierModel supplier;
  final SupplierController controller;

  const SupplierDetail(
      {super.key, required this.supplier, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Center(
            child: Text(
              supplier.name,
              style: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: context.primaryColor,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Informações do estabelecimento',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        ListTile(
          onTap: controller.goToGeoOrCopyPhoneToClipart,
          leading: const Icon(
            Icons.location_city,
            color: Colors.black,
          ),
          title: Text(supplier.address),
        ),
        ListTile(
          onTap: controller.goToPhoneOrCopyPhoneToClipart,
          leading: const Icon(
            Icons.local_phone,
            color: Colors.black,
          ),
          title: Text(supplier.phone),
        ),
        Divider(
          thickness: 1,
          color: context.primaryColor,
        ),
      ],
    );
  }
}
