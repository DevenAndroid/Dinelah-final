import 'package:dinelah/controller/BottomNavController.dart';
import 'package:dinelah/models/ModelAllAttrubutes.dart';
import 'package:dinelah/models/PopularProduct.dart';
import 'package:dinelah/repositories/get_update_cart_repository.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/ui/widget/common_button.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/CartController.dart';

class ItemVariationBottomSheet extends StatefulWidget {
  final ModelProduct popularProducts;
  const ItemVariationBottomSheet(this.popularProducts, {Key? key})
      : super(key: key);

  @override
  ItemVariationBottomSheetState createState() =>
      ItemVariationBottomSheetState();
}

class ItemVariationBottomSheetState extends State<ItemVariationBottomSheet> {
  int productQuantity = 1;

  // final bottomNavController = Get.put(BottomNavController());
  var selectedAttributes = RxList<ModelAllAttributesReq>.empty();
  @override
  Widget build(BuildContext context) {
    ModelProduct popularProduct = widget.popularProducts;
    if (selectedAttributes.value.isEmpty) {
      for (var item in popularProduct.attributeData!) {
        // for (var i = 0; i < item.items.length;) {
        selectedAttributes.value.add(ModelAllAttributesReq(
            item.name.toString(), '0'.obs, item.items![0].termId));
        // }
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Get.back(),
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.clear)),
              ),
              addHeight(8),
              Text(
                popularProduct.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              addHeight(8),
              Text(
                popularProduct.description,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              const Divider(),
              addHeight(8),
              ListView.builder(
                  itemCount: popularProduct.attributeData!.length,
                  //snapshot.data!.data[0].attributes.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    return attributeList(
                        popularProduct.attributeData![index],
                        popularProduct.attributeData!,
                        index,
                        selectedAttributes);
                  }),
              addHeight(4),
              addHeight(8),
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: AppTheme.primaryColor)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            getUpdateCartVariationData(
                                    context,
                                    popularProduct.id,
                                    '$productQuantity',
                                    selectedAttributes.value)
                                .then((value) {
                              showToast(value.message);
                              if (value.status) {
                                decrement();
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
                            child: Center(
                              child: Text(
                                '$productQuantity',
                                style: const TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        addWidth(10),
                        InkWell(
                          onTap: () {
                            getUpdateCartVariationData(
                                    context,
                                    popularProduct.id,
                                    '$productQuantity',
                                    selectedAttributes.value)
                                .then((value) {
                              final CartController _cartController = Get.put(CartController());
                              showToast(value.message);
                              if (value.status) {
                                increment();
                                _cartController.getData();
                              }
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
                          final CartController _cartController = Get.put(CartController());
                          getUpdateCartVariationData(context, popularProduct.id,
                                  '$productQuantity', selectedAttributes.value)
                              .then((value) {
                            _cartController.getData();
                            showToast(value.message);
                            if (value.status) {
                              Get.back();
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
  }

  attributeList(AttributeData attributeData, List<AttributeData> attributeDatas,
      int parentIndex, selectedAttributes) {
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
            itemCount: attributeData.items!.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              return attributeOptionList(attributeData.items![index], index,
                  attributeDatas, parentIndex, selectedAttributes);
            }),
      ],
    );
  }

  increment() {
    setState(() {
      productQuantity++;
    });
  }

  decrement() {
    setState(() {
      productQuantity--;
    });
  }

  attributeOptionList(Items item, int index, List<AttributeData> attributeDatas,
      int parentIndex, selectedAttributes) {
    return Obx(() {
      return Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                selectedAttributes.value[parentIndex].termId = item.termId;
                selectedAttributes.value[parentIndex].currentIndex!.value =
                    index.toString();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    selectedAttributes.value[parentIndex].currentIndex!.value
                                .toString() ==
                            index.toString()
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: AppTheme.primaryColor,
                  )
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
