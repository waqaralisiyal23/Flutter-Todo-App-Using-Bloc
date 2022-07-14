import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoappusingbloc/screens/tabs_screen.dart';
import 'package:todoappusingbloc/blocs/bloc_exports.dart';
import 'package:todoappusingbloc/services/app_router.dart';
import 'package:todoappusingbloc/services/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(appRouter: AppRouter())),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SwitchBloc()),
        BlocProvider(create: (_) => TasksBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, switchState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter ToDo App using Bloc',
            theme: switchState.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const TabsScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
