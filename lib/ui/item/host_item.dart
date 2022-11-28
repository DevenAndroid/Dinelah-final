
import 'package:dinelah/models/ModelVendorStore.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

Widget hostItem(context, ModelStores store) {
  return GestureDetector(
    onTap: () {
      debugPrint(
          "::::StoreId::::${store.id}::::StoreId::::${store.storeName}");
      Get.toNamed(MyRouter.hostsScreen, arguments: [store]);
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                  ),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                      height: 160,
                      child: Hero(
                        tag: store.storeName.toString(),
                        child: Image.network(
                          store.banner,
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
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(store.storeName.toString().capitalizeFirst??'',
                      style: const TextStyle(
                          color: AppTheme.textColorDarkBLue,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                  addHeight(8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          var driverContact = store.storePhone;

                          launchCaller(driverContact);
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.call,
                              size: 18,
                              color: AppTheme.primaryColor,
                            ),
                            addWidth(8),
                            Text(store.storePhone.toString(),
                                style: const TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          launch(store.storeReviewUrl.toString());
                        },
                        child: Row(
                          children: [
                            RatingBar.builder(
                              initialRating: double.parse(
                                  store.rating.rating
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
                            Text('(${store.rating.count})',
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                      ),
                    ],
                  ),
                  addHeight(4.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 20,
                        color: AppTheme.primaryColor,
                      ),
                      addWidth(8),
                      Expanded(
                        child: Text(store.address,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
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
