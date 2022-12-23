import 'package:dinelah/controller/MySubOrdersController.dart';
import 'package:dinelah/models/ModelSingleOrder.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/app_assets.dart';
import '../../../res/theme/theme.dart';

class SubOrderDetail extends StatefulWidget {
  const SubOrderDetail({Key? key}) : super(key: key);

  @override
  SubOrderDetailState createState() => SubOrderDetailState();
}

class SubOrderDetailState extends State<SubOrderDetail>
    with SingleTickerProviderStateMixin {
  // late TabController tabController;
  var id;
  final controller = Get.put(MySubOrdersController());

  // @override
  // void dispose() {
  //   super.dispose();
  //   controller.onClose();
  // }

  @override
  void initState() {
    // tabController = TabController(length: 2, vsync: this);
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
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
          //appBar: backAppBar('My Orders'),
          appBar: backAppBar('Order details'),
          backgroundColor: Colors.transparent,
          body: Obx(() {
            return !controller.isDataLoading.value
                ? loader(context)
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _getTitleAndIconRow(
                                            "OrderId: #${controller.model.value.data!.orderData.id}",
                                            controller.model.value.data!
                                                .orderData.dateCreated
                                                .toString(),
                                            Icons.calendar_today,
                                            controller.model.value.data!
                                                .orderData.status
                                                .toString()),
                                      ),
                                    ],
                                  ),
                                  addHeight(24),
                                  // controller.model.value.data!.suborderData.length!= 0? SizedBox.shrink():
                                  ListView.builder(
                                    shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.model.value.data!.orderData.lineItems.length,
                                  itemBuilder: (context, index){
                                    return _getItemAndStatusRowList(index,controller.model.value.data!.orderData);}),
                                ],
                              ),
                            ),
                          ),
                          addHeight(16),
                          ListView.builder(
                              // controller: scrollController,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.model.value.data!.suborderData.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return orderCard(controller.model.value.data!.suborderData[index]);
                              })
                        ],
                      ),
                    ),
                  );
          })),
    );
  }

  Widget _getTitleAndIconRow(
      String title, String subTitle, IconData iconData, String status) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          iconData,
          size: 20,
          color: AppTheme.primaryColor,
        ),
        addWidth(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 6.0),
                    child: Text(
                      status.capitalizeFirst??'',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              addHeight(4.0),
              Text(
                subTitle,
                textScaleFactor: 1.0,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _getItemAndStatusRow(String item, String payMode, String productTotal) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item,
                    style: const TextStyle(
                      color: Color(0xff303c5e),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    productTotal,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              addHeight(4.0),
              Text(
                payMode,
                textScaleFactor: 1.0,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
  Widget _getItemAndStatusRowList(index, OrderData orderData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${orderData.lineItems[index].quantity}x ${orderData.lineItems[index].name}",
                      style: const TextStyle(
                        color: Color(0xff303c5e),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    orderData.lineItems[index].total,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              addHeight(4.0),
              Text(
                orderData.paymentMethodTitle.toString(),
                textScaleFactor: 1.0,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget orderCard(SuborderData order) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(MyRouter.orderDetail, arguments: [order.orderId]);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 6, left: 10, right: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(50),
                  elevation: 3,
                  child: SizedBox(
                    height: 85,
                    width: 85,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Image.network(
                        order.products[0].productImage,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              child: CircularProgressIndicator(
                                color: AppTheme.primaryColor,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                addWidth(12),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addHeight(8),
                    Text(
                      'OrderID #${order.orderId}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                    addHeight(4),
                    Text(
                      'Total Products: ${order.products.length.toString()}',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                    addHeight(4),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
/*
  Widget _getPaymentDetails(String payTitle, String paySubTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$payTitle',style: TextStyle(
            fontSize: 14.0,fontWeight: FontWeight.w500
        ),),
        Text('$paySubTitle',style: TextStyle(
            fontSize: 14.0,fontWeight: FontWeight.w500
        ),)
      ],
    );
  }*/
}
