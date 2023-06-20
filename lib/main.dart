import 'package:flutter/material.dart';
import 'package:handyman/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:handyman/providers/themeNotifier.dart';
import 'package:handyman/screens/calendar/calendar_screen/add_event_screen.dart';
import 'package:handyman/screens/calendar/calendar_screen/calendar_screen.dart';
import 'package:handyman/screens/splash_screen/splash_screen_page.dart';
import 'package:handyman/styles/styles.dart';
import 'package:handyman/widgets/main_bottom_bar/main_bottom_bar_page.dart';
import 'package:provider/provider.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<NightMode>.value(value: NightMode()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (BuildContext context) => CalendarBloc2(),
            ),
            BlocProvider(create: (BuildContext context) => CalendarBloc()),
          ],
          child: Consumer<NightMode>(
            builder: (context, nightMode, child) => FutureBuilder<ThemeData>(
                future: nightMode.getTheme(),
                initialData: Styles.themeData(false),
                builder:
                    (BuildContext context, AsyncSnapshot<ThemeData> themeData) {
                  return MaterialApp(
                    title: 'Handyman',
                    theme: themeData.data,
                    initialRoute: '/loading',
                    routes: {
                      '/main': (context) => MainBottomBar(),
                      '/loading': (context) => const SplashScreenPage("/main"),
                      '/calendar': (context) => CalendarApp(),
                    },
                    debugShowCheckedModeBanner: false,
                  );
                }),
          ));
  //);
}
