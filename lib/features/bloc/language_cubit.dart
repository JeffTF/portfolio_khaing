import 'package:flutter_bloc/flutter_bloc.dart';

enum LanguageMode { normal, linkedin }

class LanguageCubit extends Cubit<LanguageMode> {
  LanguageCubit() : super(LanguageMode.normal);

  void toggleLanguage() {
    emit(state == LanguageMode.normal 
        ? LanguageMode.linkedin 
        : LanguageMode.normal);
  }
}
