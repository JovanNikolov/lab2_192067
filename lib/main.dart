import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lab2_192067/screens/favorite.dart';
import 'package:lab2_192067/screens/home.dart';
import 'package:lab2_192067/screens/jokes.dart';
import 'package:lab2_192067/screens/random.dart';
import 'package:lab2_192067/services/notification_services.dart';
import 'package:lab2_192067/utils/firebase_initialize.dart';
import 'package:lab2_192067/utils/global_notifier.dart';
import 'package:lab2_192067/utils/local_notifications_initialize.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async{
  initializeFirebase();
  initializeLocalNotifications();
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();
  tz.initializeTimeZones();
  DateTime dateTime = DateTime.now();
  DateTime scheduleDate = dateTime.copyWith(hour: 17, minute: 18);
  NotificationService.scheduleNotification("Your joke of the day sir", "Hope it will make your day", scheduleDate);

  runApp(
      ChangeNotifierProvider(
          create: (_) => GlobalNotifier(),
          child: const MyApp(),
      ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vicoteka',
      initialRoute: '/',
      routes: {
        '/' : (context) => const Home(),
        '/jokes': (context) => Jokes(),
        '/random': (context) => const RandomJoke(),
        "/favorite": (context) => const Favorites(),
      },
    );
  }
}
