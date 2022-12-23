import 'dart:convert';

import 'package:dinelah/controller/BottomNavController.dart';
import 'package:dinelah/controller/CartController.dart';
import 'package:dinelah/models/ModelGetCart.dart';
import 'package:dinelah/repositories/get_cart_data_repository.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/ui/widget/common_button.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/Helpers.dart';
import '../../models/ModelLogIn.dart';
import '../../repositories/get_update_cart_repository.dart';
import '../../res/app_assets.dart';
import '../../routers/my_router.dart';
import '../widget/common_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  final CartController _cartController = Get.put(CartController());

  @override
  void deactivate() {
    super.deactivate();
    _cartController.onClose();
  }

  @override
  void initState() {
    super.initState();
    getCartData().then((value) {
      _cartController.isDataLoading.value = true;
      _cartController.model.value = value;
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          color: AppTheme.primaryColor,
          onRefresh: () async {
            _cartController.getData();
          },
          child: Obx(() {
            return _cartController.isDataLoading.value
                ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: _cartController.model.value.data!.items.isEmpty
                  ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.emptyCart,
                        height: 190,
                        width: 190,
                      ),
                      addHeight(16),
                      const Text(
                        'Your cart is empty',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor),
                      ),
                      const Text(
                        'Add something to make me happy :)',
                        style: TextStyle(
                            height: 1.5,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      )
                    ],
                  ))
                  : Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      Column(
                        children: [
                          Expanded(
                            // height: MediaQuery.of(context).size.height*0.50,
                            child: ListView.builder(
                                  itemCount: _cartController.model.value.data!.items.length,
                                  // itemCount: 50,
                                  scrollDirection: Axis.vertical,
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return orderCard(
                                      _cartController.model.value.data!.items,
                                      index,
                                    );
                                  }
                                  ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  addHeight(10),
                                  _getPaymentDetails(
                                      'Subtotal:',
                                      _cartController.model.value.data!
                                          .cartmeta.currencySymbol +
                                          _cartController.model.value
                                              .data!.cartmeta.subtotal),
                                  addHeight(8),
                                  _getPaymentDetails(
                                      'Tax and fee:',
                                      _cartController.model.value.data!
                                          .cartmeta.currencySymbol +
                                          (double.parse(_cartController
                                              .model
                                              .value
                                              .data!
                                              .cartmeta
                                              .shippingTotal) +
                                              double.parse(
                                                  _cartController
                                                      .model
                                                      .value
                                                      .data!
                                                      .cartmeta
                                                      .totalTax))
                                              .toStringAsFixed(2)),
                                  addHeight(8),
                                  _getPaymentDetails(
                                      'Delivery:', 'Free'),
                                  addHeight(8),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total:',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                            AppTheme.primaryColor),
                                      ),
                                      Text(
                                        _cartController
                                            .model
                                            .value
                                            .data!
                                            .cartmeta
                                            .currencySymbol +
                                            _cartController.model.value
                                                .data!.cartmeta.total
                                                .toString(),
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  addHeight(14),
                                  CommonButton(
                                      buttonHeight: 6.4,
                                      buttonWidth: 100,
                                      text: 'Checkout',
                                      onTap: () async {
                                        SharedPreferences pref = await SharedPreferences.getInstance();
                                        if (pref.getString('user') != null) {
                                          ModelLogInData? user =
                                          ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
                                          String webUrl = "${"${ApiUrls.domainName}checkout/?cookie=" +
                                              user.cookie}&appchekout=yes";
                                          Get.toNamed(MyRouter.checkoutScreen,
                                              arguments: [
                                                _cartController.model.value.data!.cartmeta.currencySymbol,
                                                webUrl
                                              ]);
                                        } else {
                                          Get.toNamed(MyRouter.logInScreen);
                                        }
                                      },
                                      mainGradient: AppTheme
                                          .primaryGradientColor),
                                  addHeight(10),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      // Positioned(
                      //   bottom: 8,
                      //   right: 0,
                      //   left: 0,
                      //   child: ,
                      // ),
                    ],
                  ),
            )
                : const Center(
                child: CircularProgressIndicator(
                  color: AppTheme.newprimaryColor,
                ));
          }),
        ));
  }

  Widget orderCard(
      List<Items> items,
      index,
      ) {
    Items item = items[index];

    return InkWell(
      onTap: () {
        //Get.toNamed(MyRouter.singleProductScreen);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                borderRadius: BorderRadius.circular(50),
                elevation: 2,
                child: SizedBox(
                  height: 95,
                  width: 95,
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(50)),
                    child: Image.network(
                      item.product!.imageUrl,
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
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              addWidth(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addHeight(8),
                    Text(
                      item.product!.name,
                      maxLines: 3,
                      style: const TextStyle(
                          color: AppTheme.textColorDarkBLue,
                          fontSize: 16.0,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    addHeight(8),
                    Text(
                      '${item.product!.currencySymbol} ${item.product!.price}',
                      style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    addHeight(8),
                    item.product!.type == 'booking'
                        ? Row(
                      children: [
                        Text(
                          "Qty: ${item.quantity}",
                          style: const TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                        : Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (item.quantity < 1) {
                              getUpdateCartData(
                                  context, item.product!.id, 0)
                                  .then((value) async {
                                if (value.status) {
                                  showToast(value.message);
                                  setState(() {
                                    getCartData().then((value) =>
                                    _cartController.model.value =
                                        value);
                                  });
                                } else {
                                  Helpers.createSnackBar(context,
                                      value.message.toString());
                                }
                                return;
                              });
                            } else {
                              getUpdateCartData(
                                  context, item.product!.id, '-1')
                                  .then((value) async {
                                if (value.status) {
                                  showToast(value.message);
                                  _cartController.getData();
                                  if (item.quantity == 1) {
                                    items.removeAt(index);
                                  } else {
                                    item.quantity = item.quantity - 1;
                                  }
                                  setState(() {
                                    getCartData().then((value) =>
                                    _cartController.model.value =
                                        value);
                                  });
                                } else {
                                  Helpers.createSnackBar(context,
                                      value.message.toString());
                                }
                                return;
                              });
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  borderRadius:
                                  BorderRadius.circular(5)),
                              child: const Icon(
                                Icons.remove,
                                size: 16,
                                color: Colors.white,
                              )),
                        ),
                        addWidth(10),
                        Text(
                          item.quantity.toString(),
                          style: const TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        addWidth(10),
                        InkWell(
                          onTap: () {
                            getUpdateCartData(
                                context, item.product!.id, 1)
                                .then((value) async {
                              _cartController.getData();
                              if (value.status) {
                                showToast(value.message);
                                setState(() {
                                  item.quantity = item.quantity + 1;
                                  getCartData().then((value) =>
                                  _cartController.model.value =
                                      value);
                                });
                              } else {
                                Helpers.createSnackBar(
                                    context, value.message.toString());
                              }
                              return;
                            });
                          },
                          child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  borderRadius:
                                  BorderRadius.circular(5)),
                              child: const Icon(
                                Icons.add,
                                size: 16,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  getUpdateCartData(
                      context, item.product!.id, 0)
                      .then((value) async {
                    _cartController.getData();
                    if (value.status) {
                      showToast(value.message);
                      setState(() {
                        getCartData().then(
                                (value) => _cartController.model.value = value);
                      });
                    } else {
                      Helpers.createSnackBar(context, value.message.toString());
                    }
                  });
                },
                child: const Icon(
                  Icons.cancel_outlined,
                  size: 28,
                  color: AppTheme.newprimaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPaymentDetails(String payTitle, String paySubTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          payTitle,
          style: const TextStyle(
              color: AppTheme.textColorDarkBLue,
              fontSize: 18.0,
              fontWeight: FontWeight.w500),
        ),
        Text(
          paySubTitle,
          style: const TextStyle(
              color: Colors.grey, fontSize: 18.0, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
