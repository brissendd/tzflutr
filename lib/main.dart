import 'package:dio/dio.dart';
import 'package:emobile_tz/pages/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'api_data/api.dart';
import 'app_routes.dart';
import 'bloc/bloc_emitter.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: BlocProvider(
        create: (context) {
          final dio = Dio();
          final api = BookingApi(dio);
          return BookingBloc(api);
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            useMaterial3: true,
            fontFamily: 'SF Pro Display'
          ),
          initialRoute: '/',
          routes: routes,
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => const NotFoundScreen(),
            );
          },
        ),
      ),
    );
  }
}
