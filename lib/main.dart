import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  var initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
    didReceiveLocalNotificationSubject.add(ReceivedNotification(
        id: id, title: title, body: body, payload: payload));
  });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });

  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.route_name,
      routes: {
        WelcomeScreen.route_name: (context) => WelcomeScreen(),
        LoginScreen.route_name: (context) => LoginScreen(),
        RegistrationScreen.route_name: (context) => RegistrationScreen(),
        ChatScreen.route_name: (context) => ChatScreen(),
      },
    );
  }
}

// TODO 01: Implement notifications for new messages using package flutter_local_notifications
// TODO 02: Verify how persistent is the firestore connection
// TODO 03: Change app name to Mila DogChat
// TODO 04: Change theme, icons, etc to the new concept Mila DogChat.
// TODO 05: Create a contact list to add contacts
// TODO 06: A room chat must be created by one contact to invite another 1 x 1
// TODO 07: Show only messages of the last 24 hours
// TODO 08: Implement a message searching method
