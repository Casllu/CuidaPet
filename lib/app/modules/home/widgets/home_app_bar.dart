import 'package:cuidapet/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet/app/core/ui/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/debouncer.dart';
import '../home_controller.dart';

class HomeAppBar extends SliverAppBar {
  HomeAppBar(HomeController controller, {super.key})
      : super(
            expandedHeight: 100,
            collapsedHeight: 100,
            elevation: 0,
            flexibleSpace: _CuidapetAppBar(
              controller,
            ),
            iconTheme: IconThemeData(color: Colors.black),
            pinned: true);
}

class _CuidapetAppBar extends StatelessWidget {
  final HomeController controller;
  final _debouncer = Debouncer(milliseconds: 500);

  _CuidapetAppBar(this.controller);

  @override
  Widget build(BuildContext context) {
    final outLineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.grey[200]!));

    return AppBar(
      backgroundColor: Colors.grey[100],
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Text('CuidaPet'),
      ),
      actions: [
        IconButton(
          onPressed: () {
            controller.goToAddressPage();
          },
          icon: const Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
      ],
      elevation: 0,
      flexibleSpace: Stack(
        children: [
          Container(
            height: 110.h,
            color: context.primaryColor,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: .9.sw,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(30),
                child: TextFormField(
                  onChanged: (value) {
                    _debouncer.run(() {
                      controller.filterSupplierByName(value);
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.grey,
                    ),
                    border: outLineInputBorder,
                    focusedBorder: outLineInputBorder,
                    enabledBorder: outLineInputBorder,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
