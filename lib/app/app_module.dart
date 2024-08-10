import 'package:effecti_challenge/app/data/local_storage.dart';
import 'package:effecti_challenge/app/data/storages/shared_preferences_storage.dart';
import 'package:effecti_challenge/app/modules/home/home_module.dart';
import 'package:effecti_challenge/app/modules/login/login_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<LocalStorage>(SharedPreferencesStorage.new);
  }

  @override
  void routes(r) {
    r.module(
      '/a',
      module: LoginModule(),
      transition: TransitionType.size,
      duration: Duration.zero,
    );

    r.module(
      '/',
      module: HomeModule(),
      transition: TransitionType.size,
      duration: Duration.zero,
    );
  }
}
