import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/API/dio_helper.dart';
import 'package:taxi_app/cubit/cubit.dart';
import 'package:taxi_app/modules/login_screen/login_screen.dart';
import 'package:taxi_app/modules/main_page.dart';
import 'package:taxi_app/modules/registertion_screen/registertion_sreen.dart';
import 'package:taxi_app/shared/cubit/cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDN8x9o0MxTuBA4GwryiGMGHuW9ezBnN_4',
      appId: '1:1048593121801:android:830eb09fb01eba05812ed8',
      messagingSenderId: '1048593121801',
      projectId: 'taxi-app-e9c27',
      databaseURL: 'https://taxi-app-e9c27-default-rtdb.firebaseio.com',
      storageBucket: 'taxi-app-e9c27.appspot.com',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => TaxiCubit())],
      child: MaterialApp(
        title: 'Taxo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Brand-Reqular',
          primarySwatch: Colors.blue,
        ),
        initialRoute: MainPage.id,
        routes: {
          RegitertionScreen.id: (context) => RegitertionScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          MainPage.id: (context) => MainPage()
        },
        home: RegitertionScreen(),
      ),
    );
  }
}
