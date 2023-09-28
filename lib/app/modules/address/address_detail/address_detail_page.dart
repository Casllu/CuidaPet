import 'package:cuidapet/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet/app/core/ui/extensions/theme_extensions.dart';
import 'package:cuidapet/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuidapet/app/modules/address/address_detail/address_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../../../models/place_model.dart';

class AddresDetailPage extends StatefulWidget {
  final PlaceModel place;

  const AddresDetailPage({super.key, required this.place});

  @override
  State<AddresDetailPage> createState() => _AddresDetailPageState();
}

class _AddresDetailPageState extends State<AddresDetailPage> {
  final _additionalEC = TextEditingController();
  final controller = Modular.get<AddressDetailController>();
  late final ReactionDisposer addressEntityDispose;

  @override
  void initState() {
    super.initState();
    addressEntityDispose = reaction((_) => controller.addressEntity, (addressEntity) { 
      if(addressEntity != null) {
        Navigator.pop(context, addressEntity);
      }
    });
  }

  @override
  void dispose() {
    _additionalEC.dispose();
    addressEntityDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: context.primaryColor),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text(
            'Confirme seu endereço',
            style: context.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.place.lat, widget.place.lng),
                zoom: 16,
              ),
              markers: {
                Marker(
                    markerId: const MarkerId('AddressID'),
                    position: LatLng(widget.place.lat, widget.place.lng),
                    infoWindow: InfoWindow(title: widget.place.address)),
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: widget.place.address,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Endereço',
                suffixIcon: IconButton(onPressed: () {
                  Navigator.of(context).pop(widget.place);
                }, icon: Icon(Icons.edit)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _additionalEC,
              decoration: const InputDecoration(
                labelText: 'Complemento',
              ),
            ),
          ),
          SizedBox(
            width: .9.sw,
            height: 60.h,
            child: CuidapetDefaultButton(onPressed: () {
              controller.saveAddress(widget.place, _additionalEC.text);
            }, lable: 'Salvar'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
