import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/repository/home_repository.dart';
import 'package:todo/presentation/bloc/delete_bloc/delete_bloc.dart';
import 'package:todo/presentation/bloc/edit_bloc/edit_bloc.dart';
import 'package:todo/presentation/bloc/fetch_bloc/todo_bloc.dart';
import 'package:todo/presentation/bloc/post_bloc/post_bloc_bloc.dart';
import 'package:todo/presentation/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
            BlocProvider(
          create: (context) => TodoBloc(HomeRepository()),
    
        ),
            BlocProvider(
                create: (context) => PostBlocBloc(HomeRepository()),
            ),
            BlocProvider(
                create: (context) => DeleteBloc(HomeRepository()),
            ),
            BlocProvider(
                create: (context) => EditBloc(HomeRepository()),
            ),
        ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'toDo',
                theme: ThemeData(
                  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  brightness: Brightness.dark,
                  useMaterial3: true,
                ),
                home:  HomePage(),
              ),
    );
  }
}
