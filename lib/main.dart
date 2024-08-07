//import 'models/blog.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'blocs/blog_list_bloc.dart';
import 'repositories/blog_repository.dart';
import 'screens/blog_list_screen.dart';
import 'models/blog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  
  Hive.registerAdapter(BlogAdapter());
  await Hive.openBox<Blog>('blogs');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => BlogListBloc(BlogRepository()),
        child: BlogListScreen(),
      ),
    );
  }
}