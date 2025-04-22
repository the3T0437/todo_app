import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/local_storeage/local_task_storeage.dart';
import 'package:todoapp/data/local_storeage/task_storeage.dart';
import 'package:todoapp/data/repository/task_repository.dart';
import 'package:todoapp/presentation/bloc/task_cubit.dart';
import 'package:todoapp/presentation/bloc/task_state.dart';
import 'package:todoapp/presentation/screens/tabbarScreen.dart';
import 'package:todoapp/presentation/screens/taskScreen.dart';
import 'package:todoapp/presentation/screens/testScreen.dart';

class MyApp extends StatelessWidget {
  final TaskRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.white,
          dividerColor: Colors.transparent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.amber,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        cardTheme: const CardTheme(
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.white,
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              var state = TaskCubit(repository);
              state.getTasks();
              return state;
            },
          ),
        ],
        child: TabbarScreen(repository: repository),
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
