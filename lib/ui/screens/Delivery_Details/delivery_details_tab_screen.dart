import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/ModelSingleOrder.dart';
import '../../../routers/my_router.dart';

class DeliveryDetails extends StatefulWidget {
  Data? data;
  DeliveryDetails(this.data, {Key? key}) : super(key: key);

  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  @override
  Widget build(BuildContext context) {
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
                _getDeliveryName(widget.data!.deliveryDetail == null
                    ? "N/A"
                    : widget.data!.deliveryDetail!.name.toString()),
                _getDeliveryNumber(widget.data!.deliveryDetail == null
                    ? "N/A"
                    : widget.data!.deliveryDetail!.phone.toString()),
                _getDeliveryAddress(widget.data!.deliveryDetail == null
                    ? "N/A"
                    : widget.data!.deliveryDetail!.address.toString()),
                addHeight(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
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
                        Get.toNamed(MyRouter.chatScreen, arguments: ['',
                          widget.data!.deliveryDetail,
                          'driver',
                          widget.data!.orderData.id
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
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                children: [
                  addHeight(20),
                  _getPaymentDetails(
                      'Delivery fee',
                      orderData.currencySymbol.toString() +
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
                        //Get.toNamed(MyRouter.assignedOrder);
                      },
                      mainGradient: AppTheme.primaryGradientColor),*/
                  addHeight(20),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }

  Widget _getDeliveryName(String driverName) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Driver Name',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                addHeight(4),
                Text(
                  driverName,
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

  Widget _getDeliveryNumber(String driverNumber) {
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
                  'Driver Number',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                addHeight(4),
                Text(
                  driverNumber,
                  style: const TextStyle(
                      color: Color(0xff303c5e),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                var driverContact = widget.data!.deliveryDetail!.phone;

                launchCaller(driverContact);
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

  Widget _getDeliveryAddress(String driverAddress) {
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
                    'Delivery Address',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  addHeight(4),
                  Text(
                    driverAddress,
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
                final quary = driverAddress.toString();
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
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
        Text(
          paySubTitle,
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  launchCaller(driverContact) async {
    final url = "tel:$driverContact";
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
