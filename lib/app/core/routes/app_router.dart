import 'package:code_hero/app/core/routes/constants_routes.dart';
import 'package:code_hero/app/presentation/presentation.dart';

class AppRouter {
  static final routes = {
    INITIAL_ROUTE: (context) => const InitialPage(),
    HOME_ROUTE: (context) => HomePage(),
    DETAILS_ROUTE: (context) => const DetailsPage(),
  };
}
