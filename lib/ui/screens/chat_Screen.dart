import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinelah/models/ModelSingleOrder.dart';
import 'package:dinelah/repositories/push_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ModelLogIn.dart';
import '../../res/theme/theme.dart';
import '../widget/common_widget.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

String? messageText;

class ChatterScreen extends StatefulWidget {
  const ChatterScreen({Key? key}) : super(key: key);

  @override
  ChatterScreenState createState() => ChatterScreenState();
}

class ChatterScreenState extends State<ChatterScreen> {
  final chatMsgTextController = TextEditingController();

  // final _auth = FirebaseAuth.instance;
  Rx<ModelLogInData> user = ModelLogInData().obs;
  late DeliveryDetail receiverDetails;
  var chatNode;

  @override
  void deactivate() {
    super.deactivate();
    setIsChat(false);
  }

  @override
  initState() {
    super.initState();
    // getCurrentUser();
    // getMessages();
    setIsChat(true);
    receiverDetails = Get.arguments[1];
    getUser();
  }

  Future<void> setIsChat(isChat) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('chat', isChat);
  }

  Future<void> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    user.value = ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
    // setState(() async {
    if (user.value.user!.id < int.parse(receiverDetails.id)) {
      chatNode =
          user.value.user!.id.toString() + '-' + receiverDetails.id.toString();
    } else {
      chatNode =
          receiverDetails.id.toString() + '-' + user.value.user!.id.toString();
    }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      appBar: backAppBarChat('${'${receiverDetails.name}( #'+Get.arguments[3].toString()})'),
      body: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // user == null && chatNode == '' ?
            // SizedBox.shrink() :
            user == null && chatNode == ''
                ? const SizedBox.shrink()
                : ChatStream(user.value, chatNode),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              // decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Material(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 4,
                          decoration: const InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              enabled: true),
                          onChanged: (value) {
                            messageText = value;
                          },
                          onFieldSubmitted: (value){

                          },
                          controller: chatMsgTextController,
                          //decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                      shape: const CircleBorder(),
                      color: AppTheme.primaryColor,
                      onPressed: () {
                        sendMessage();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      )
                      // Text(
                      //   'Send',
                      //   style: kSendButtonTextStyle,
                      // ),
                      ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  void sendMessage() {
    if (chatMsgTextController.text.isNotEmpty) {
      firestore
          .collection('messages')
          .doc(Get.arguments[3].toString())
          .collection(chatNode)
          .add({
        'isRead': false,
        'receiverId': receiverDetails.id,
        'receiverName': receiverDetails.name,
        'receiverPhoto': '',
        'senderId': user.value.user!.id.toString(),
        'senderName':
            user.value.user!.displayname.toString(),
        'senderPhoto': "",
        'message': messageText,
        'senderUserRole': "Customer",
        'receiverUserRole': Get.arguments[2].toString(),
        'user': true,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    }
    pushNotification(receiverDetails.id, user.value.user!.displayname.toString(), messageText,
        // (receiverDetails),
        DeliveryDetail(id: user.value.user!.id.toString(),
            name: user.value.user!.displayname,
            image: user.value.user!.avatar,
            phone: '', address: ''),
        'customer', Get.arguments[3]);
    chatMsgTextController.clear();
  }
}

class ChatStream extends StatelessWidget {
  ModelLogInData? user;
  String chatNode;

  ChatStream(this.user, this.chatNode);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore
          .collection('messages')
          .doc(Get.arguments[3].toString())
          .collection(chatNode)
          .orderBy('timestamp')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs.reversed;
          // showToast(snapshot.data!.docs.toString());
          List<MessageBubble> messageWidgets = [];
          for (var messageInstance in messages) {
            final item = messageInstance;
            final msgText = item['message'].toString(); //.data['text'];
            final receiverId = item['receiverId'].toString(); //.data['text'];
            final receiverName =
                item['receiverName'].toString(); //.data['text'];
            final receiverPhoto =
                item['receiverPhoto'].toString(); //.data['text'];
            final senderId = item['senderId'].toString(); //.data['text'];
            final senderName = item['senderName'].toString(); //.data['text'];
            final senderPhoto = item['senderPhoto'].toString(); //.data['text'];
            final message = item['message'].toString(); //.data['text'];
            final senderUserRole =
                item['senderUserRole'].toString(); //.data['text'];
            final receiverUserRole =
                item['receiverUserRole'].toString(); //.data['text'];
            final user = item['user'].toString(); //.data['text'];
            final timestamp = item['timestamp']
                .toString(); //message.data().toString();//.data['sender'];
            // final msgSenderEmail = message.data['senderemail'];
            // final currentUser = loggedInUser!.displayName;

            // print('MSG'+msgSender + '  CURR'+currentUser);
            final msgBubble = MessageBubble(
                false,
                receiverId,
                receiverName,
                receiverPhoto,
                senderId,
                senderName,
                senderPhoto,
                message,
                senderUserRole,
                receiverUserRole,
                false,
                timestamp);
            messageWidgets.add(msgBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              children: messageWidgets,
            ),
          );
        } else {
          return SizedBox(
            height: 500,
            child: const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepOrange,
                color: AppTheme.primaryColor,
              ),
            ),
          );
        }
      },
    );
  }
}

class MessageBubble extends StatefulWidget {
  var isRead;
  var receiverId;
  var receiverName;
  var receiverPhoto;
  var senderId;
  var senderName;
  var senderPhoto;
  var message;
  var senderUserRole;
  var receiverUserRole;
  var user;
  var timestamp;

  MessageBubble(
    this.isRead,
    this.receiverId,
    this.receiverName,
    this.receiverPhoto,
    this.senderId,
    this.senderName,
    this.senderPhoto,
    this.message,
    this.senderUserRole,
    this.receiverUserRole,
    this.user,
    this.timestamp,
  );

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  Rx<ModelLogInData> user = ModelLogInData().obs;
  RxString id = ''.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    user.value = ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
      id.value = user.value.user!.id.toString();
    // setState(() async {
    //   user = await getCookie();
    // });
  }

  @override
  Widget build(BuildContext context) {
    if (id.value != null && id.value == widget.receiverId ||
        id.value == widget.receiverId) {
      widget.user = false;
    } else {
      widget.user = true;
    }
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment:
            widget.user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          /* Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              message,
              style: TextStyle(
                  fontSize: 13, fontFamily: 'Poppins', color: Colors.black87),
            ),
          ),*/
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(50),
              topLeft: widget.user
                  ? const Radius.circular(50)
                  : const Radius.circular(0),
              bottomRight: const Radius.circular(50),
              topRight: widget.user
                  ? const Radius.circular(0)
                  : const Radius.circular(50),
            ),
            color: widget.user ? AppTheme.primaryColor
                : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                // widget.receiverId,
                widget.message,
                style: TextStyle(
                  color: widget.user ? Colors.white : AppTheme.primaryColor,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
