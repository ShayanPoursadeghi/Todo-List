import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/data/data.dart';
import 'package:todo_list/data/repo/repository.dart';
import 'package:todo_list/screens/home/bloc/task_list_bloc.dart';
import 'package:todo_list/screens/home/home.dart';
import 'data/source/hive_task_source.dart';

const taskBoxName = 'tasks';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<TaskEntity>(taskBoxName);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: onPrimaryFixedVariant));
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<Repository<TaskEntity>>(
          create: (context) => Repository<TaskEntity>(
              localDataSource: HiveTaskDataSource(Hive.box(taskBoxName)))),
      BlocProvider<TaskListBloc>(
        create: (context) =>
            TaskListBloc(context.read<Repository<TaskEntity>>()),
      ),
    ], child: const MyApp()),
  );
}

const Color primaryColor = Color(0xff794CFF);
const Color onPrimaryFixedVariant = Color(0xff5C0AFF);
const secondaryTextColor = Color(0xffAFBED0);
const lowPriority = Color(0xff3BE1F1);
const normalPriority = Color(0xffF09819);
const highPriority = primaryColor;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primaryTextColor = Color(0xff1D2830);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(
            const TextTheme(
                headlineSmall: TextStyle(fontWeight: FontWeight.bold)),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: TextStyle(color: secondaryTextColor),
            border: InputBorder.none,
            iconColor: secondaryTextColor,
          ),
          colorScheme: const ColorScheme.light(
            primary: primaryColor,
            onPrimaryFixedVariant: onPrimaryFixedVariant,
            background: Color(0xffF3F5F8),
            onSurface: primaryTextColor,
            onPrimary: Colors.white,
            onBackground: primaryTextColor,
            secondary: primaryColor,
            onSecondary: Colors.white,
          )),
      home: HomeScreen(),
    );
  }
}
