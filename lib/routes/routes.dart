import 'package:demo_2/modules/data/repository/counter_repo.dart';
import 'package:demo_2/modules/func/bloc/counter/counter_bloc.dart';
import 'package:demo_2/modules/func/bloc/success/success_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../modules/presentation/pages/layout.dart';

class DynamicRoutes {
  final String name;
  final String path;

  static final startPage = DynamicRoutes(
    name: 'Start',
    path: '/',
  );

  static final home = DynamicRoutes(
    name: 'Home',
    path: '/home',
  );

  DynamicRoutes({
    required this.name,
    required this.path,
  });
  static final router = GoRouter(
    restorationScopeId: "Demo2",
    routes: <RouteBase>[
      _start(),
      _home(),
    ],
  );

  static GoRoute _start() {
    return GoRoute(
      name: startPage.name,
      path: startPage.path,
      redirect: (context, state) {
        return DynamicRoutes.home.path;
      },
    );
  }

  static GoRoute _home() {
    return GoRoute(
      name: home.name,
      path: home.path,
      builder: (context, state) {
        return RepositoryProvider(
          create: (context) => CounterRepository(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CounterBloc(
                  repository: RepositoryProvider.of<CounterRepository>(context),
                ),
              ),
              BlocProvider(
                create: (context) => SuccessBloc(
                  repository: RepositoryProvider.of<CounterRepository>(context),
                ),
              ),
            ],
            child: const Layout(
              title: 'Demo 2',
            ),
          ),
        );
      },
    );
  }
}
