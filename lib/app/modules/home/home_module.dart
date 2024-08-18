import 'package:effecti_challenge/app/app_module.dart';
import 'package:effecti_challenge/app/modules/home/data/services/data_service_impl.dart';
import 'package:effecti_challenge/app/modules/home/data/crud/delete_tasks_impl.dart';
import 'package:effecti_challenge/app/modules/home/data/crud/read_tasks_impl.dart';
import 'package:effecti_challenge/app/modules/home/data/crud/create_update_tasks_impl.dart';
import 'package:effecti_challenge/app/modules/home/interactor/blocs/home_bloc.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/data_service.dart';
import 'package:effecti_challenge/app/modules/home/interactor/crud/delete_tasks.dart';
import 'package:effecti_challenge/app/modules/home/interactor/crud/read_tasks.dart';
import 'package:effecti_challenge/app/modules/home/interactor/crud/create_update_tasks.dart';
import 'package:effecti_challenge/app/modules/home/ui/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(i) {
    i.add<ReadTasks>(ReadTasksImpl.new);
    i.add<CreateUpdateTasks>(CreateUpdateTasksImpl.new);
    i.add<DeleteTasks>(DeleteTasksImpl.new);
    i.add<DataService>(DataServiceImpl.new);
    i.addSingleton<HomeBloc>(HomeBloc.new,
        config: BindConfig(onDispose: (bloc) => bloc.close()));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
