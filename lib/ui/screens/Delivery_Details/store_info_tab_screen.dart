import 'package:dinelah/models/ModelSingleOrder.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class StoreInformation extends StatefulWidget {
  Data? data;

  StoreInformation(this.data, {Key? key}) : super(key: key);

  @override
  _StoreInformationState createState() => _StoreInformationState();
}

class _StoreInformationState extends State<StoreInformation> {
  @override
  Widget build(BuildContext context) {
    var storeInfo = widget.data!.storeInformation;
    var orderData = widget.data!.orderData;
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),
      body: Column(
        children: [
          Card(
              child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                _getStoreName(storeInfo!.name!.isEmpty
                    ? "N/A"
                    : storeInfo.name.toString()),
                _getStoreNumber(storeInfo.phone!.isEmpty
                    ? "N/A"
                    : storeInfo.phone.toString()),
                _getStoreAddress(storeInfo.address!.isEmpty
                    ? "N/A"
                    : storeInfo.address.toString()),
                addHeight(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                        Get.toNamed(MyRouter.chatScreen, arguments: [
                              '',
                          widget.data!.storeInformation,
                          'store',
                          widget.data!.orderData!.id
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
          Card(
              child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                addHeight(20),
                _getPaymentDetails(
                    'Delivery fee',
                    orderData!.currencySymbol.toString() +
                        orderData.shippingTotal.toString()),
                addHeight(24),
                _getPaymentDetails(
                    'Tax (Vat)',
                    orderData.currencySymbol.toString() +
                        orderData.totalTax.toString()),
                addHeight(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Payment',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    Text(
                      orderData.currencySymbol.toString() +
                          orderData.total.toString(),
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
          ))
        ],
      ),
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
                var storeContact = widget.data!.storeInformation!.phone;

                launchCaller(storeContact);
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
}
