import 'package:code_hero/app/core/di/injection_container.dart';
import 'package:code_hero/app/core/routes/routes.dart';
import 'package:code_hero/app/core/theme/theme.dart';
import 'package:code_hero/app/core/utils/global_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/bloc/home_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => sl<HomeBloc>()..add(const GetCharactersEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Code Hero Objective',
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          fontFamily: 'Roboto',
        ),
        debugShowCheckedModeBanner: false,
        routes: AppRouter.routes,
        initialRoute: INITIAL_ROUTE,
      ),
    );
  }
}
