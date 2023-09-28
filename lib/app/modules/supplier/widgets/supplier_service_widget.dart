import 'package:cuidapet/app/core/ui/extensions/theme_extensions.dart';
import 'package:cuidapet/app/models/supplier_services_Model.dart';
import 'package:cuidapet/app/modules/supplier/supplier_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/helpers/text_formater.dart';

class SupplierServiceWidget extends StatelessWidget {
  final SupplierServicesModel service;
  final SupplierController controller;

  const SupplierServiceWidget(
      {super.key, required this.service, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(service.name),
      subtitle: Text(TextFormater.formatReal(service.price)),
      leading: const CircleAvatar(child: Icon(Icons.pets)),
      trailing: Observer(
        builder: (_) {
          return IconButton(
            onPressed: () {
              controller.addOrRemoveService(service);
            },
            icon: controller.isServiceSelected(service)
                ? Icon(Icons.remove_circle, size: 30, color: Colors.red)
                : Icon(Icons.add_circle, size: 30, color: context.primaryColor),
          );
        },
      ),
    );
  }
}
