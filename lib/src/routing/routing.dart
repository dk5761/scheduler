import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:scheduler/src/features/scheduler/presentation/pages/home_page.dart';
import 'package:scheduler/src/features/scheduler/presentation/pages/new_update_schedule_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
        path: '/home', page: HomePage, maintainState: true, initial: true),
    AutoRoute(path: '/newSchedule', page: NewSchedule),
  ],
)
class $AppRouter {}
