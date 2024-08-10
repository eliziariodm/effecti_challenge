import 'package:effecti_challenge/app/app_module.dart';
import 'package:effecti_challenge/app/modules/home/ui/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(i) {
    // i.add<LoadTelegramService>(LoadTelegramServiceImpl.new);
    // i.add<SaveTelegramService>(SaveTelegramServiceImpl.new);
    // i.add<SaveAlertsService>(SaveAlertsServiceImpl.new);
    // i.add(AlertsBuilder.new);
    // i.addSingleton<TelegramBloc>(
    //   TelegramBloc.new,
    //   config: BindConfig(
    //     onDispose: (bloc) => bloc.close(),
    //   ),
    // );
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
