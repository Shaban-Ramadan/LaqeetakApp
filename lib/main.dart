import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laqeetak/coure/services/local/shared_helper(1).dart';
import 'package:laqeetak/feature/view_model/loser_cubit/loser_cubit.dart';
import 'package:laqeetak/feature/view_model/user_cubit/user_cubit.dart';
import 'feature/view_model/notivication_cubit/notivication_cubit.dart';
import 'firebase_options.dart';
import 'my aap.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // تهيئة SharedPreferences أو helper
  await SharedHelper.init();

  runApp(
      MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit(),),
        BlocProvider(create: (context) => LoserCubit(),),
        BlocProvider(create: (context) => NotificationCubit(),),
      ],
      child: MyApp()));
}


