import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/local_store/local_task_store.dart';
import 'package:todoapp/data/local_store/task_store.dart';
import 'package:todoapp/data/repository/task_repository.dart';
import 'package:todoapp/presentation/screen_tabbar/view_model/task_cubit.dart';
import 'package:todoapp/presentation/screen_tabbar/view_model/task_state.dart';
import 'package:todoapp/presentation/screen_tabbar/screen_tabbar.dart';
import 'package:todoapp/presentation/screen_tabbar/widgets/list_tasks.dart';

class MyApp extends StatelessWidget {
  final TaskRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 255, 193, 108),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.white,
          dividerColor: Colors.transparent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Color.fromARGB(255, 255, 193, 108),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 193, 108),
          ),
        ),
        cardTheme: const CardTheme(
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 255, 193, 108),
          foregroundColor: Colors.white,
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              var cubit = TaskCubit(repository);
              cubit.getTasks();
              return cubit;
            },
          ),
        ],
        child: ScreenTabbar(repository: repository),
        //child: const TestScreen(),
      ),
      /*
      BlocProvider(
        create: (context) {
          var state = TaskCubit(repository);
          state.getTasks();
          return state;
        },
        child: TabbarScreen(repository: repository),
      ),
      */
    );
  }
}
