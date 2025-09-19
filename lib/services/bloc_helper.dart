import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_khaing/services/locator.dart';

import '../features/bloc/language_cubit.dart';

class BlocHelper extends StatelessWidget {
  final Widget child;
  const BlocHelper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LanguageCubit>(create: (context) => getIt.call()),
    ], child: child);
  }
}
