import 'package:get_it/get_it.dart';

import '../features/bloc/language_cubit.dart';

var getIt = GetIt.instance;

void locator() {
  getIt.registerLazySingleton(() => LanguageCubit());
}
