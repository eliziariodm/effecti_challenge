import 'package:effecti_challenge/app/modules/home/interactor/states/home_state.dart';

abstract interface class ReadTasks {
  Future<HomeState> call();
}
