import 'package:dinelah/models/PopularProduct.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/widget/common_button.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import  'package:get/get.dart';

import '../../res/app_assets.dart';

import 'package:flutter_html/flutter_html.dart';

class BookingProductScreen extends StatefulWidget {
  const BookingProductScreen({Key? key}) : super(key: key);

  @override
  BookingProductScreenState createState() => BookingProductScreenState();
}

class BookingProductScreenState extends State<BookingProductScreen> {
  // final controller = Get.put(BookableProductController());
  late ModelProduct model;

  @override
  void initState() {
    super.initState();
    model = Get.arguments[0];
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery
    //     .of(context)
    //     .size;
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
        appBar: backAppBar('Booking product'),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                addHeight(4),
                Align(
                  alignment: Alignment.center,
                  child: Material(
                    borderRadius: BorderRadius.circular(100),
                    elevation: 3,
                    child: SizedBox(
                      height: 155,
                      width: 155,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(100)),
                        child: Image.network(
                          model.imageUrl.toString(),
                          loadingBuilder: (BuildContext context,
                              Widget child,
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
                                  value: loadingProgress
                                      .expectedTotalBytes !=
                                      null
                                      ? loadingProgress
                                      .cumulativeBytesLoaded /
                                      loadingProgress
                                          .expectedTotalBytes!
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
                ),
                addHeight(24),
                Container(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 32.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xfffff8f9),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          model.name
                              .toString(),
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textColorDarkBLue),
                        ),
                      ),
                      addHeight(20),
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

                          addWidth(10),
                          Expanded(
                            child: Html(data: model.price.toString().replaceAll('from', ''),
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
                      ),addHeight(12.0),
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
                              RatingBar.builder(
                                initialRating: double.parse(model.averageRating
                                    .toString()),
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
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
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
                                    text:
                                    ' ${model.storeName!}',
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        height: 1.5,
                                        fontWeight: FontWeight.bold,
                                        color:
                                        AppTheme.textColorSkyBLue)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      addHeight(20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Description',
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
                        child: Text(
                          model.description
                              .toString(),
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ),
                      addHeight(40.0),
                      CommonButton(
                          buttonHeight: 6.5,
                          buttonWidth: 75,
                          text: 'BOOK NOW',
                          onTap: () {
                            Get.toNamed(
                                MyRouter
                                    .bookingProductScreenWithCalender,
                                arguments: [
                                  model.id
                                ]);
                          },
                          mainGradient: AppTheme.primaryGradientColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
