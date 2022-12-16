import 'dart:convert';
import 'dart:io';

import 'package:dinelah/models/ModelSingleOrder.dart';
import 'package:dinelah/res/app_assets.dart';
import 'package:dinelah/res/size_config.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';


// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: const FirebaseOptions(
    //   apiKey: 'AIzaSyCAjlemWzDiNsXUIwFV9TCqSV4ORBMpt-s',
    //   // apiKey: 'AIzaSyDe8CX9WYGxR_IK4J2zn0QiainTgAGAy0c',
    //   // appId: '1:580087456375:android:1e0eae7ae2ad95e6de9c72',
    //   appId: '1:962094105233:android:f3b11ccd1743d76fe93530',
    //   messagingSenderId: '962094105233',
    //   projectId: 'dinelah-fae97',
    // ),
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// It is assumed that all messages contain a data field with the key 'type'
Future<void> setupInteractedMessage() async {
  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen
  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

void _handleMessage(RemoteMessage message) {
  print('REMOTE MESSAGE :: ' + message.data.toString());
  // Get.toNamed(MyRouter.aboutUs);
  if (message.data['type'] == 'chat') {
    // Navigator.pushNamed(context, '/chat',
    //   arguments: ChatterScreen(),
    // );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    /*options: Platform.isIOS || Platform.isMacOS
        ? const FirebaseOptions(
      apiKey: 'AIzaSyCAjlemWzDiNsXUIwFV9TCqSV4ORBMpt-s',
      // apiKey: 'AIzaSyDe8CX9WYGxR_IK4J2zn0QiainTgAGAy0c',
      // appId: '1:580087456375:android:1e0eae7ae2ad95e6de9c72',
      appId: '1:962094105233:ios:0614aa07a5ab95e0e93530',
      messagingSenderId: '962094105233',
      projectId: 'dinelah-fae97',
    ) :const FirebaseOptions(
      apiKey: 'AIzaSyCAjlemWzDiNsXUIwFV9TCqSV4ORBMpt-s',
      // apiKey: 'AIzaSyDe8CX9WYGxR_IK4J2zn0QiainTgAGAy0c',
      // appId: '1:580087456375:android:1e0eae7ae2ad95e6de9c72',
      appId: '1:962094105233:android:42417678d9287af8e93530',
      messagingSenderId: '962094105233',
      projectId: 'dinelah-fae97',
    ),*/
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    print('FOREGROUND DAYA :: ' + message.toString());

    return;
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    SharedPreferences pref = await SharedPreferences.getInstance();
    var isChat = pref.getBool('chat')??false;
    if (message.notification != null && !isChat) {
      showOverlayNotification((context) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: SafeArea(
            child: ListTile(
              onTap: (){
                int _messageCount = 0;
                RxBool screenType = false.obs;
                RxString screenName = ''.obs;
                DeliveryDetail receiverDetails;
                String? receiverType;
                String? orderId;
                String? orderStatus;
                // print('REMOTE MESSAGE :: ${message.data.toString()}');
                // print('REMOTE MESSAGE :: ${json.decode(message.data['payload'])['receiver_details']['id'].toString()}');
                screenType.value = true;
                receiverDetails = DeliveryDetail(
                  id: json.decode(message.data['payload'])['receiver_details']['id'].toString(),
                  name: json.decode(message.data['payload'])['receiver_details']['name'].toString(),
                  phone: json.decode(message.data['payload'])['receiver_details']['phone'].toString(),
                  address: json.decode(message.data['payload'])['receiver_details']['address'].toString(),
                  image: '',
                );
                receiverType = json.decode(message.data['payload'])['receiver_type'].toString();
                orderId = json.decode(message.data['payload'])['order_id'].toString();
                orderStatus = json.decode(message.data['payload'])['order_status'].toString();
                screenName.value =
                    json.decode(message.data['payload'])['screen_type'].toString();

                // print('RECEIVER DETAILS :: '+jsonEncode(receiverDetails));
                // print('RECEIVER TYPE :: '+receiverType.toString());
                // print('RECEIVER ORDER ID :: '+orderId.toString());

                if (json.decode(message.data['payload'])['screen_type'].toString() ==
                    'chat') {
                  Get.toNamed(MyRouter.chatScreen,
                      arguments: ['', receiverDetails, receiverType, orderId]);
                  // Navigator.pushNamed(context, '/chat',
                  //   arguments: ChatterScreen(),
                  // );
                } else if (json.decode(message.data['payload'])['screen_type'].toString() ==
                    'order_detail') {
                  Get.toNamed(MyRouter.orderDetail,
                      arguments: [orderId, orderStatus]);
                } else {
                  Get.toNamed(MyRouter.notificationScreen);
                }
              },
              leading: SizedBox.fromSize(
                  size: const Size(40, 40),
                  child: ClipOval(child: Image.asset(AppAssets.logInLogo))),
              title: Text(message.notification!.title.toString()),
              subtitle: Text(message.notification!.body.toString()),
              trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    OverlaySupportEntry.of(context)!.dismiss();
                  }),
            ),
          ),
        );
      }, duration: Duration(milliseconds: 4000));

      print('Message also contained a notification: ${message.notification}');
    }
  });

  print('User granted permission: ${settings.authorizationStatus}');

  if (!kIsWeb) {channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      // 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  // setupInteractedMessage();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Get.changeTheme(ThemeData.dark());
    return OverlaySupport.global(
      child: LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return GetMaterialApp(
            darkTheme: ThemeData.light(),
            defaultTransition: Transition.rightToLeft,
            debugShowCheckedModeBanner: false,
            initialRoute: "/splash",
            getPages: MyRouter.route,
            theme: ThemeData(
                fontFamily: 'OpenSans',
                primaryColor: AppTheme.primaryColor,
                highlightColor: AppTheme.primaryColor,
                primarySwatch: AppTheme.primaryColorMaterial,
                cupertinoOverrideTheme: const CupertinoThemeData(
                  primaryColor: AppTheme.primaryColor,
                ),
                // for others(Android, Fuchsia)
                textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: AppTheme.primaryColor,
                    selectionColor: AppTheme.primaryColor),
                scrollbarTheme: const ScrollbarThemeData().copyWith(
                  thumbColor: MaterialStateProperty.all(AppTheme.primaryColor),
                ),
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: AppTheme.primaryColor)
                    .copyWith(secondary: AppTheme.primaryColor)
            ),
          );
        });
      }),
    );
  }
}

