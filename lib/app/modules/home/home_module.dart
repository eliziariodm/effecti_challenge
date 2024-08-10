import 'package:effecti_challenge/app/app_module.dart';
import 'package:effecti_challenge/app/modules/home/data/services/delete_tasks_service_impl.dart';
import 'package:effecti_challenge/app/modules/home/data/services/load_tasks_service_impl.dart';
import 'package:effecti_challenge/app/modules/home/data/services/save_tasks_service_impl.dart';
import 'package:effecti_challenge/app/modules/home/interactor/blocs/home_bloc.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/delete_tasks_service.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/load_tasks_service.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/save_tasks_service.dart';
import 'package:effecti_challenge/app/modules/home/ui/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(i) {
    i.add<LoadTasksService>(LoadTasksServiceImpl.new);
    i.add<SaveTasksService>(SaveTasksServiceImpl.new);
    i.add<DeleteTasksService>(DeleteTasksServiceImpl.new);
    i.addSingleton<HomeBloc>(HomeBloc.new,
        config: BindConfig(onDispose: (bloc) => bloc.close()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
