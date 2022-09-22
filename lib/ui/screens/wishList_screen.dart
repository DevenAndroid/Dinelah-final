import 'package:dinelah/controller/WishListController.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/ui/screens/item/ItemProduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWishList extends StatelessWidget {
  MyWishList({Key? key}) : super(key: key);
  final _wishListController = Get.put(WishListController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double itemHeight = screenSize.height / 3.4;
    // final double itemWidth = screenSize.width / 2.1;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: () async {
          _wishListController.getYourWishList();
        },
        child: Obx(() {
          return _wishListController.isDataLoading.value
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, left: 16.0, right: 16.0, bottom: 12),
                  child: _wishListController.model.value.data!.isEmpty
                      ? const Center(
                          child: Text(
                          'No item in your wishlist',
                          style: TextStyle(fontSize: 18),
                        ))
                      : CustomScrollView(
                          slivers: <Widget>[
                            SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 236,
                                      mainAxisSpacing: 10.0,
                                      crossAxisSpacing: 10.0),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return ItemProduct(
                                      _wishListController,
                                      _wishListController.model.value.data!,
                                      index,
                                      itemHeight,
                                      true);
                                },
                                childCount: _wishListController
                                    .model.value.data!.length,
                              ),
                            ),
                            const SliverPadding(
                              padding: EdgeInsets.only(bottom: 80.0),
                            )
                          ],
                        ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                      color: AppTheme.newprimaryColor));
        }),
      ),
    );
  }

  /*Widget popularDishes(ModelProduct data) {
    // bool isAdded = true;
    return GestureDetector(
      onTap: () {
        if (data.type.toString() == "simple") {
          Get.toNamed(MyRouter.singleProductScreen, arguments: [data.id]);
        } else if (data.type.toString() == "variable") {
          Get.toNamed(MyRouter.singleProductScreen, arguments: [data.id]);
        } else {
          Get.toNamed(MyRouter.bookingProductScreen, arguments: [data.id]);
        }
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 0.5),
                    blurRadius: 0.5,
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    elevation: 3,
                    child: SizedBox(
                      height: 95,
                      width: 95,
                      child: ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(50)),
                        child: Image.network(
                          data.imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                addHeight(10),
                Text(
                  data.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AppTheme.textColorDarkBLue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                addHeight(4),
                Text(data.categoryName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                addHeight(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.currencySymbol + data.price,
                      style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        if (data.type.toString() == "simple") {
                          getUpdateCartData(context, data.id, 1).then((value) {
                            if (value.status) {
                              Helpers.createSnackBar(
                                  context, value.message.toString());
                            } else {}
                            return;
                          });
                        } else if (data.type.toString() == "variable") {
                          _getVariationBottomSheet(data);
                        } else if (data.type.toString() == "booking") {
                          Get.toNamed(MyRouter.bookingProductScreen,
                              arguments: [data.id]);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppTheme.primaryColor,
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 18,
                          color: AppTheme.colorWhite,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              right: 6,
              top: 10,
              child: InkWell(
                  onTap: () {
                    removeFromWishlist(context, data.id);
                    setState(() {
                      getWishlistData().then(
                              (value) => _wishListController.model.value = value);
                    });
                  },
                  child:
                  // isAdded
                  //                   ?
                  const Icon(
                    Icons.favorite,
                    color: AppTheme.primaryColor,
                  )
                // : const Icon(Icons.favorite_border)
              ))
        ],
      ),
    );
  }*/

  /* _getVariationBottomSheet(ModelProduct data) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                color: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    addHeight(8),
                    Text(
                      data.description,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    const Divider(),
                    addHeight(8),
                    ListView.builder(
                        itemCount: data.attributeData.length,
                        //snapshot.data!.data[0].attributes.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          return attributeList(data.attributeData[index],
                              data.attributeData, index);
                        }),
                    addHeight(4),
                    addHeight(8),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0)),
                              border: Border.all(color: Colors.blueAccent)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  getUpdateCartVariationData(
                                      context,
                                      data.id,
                                      '${_wishListController.productQuantity}',
                                      attributeSize,
                                      attributeColor)
                                      .then((value) {
                                    if (value.status) {
                                      _wishListController.decrement();
                                      Fluttertoast.showToast(
                                        msg: value.message,
                                        // message
                                        toastLength: Toast.LENGTH_SHORT,
                                        // length
                                        gravity: ToastGravity
                                            .CENTER, // location// duration
                                      );
                                    }
                                    return null;
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4, left: 8),
                                    child: const Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: Colors.grey,
                                    )),
                              ),
                              addWidth(10),
                              Container(
                                  height: MediaQuery.of(context).size.height,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  color: const Color(0xffffe6e7),
                                  child: Center(child: Obx(() {
                                    return Text(
                                      '${_wishListController.productQuantity}',
                                      style: const TextStyle(
                                          color: AppTheme.primaryColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }))),
                              addWidth(10),
                              InkWell(
                                onTap: () {
                                  getUpdateCartVariationData(
                                      context,
                                      data.id,
                                      '${_wishListController.productQuantity}',
                                      attributeSize,
                                      attributeColor)
                                      .then((value) {
                                    if (value.status) {
                                      _wishListController.increment();
                                      Fluttertoast.showToast(
                                        msg: value.message,
                                        // message
                                        toastLength: Toast.LENGTH_SHORT,
                                        // length
                                        gravity: ToastGravity
                                            .CENTER, // location// duration
                                      );
                                    }
                                    return null;
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4, right: 8),
                                    child: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.grey,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        addWidth(10),
                        Expanded(
                          child: CommonButton(
                              buttonHeight: 6.5,
                              buttonWidth: 60,
                              text: 'ADD TO CART',
                              onTap: () {
                                getUpdateCartVariationData(
                                    context,
                                    data.id,
                                    '${_wishListController.productQuantity}',
                                    attributeSize,
                                    attributeColor)
                                    .then((value) {
                                  if (value.status) {
                                    Get.back();
                                    Fluttertoast.showToast(
                                      msg: value.message, // message
                                      toastLength: Toast.LENGTH_SHORT, // length
                                      gravity: ToastGravity
                                          .BOTTOM, // location// duration
                                    );
                                  }
                                  return null;
                                });
                              },
                              mainGradient: AppTheme.primaryGradientColor),
                        )
                      ],
                    ),
                  ],
                )),
          );
        });
  }

  attributeList(AttributeData attributeData, List<AttributeData> attributeDatas,
      int parentIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          attributeData.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        addHeight(4),
        const Text(
          'Please select any one option',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        addHeight(10),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: attributeData.items.length, //attribut.items.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              return attributeOptionList(attributeData.items[index], index,
                  attributeDatas, parentIndex);
            }),
      ],
    );
  }

  attributeOptionList(Items item, int index, List<AttributeData> attributeDatas,
      int parentIndex) {
    return Column(
      children: [
        Obx(() {
          return InkWell(
            onTap: () {
              if (attributeDatas[parentIndex].name == 'Color') {
                attributeColor = item.name;
                _wishListController.currentIndex.value = index;
              } else {
                attributeSize = item.name;
                _wishListController.currentIndex1.value = index;
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(attributeDatas[parentIndex].name == 'Color'
                      ? _wishListController.currentIndex.value == index
                      ? AppAssets.radioCheck
                      : AppAssets.radioUncheck
                      : _wishListController.currentIndex1.value == index
                      ? AppAssets.radioCheck
                      : AppAssets.radioUncheck)
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  attributeOptionList01(Items item, int index) {
    return Column(
      children: [
        Obx(() {
          return InkWell(
            onTap: () {
              item.isSelected = !item.isSelected;
              // _controller.currentIndex.value = index;
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(item.isSelected
                      ? AppAssets.radioCheck
                      : AppAssets.radioUncheck)
                ],
              ),
            ),
          );
        }),
      ],
    );
  }*/
}
