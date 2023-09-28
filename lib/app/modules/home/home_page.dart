import 'package:cuidapet/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet/app/core/ui/extensions/theme_extensions.dart';
import 'package:cuidapet/app/entities/address_entity.dart';
import 'package:cuidapet/app/models/supplier_categories_model.dart';
import 'package:cuidapet/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/supplier_nearby_me_model.dart';
import 'widgets/home_app_bar.dart';

part 'widgets/home_address_widget.dart';
part 'widgets/home_categories_widget.dart';
part 'widgets/home_supplier_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
  AddressEntity? addressEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            HomeAppBar(controller),
            SliverToBoxAdapter(
              child: _HomeAddressWidget(
                controller: controller,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _HomeCategoriesWidget(controller),
                ],
              ),
            ),
          ];
        },
        body: _HomeSupplierTab(homeController: controller,),
      ),
    );
  }
}
