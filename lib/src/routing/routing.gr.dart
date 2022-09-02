// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../features/scheduler/domain/schedule.dart' as _i5;
import '../features/scheduler/presentation/pages/home_page.dart' as _i1;
import '../features/scheduler/presentation/pages/new_update_schedule_page.dart'
    as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    NewSchedule.name: (routeData) {
      final args = routeData.argsAs<NewScheduleArgs>(
          orElse: () => const NewScheduleArgs());
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.NewSchedule(
              key: args.key, isUpdate: args.isUpdate, schedule: args.schedule));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i3.RouteConfig(HomeRoute.name, path: '/home'),
        _i3.RouteConfig(NewSchedule.name, path: '/newSchedule')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.NewSchedule]
class NewSchedule extends _i3.PageRouteInfo<NewScheduleArgs> {
  NewSchedule({_i4.Key? key, bool isUpdate = false, _i5.Schedule? schedule})
      : super(NewSchedule.name,
            path: '/newSchedule',
            args: NewScheduleArgs(
                key: key, isUpdate: isUpdate, schedule: schedule));

  static const String name = 'NewSchedule';
}

class NewScheduleArgs {
  const NewScheduleArgs({this.key, this.isUpdate = false, this.schedule});

  final _i4.Key? key;

  final bool isUpdate;

  final _i5.Schedule? schedule;

  @override
  String toString() {
    return 'NewScheduleArgs{key: $key, isUpdate: $isUpdate, schedule: $schedule}';
  }
}
