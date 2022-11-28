import 'dart:convert';
import 'dart:developer';

import 'package:client_information/client_information.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ModelSingleOrder.dart';
// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCAjlemWzDiNsXUIwFV9TCqSV4ORBMpt-s',
      // apiKey: 'AIzaSyDe8CX9WYGxR_IK4J2zn0QiainTgAGAy0c',
      // appId: '1:580087456375:android:1e0eae7ae2ad95e6de9c72',
      appId: '1:962094105233:android:f3b11ccd1743d76fe93530',
      messagingSenderId: '962094105233',
      projectId: 'dinelah-fae97',
    ),
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  print('Handling a background message ${message.data}');

  // runApp(MessagingExampleApp());
}


// Crude counter to make messages unique
int _messageCount = 0;
RxBool screenType = false.obs;
RxString screenName = ''.obs;
String? receiverType;
String? orderId;
String? orderStatus;

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String? token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}
//
// /// Renders the example application.
// class Application extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _Application();
// }

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
  // print('REMOTE MESSAGE :: ${message.toString()}');
  print('REMOTE MESSAGE :: ${message.data.toString()}');
  // print('REMOTE MESSAGE :: ${json.decode(message.data['payload'])['receiver_details']['id'].toString()}');
  screenType.value = true;

  // orderStatus = json.decode(message.data['payload'])['order_status'].toString();
  orderId = json.decode(message.data['payload'])['order_id'].toString();
  // print('RECEIVER DETAILS :: '+jsonEncode(receiverDetails));

  screenName.value = json.decode(message.data['payload'])['screen_type'].toString();
  print('RECEIVER TYPE :: '+receiverType.toString());
  // print('RECEIVER ORDER ID :: '+orderId.toString());
  //
  if (json.decode(message.data['payload'])['screen_type'].toString() ==
      'chat') {
    try {
      DeliveryDetail receiverDetails = DeliveryDetail(
        id: json.decode(message.data['payload'])['receiver_details']['id'].toString(),
        name: json.decode(message.data['payload'])['receiver_details']['name'].toString(),
        phone: json.decode(message.data['payload'])['receiver_details']['phone'].toString(),
        address: json.decode(message.data['payload'])['receiver_details']['address'].toString(),
        image: '',
      );
      receiverType = json.decode(message.data['payload'])['receiver_type'].toString();

      Get.offAllNamed(MyRouter.customBottomBar);
      Get.toNamed(MyRouter.orderDetail,
          arguments: [orderId]);
      Get.toNamed(MyRouter.chatScreen,
          arguments: [orderId, receiverDetails, receiverType, orderId]);
    } catch(e){}


    // Navigator.pushNamed(context, '/chat',
    //   arguments: ChatterScreen(),
    // );
  } else if (json.decode(message.data['payload'])['screen_type'].toString() ==
      'order_detail') {
    Get.offAllNamed(MyRouter.customBottomBar);
    Get.toNamed(MyRouter.orderDetail,
        arguments: [orderId, orderStatus]);

    // print('ORDER DETAILS OF BACKGROUND :: '+jsonEncode(receiverDetails));
    // print('ORDER DETAILS OF BACKGROUND 11:: '+receiverType.toString());
    // print('ORDER DETAILS OF BACKGROUND 11:: '+orderId.toString());

  } else if (json.decode(message.data['payload'])['screen_type'].toString() ==
      'dashboard') {
    Get.toNamed(MyRouter.customBottomBar);
  } else {
    Get.offAllNamed(MyRouter.customBottomBar);
    Get.toNamed(MyRouter.notificationScreen);
  }
}

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    noti();
    setIsChat(false);
    setupInteractedMessage();
    _getClientInformation();
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      if (!screenType.value) {
        if (screenName.value != 'chat') {
          // Get.toNamed(MyRouter.dashboardScreen);
          Get.offAndToNamed(MyRouter.customBottomBar);
        }
      }
        // Get.offAndToNamed(MyRouter.customBottomBar);
      // Get.to(AllHostsScreen());
      // Get.offAndToNamed(MyRouter.logInScreen);
    });
  }

  Future<void> setIsChat(isChat) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('chat', isChat);
  }

  Future<void> noti() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCAjlemWzDiNsXUIwFV9TCqSV4ORBMpt-s',
        // apiKey: 'AIzaSyDe8CX9WYGxR_IK4J2zn0QiainTgAGAy0c',
        // appId: '1:580087456375:android:1e0eae7ae2ad95e6de9c72',
        appId: '1:962094105233:android:f3b11ccd1743d76fe93530',
        messagingSenderId: '962094105233',
        projectId: 'dinelah-fae97',
      ),
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

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print('FOREGROUND DAYA :: ' + message.toString());

      return;
    });

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');
    //
    //   if (message.notification != null) {
    //     // showOverlayNotification((context) {
    //     //   return Card(
    //     //     shape: RoundedRectangleBorder(
    //     //       borderRadius: BorderRadius.circular(10.0),
    //     //     ),
    //     //     margin: const EdgeInsets.symmetric(horizontal: 4),
    //     //     child: SafeArea(
    //     //       child: ListTile(
    //     //         leading: SizedBox.fromSize(
    //     //             size: const Size(40, 40),
    //     //             child: ClipOval(child: Image.asset(AppAssets.logInLogo))),
    //     //         title: Text(message.notification!.title.toString()),
    //     //         subtitle: Text(message.notification!.body.toString()),
    //     //         trailing: IconButton(
    //     //             icon: Icon(Icons.close),
    //     //             onPressed: () {
    //     //               OverlaySupportEntry.of(context)!.dismiss();
    //     //             }),
    //     //       ),
    //     //     ),
    //     //   );
    //     // }, duration: Duration(milliseconds: 4000));
    //
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });

    print('User granted permission: ${settings.authorizationStatus}');

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
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
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  Future<void> _getClientInformation() async {
    ClientInformation? info;
    try {
      info = await ClientInformation.fetch();
    } on PlatformException {
      log('Failed to get client information');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceId', info!.deviceId.toString());
  }
}
