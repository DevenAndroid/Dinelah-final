import 'package:dinelah/controller/NotificationScreenController.dart';
import 'package:dinelah/models/ModelNotification.dart';
import 'package:dinelah/repositories/clear_notifications.dart';
import 'package:dinelah/res/app_assets.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/common_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  // late Future<ModelNotificationData> future;

  final controller = Get.put(NotificationScreenController());

  @override
  void initState() {
    super.initState();
    // future = getNotificationData(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xfff3f3f3),
          image: DecorationImage(
            image: AssetImage(
              AppAssets.shapeBg,
            ),
            alignment: Alignment.topRight,
            fit: BoxFit.contain,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: backAppBar('Notification'),
          body: Obx(() {
            return !controller.isDataLoad.value
                ? loader(context)
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        controller.model.value.data!.notifications.isEmpty
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.all(8),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                      onPressed: () {
                                        clearNotifications(context)
                                            .then((value) {
                                          showToast(value.message);
                                          if (value.status) {
                                            setState(() {
                                              controller.model.value.data!
                                                  .notifications
                                                  .clear();
                                            });
                                            Get.back();
                                            // Get.offNamed(
                                            //     MyRouter.dashBoardScreen);
                                          }
                                          return null;
                                        });
                                      },
                                      child: const Text(
                                        'Clear All',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),
                              ),
                        controller.model.value.data!.notifications.isEmpty
                            ? getNoDataFound(
                                screenSize, 'No notification Found')
                            : ListView.builder(
                                itemCount: controller
                                    .model.value.data!.notifications.length,
                                //scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return notificationList(
                                      controller
                                          .model.value.data!.notifications,
                                      index);
                                })
                      ],
                    ),
                  );
          }),
        ) //;
        );
  }

  Widget notificationList(List<Notifications> notifications, int index) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: (){
          if (notifications[index].screenType == 'order_detail') {
            Get.toNamed(MyRouter.orderDetail, arguments: [notifications[index].orderId]);
          }
        },
        child: Card(
          elevation: 0,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF100012 * (index + 1)),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Container(
                  width: 55,
                  height: 55,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                      child: Image.network(
                        // AppAssets.hostBanner,
                        notifications[index].icon,
                        fit: BoxFit.fill,
                      ) //Text('A', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),),
                      ),
                ),
              ),
              Expanded(
                flex: 40,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(12, 8, 8, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(notifications[index].title),
                      //textBold(snapshot.data!.data.notifications[index].title),
                      addHeight(4),
                      Text(
                        notifications[index].description,
                        //snapshot.data!.data.notifications[index].message,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            height: 1.2, color: Colors.black54, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // return loader(context);
}
//);
// }
//}
