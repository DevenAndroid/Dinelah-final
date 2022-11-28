import 'package:dinelah/models/ModelSingleOrder.dart';
import 'package:dinelah/repositories/get_single_order_repository.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../res/app_assets.dart';
import '../../../res/theme/theme.dart';

class BookingOrderDetail extends StatefulWidget {
  const BookingOrderDetail({Key? key}) : super(key: key);

  @override
  BookingOrderDetailState createState() => BookingOrderDetailState();
}

class BookingOrderDetailState extends State<BookingOrderDetail>
    with SingleTickerProviderStateMixin {
  late Future<ModelSingleOrderData> futureAlbum;
  late TabController tabController;
  var id;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    id = Get.arguments;
    futureAlbum = getSingleOrderData(id[0]);
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
        appBar: backAppBar('Booking details'),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<ModelSingleOrderData>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Data storeInfo = snapshot.data!.data!;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
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
                                        "OrderId: #" +
                                            snapshot.data!.data!.orderData.id
                                                .toString(),
                                        snapshot
                                            .data!.data!.orderData.dateCreated
                                            .toString(),
                                        Icons.calendar_today,
                                        snapshot.data!.data!.orderData.status
                                            .toString()
//DateFormat("MMM, dd-yyyy").format(order.dateCreated.date),
                                        ),
                                  ),
                                ],
                              ),
                              addHeight(24),
                              Row(
                                children: [
                                  Expanded(
                                    child: _getItemAndStatusRow(
                                      snapshot.data!.data!.orderData.lineItems[0].quantity
                                              .toString() +
                                          'x ' +
                                          snapshot.data!.data!.orderData.lineItems[0].name
                                              .toString(),
                                      snapshot.data!.data!.orderData.paymentMethodTitle
                                          .toString(),
                                      snapshot.data!.data!.orderData.lineItems[0].currencySymbol+
                                          snapshot.data!.data!.orderData.lineItems[0].total
                                              .toString(),
//DateFormat("MMM, dd-yyyy").format(order.dateCreated.date),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      addHeight(16),
                      Card(
                          child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Column(
                          children: [
                            _getStoreName(storeInfo
                                    .storeInformation.name.isEmpty
                                ? "N/A"
                                : storeInfo.storeInformation.name.toString()),
                            _getStoreNumber(storeInfo
                                    .storeInformation.phone.isEmpty
                                ? "N/A"
                                : storeInfo.storeInformation.phone.toString()),
                            _getStoreAddress(
                                storeInfo.storeInformation.address.isEmpty
                                    ? "N/A"
                                    : storeInfo.storeInformation.address
                                        .toString()),
                            addHeight(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Chat',
                                        style: TextStyle(
                                            color: AppTheme.primaryColor,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(MyRouter.chatScreen,
                                        arguments: [
                                          '',
                                          storeInfo.storeInformation,
                                          'store',
                                          storeInfo.orderData.id
                                        ]);
                                  },
                                  child: const CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.pinkAccent,
                                    child: Icon(
                                      Icons.chat,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            addHeight(16),
                          ],
                        ),
                      )),
                      addHeight(16),
                      Positioned(
                        bottom: 0,
                        child: Card(
                            child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Column(
                            children: [
                              addHeight(20),
                              _getPaymentDetails(
                                  'Delivery fee',
                                  storeInfo.orderData.currencySymbol
                                          .toString() +
                                      storeInfo.orderData.shippingTotal
                                          .toString()),
                              addHeight(24),
                              _getPaymentDetails(
                                  'Tax (Vat)',
                                  storeInfo.orderData.currencySymbol
                                          .toString() +
                                      storeInfo.orderData.totalTax.toString()),
                              addHeight(24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Payment',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                  Text(
                                    storeInfo.orderData.currencySymbol
                                            .toString() +
                                        storeInfo.orderData.total.toString(),
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  )
                                ],
                              ),
                              /*addHeight(30),
                      CommonButton(
                          buttonHeight: 6.5,
                          buttonWidth: 80,
                          text: 'Mark Delivered',
                          onTap: (){
                            // Get.toNamed(MyRouter.cartScreen);
                          },
                          mainGradient: AppTheme.primaryGradientColor),*/
                              addHeight(20),
                            ],
                          ),
                        )),
                      ),

                      // Text('tyggh'),
                      // StoreInformation(snapshot.data!.data),
                      // Container(
                      //   padding: const EdgeInsets.all(4),
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(50.0)),
                      //   child: TabBar(
                      //     unselectedLabelColor: Colors.black,
                      //     labelColor: Colors.white,
                      //     tabs: const [
                      //       Tab(
                      //         child: Text(
                      //           'Store Information',
                      //           style: TextStyle(fontWeight: FontWeight.bold),
                      //         ),
                      //       )
                      //     ],
                      //     labelStyle: const TextStyle(
                      //         fontSize: 18.0, color: Colors.white),
                      //     unselectedLabelStyle: const TextStyle(
                      //         fontSize: 18.0, color: Colors.black),
                      //     controller: tabController,
                      //     indicatorSize: TabBarIndicatorSize.tab,
                      //     indicator: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(50),
                      //       color: AppTheme.primaryColor,
                      //     ),
                      //   ),
                      // ),
                      // addHeight(4),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height,
                      //   child: TabBarView(
                      //     children: [StoreInformation(snapshot.data!.data)],
                      //     controller: tabController,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            } else {
              Text(snapshot.data.toString());
            }
            return const Center(
                child:
                    CircularProgressIndicator(color: AppTheme.newprimaryColor));
          },
        ),
      ),
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
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
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
                      status,
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

  Widget _getStoreName(String storeName) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Store Name',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                addHeight(4),
                Text(
                  storeName,
                  style: const TextStyle(
                      color: Color(0xff303c5e),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.pink,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ],
        ),
        addHeight(10),
        const Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _getStoreNumber(String storeNumber) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addHeight(10),
                const Text(
                  'Store Number',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                addHeight(4),
                Text(
                  storeNumber,
                  style: const TextStyle(
                      color: Color(0xff303c5e),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                // var storeContact = widget.data!.storeInformation!.phone;

                // launchCaller(storeContact);
              },
              child: const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        addHeight(10),
        const Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _getStoreAddress(String storeAddress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addHeight(10),
                  const Text(
                    'Store Address',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  addHeight(4),
                  Text(
                    storeAddress,
                    style: const TextStyle(
                        color: Color(0xff303c5e),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                final quary = storeAddress.toString();
                GeoCode geoCode = GeoCode();
                try {
                  Coordinates coordinates =
                      await geoCode.forwardGeocoding(address: quary);

                  var latitude = coordinates.latitude;
                  var longitude = coordinates.longitude;
                  navigateTo(latitude, longitude);
                } catch (e) {
                  // print(e);
                }
              },
              child: const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.pinkAccent,
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        addHeight(10),
        const Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _getPaymentDetails(String payTitle, String paySubTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          payTitle,
          style: const TextStyle(
              color: Color(0xff303c5e),
              fontSize: 14.0,
              fontWeight: FontWeight.w500),
        ),
        Text(
          paySubTitle,
          style: const TextStyle(
              color: Color(0xff303c5e),
              fontSize: 14.0,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  launchCaller(storeContact) async {
    final url = "tel:$storeContact";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void navigateTo(var latitude, var longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not launch ${googleUrl.toString()}';
    }
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
