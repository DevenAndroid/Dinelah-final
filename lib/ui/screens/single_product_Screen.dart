import 'package:cached_network_image/cached_network_image.dart';
import 'package:dinelah/controller/BottomNavController.dart';
import 'package:dinelah/helper/Helpers.dart';
import 'package:dinelah/models/PopularProduct.dart';
import 'package:dinelah/repositories/get_update_cart_repository.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/ui/screens/item/ItemVariationBottomSheet.dart';
import 'package:dinelah/ui/widget/common_button.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/app_assets.dart';

import 'package:flutter_html/flutter_html.dart';

class SingleProductScreen extends StatefulWidget {
  const SingleProductScreen({Key? key}) : super(key: key);

  @override
  SingleProductScreenState createState() => SingleProductScreenState();
}

class SingleProductScreenState extends State<SingleProductScreen> {
  bool value = false;
  int productQuantity = 1;

  final bottomNavController = Get.put(BottomNavController());
  late ModelProduct model;
  @override
  void initState() {
    super.initState();

    bottomNavController.getData();
    model = Get.arguments[0];
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
          color: Color(0xfffff8f9),
          image: DecorationImage(
            image: AssetImage(
              AppAssets.singleProductShapeBg,
            ),
            alignment: Alignment.topRight,
            fit: BoxFit.contain,
          )),
      child: Scaffold(
          appBar: backAppBar(""),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  addHeight(4),
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: model.imageUrl,
                      child: Material(
                        borderRadius: BorderRadius.circular(100),
                        elevation: 3,
                        child: SizedBox(
                          height: 155,
                          width: 155,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            child: CachedNetworkImage(
                              imageUrl: model.imageUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                  height: 4,
                                  width: 4,
                                  child: const CircularProgressIndicator(
                                    color: AppTheme.primaryColor,
                                  )),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            // Image.network(
                            //   model.imageUrl,
                            //   loadingBuilder: (BuildContext context,
                            //       Widget child,
                            //       ImageChunkEvent? loadingProgress) {
                            //     if (loadingProgress == null) {
                            //       return child;
                            //     }
                            //     return Center(
                            //       child: Padding(
                            //         padding: const EdgeInsets.only(
                            //             top: 10.0, bottom: 10.0),
                            //         child: CircularProgressIndicator(
                            //           color: AppTheme.primaryColor,
                            //           value:
                            //               loadingProgress.expectedTotalBytes !=
                            //                       null
                            //                   ? loadingProgress
                            //                           .cumulativeBytesLoaded /
                            //                       loadingProgress
                            //                           .expectedTotalBytes!
                            //                   : null,
                            //         ),
                            //       ),
                            //     );
                            //   },
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  addHeight(24),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 32.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xfff3f3f3),
                    ),
                    child: Column(
                      children: [
                        Hero(
                          tag: model.name.toString(),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              model.name,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textColorDarkBLue),
                            ),
                          ),
                        ),
                        addHeight(12.0),
                        Row(
                          children: [
                            const Text(
                              'From',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            addWidth(10),
                            Expanded(
                              child: Html(data: model.price.toString(),
                                style: {
                                  "bdi": Style(
                                    fontSize: const FontSize(18.0),
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                },
                              ),

                            ),
                          ],
                        ),
                        addHeight(12.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Sold by: ',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    height: 1.5,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: model.storeName.toString(),
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          height: 1.5,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.textColorSkyBLue)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        addHeight(12.0),
                        Row(
                          children: [
                            const Text(
                              'Rating:',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            addWidth(10),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    launch(model.permalink.toString());
                                  },
                                  child: RatingBar.builder(
                                    initialRating: double.parse(model.averageRating.toString()),
                                    minRating: 0,
                                    itemSize: 18,
                                    ignoreGestures: true,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, _) =>
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      debugPrint(rating.toString());
                                    },
                                  ),
                                ),
                                Text('(${(model.ratingCount
                                    .toString())})',
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ],
                        ),
                        addHeight(12.0),
                        Row(
                          children: [
                            const Text(
                              'Qty:',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            ),
                            addWidth(10),
                            Text(
                              model.stockQuantity.toString().isEmpty
                                  ? "0"
                                  : model.stockQuantity.toString(),
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textColorSkyBLue),
                            ),
                          ],
                        ),
                        addHeight(20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Description',
                            style: TextStyle(
                                fontSize: 20.0,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textColorDarkBLue),
                          ),
                        ),
                        addHeight(12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Html(
                            data: model.description.toString(),
                          )
                          /*Text(
                            model.description.toString(),
                            style: const TextStyle(
                                fontSize: 16.0,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          )*/,
                        ),
                        addHeight(40.0),
                        CommonButton(
                            buttonHeight: 6.5,
                            buttonWidth: 75,
                            text: 'ADD TO CART',
                            onTap: () {
                              if (model.type.toString() == "simple") {
                                // ++bottomNavController.cartBadgeCount.value;
                                getUpdateCartData(context, model.id, 1)
                                    .then((value) {
                                      showToast(value.message);
                                  if (value.status) {
                                    bottomNavController.getData();
                                    Get.back();
                                    // Helpers.createSnackBar(
                                    //     context, value.message.toString());
                                  }
                                  return null;
                                });
                              } else {
                                _getVariationBottomSheet(model);
                              }
                            },
                            mainGradient: AppTheme.primaryGradientColor),
                        addHeight(20.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _getVariationBottomSheet(ModelProduct popularProduct) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return ItemVariationBottomSheet(model);
        });
  }
}
