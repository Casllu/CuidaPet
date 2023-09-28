import 'package:cuidapet/app/modules/schedules/schedules_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SchedulesModule extends Module {

   @override
   List<Bind> get binds => [];

   @override
   List<ModularRoute> get routes => [
      ChildRoute('/', child: (context, args) => SchedulesPage())
   ];

}