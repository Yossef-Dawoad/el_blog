import 'package:clean_blog/core/utils/bloc_obserevers/simple_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blog_app.dart';
import 'core/di/dependancy_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependancies();
  Bloc.observer = SimpleBlocObserver();
  runApp(const BlogApp());
}
