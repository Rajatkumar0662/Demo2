import 'package:demo_2/modules/tapper/tapper.dart' as tapper;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
          create: (context) => tapper.CounterRepository(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => tapper.CounterBloc(
                  repository:
                      RepositoryProvider.of<tapper.CounterRepository>(context),
                ),
              ),
              BlocProvider(
                create: (context) => tapper.SuccessBloc(
                  repository:
                      RepositoryProvider.of<tapper.CounterRepository>(context),
                ),
              ),
            ],
            child: const tapper.Layout(
              title: 'Demo 2',
            ),
          ),
        );
      },
    );
  }
}
