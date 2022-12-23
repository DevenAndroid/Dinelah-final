import 'package:dinelah/controller/MySingleOrdersController.dart';
import 'package:dinelah/models/ModelSingleOrder.dart';
import 'package:dinelah/ui/screens/Delivery_Details/store_info_tab_screen.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/app_assets.dart';
import '../../../res/theme/theme.dart';
import 'delivery_details_tab_screen.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  OrderDetailState createState() => OrderDetailState();
}

class OrderDetailState extends State<OrderDetail>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // var id;

  final controller = Get.put(MySingleOrdersController());
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    // id = Get.arguments;
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
                : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          _getTitleAndIconRow(
                              "OrderId: #${controller.model.value.data!.orderData.id}",
                              controller.model.value.data!
                                  .orderData.dateCreated
                                  .toString(),
                              Icons.calendar_today,
                              controller.model.value.data!
                                  .orderData.status
                                  .toString()
                          ),
                          addHeight(24),
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
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: TabBar(
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.white,
                      tabs: const [
                        Tab(
                          child: Text(
                            'Delivery Detail',
                            style:
                            TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Store Information',
                            style:
                            TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                      labelStyle: const TextStyle(
                          fontSize: 18.0, color: Colors.white),
                      unselectedLabelStyle: const TextStyle(
                          fontSize: 18.0, color: Colors.black),
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  addHeight(4),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        controller.model.value.data!.deliveryDetail ==
                            null
                            ? const SizedBox(
                          width: 10,
                          child: Card(
                            child: Center(
                                child: Text(
                                    'Oops! Driver not Assigned for you order.')),
                          ),
                        )
                            : DeliveryDetails(controller.model.value.data),
                        StoreInformation(controller.model.value.data)
                      ],
                    ),
                  ),
                ],
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
  Widget _getItemAndStatusRowList(index, OrderData orderData, ) {
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

  Widget _getItemAndStatusRow(
      String item, String payMode, String productTotal) {
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
}
