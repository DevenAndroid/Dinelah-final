// import 'package:dinelah/models/PopularProduct.dart';
// import 'package:flutter/material.dart';
//
// class VariationProduct {
//
//   getVariationBottomSheet(ModelProduct popularProduct,context) {
//     return showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         builder: (context) {
//           return SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Container(
//                 color: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       popularProduct.name,
//                       style:
//                       TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     addHeight(8),
//                     Text(
//                       popularProduct.description,
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.grey),
//                     ),
//                     Divider(),
//                     addHeight(8),
//                     ListView.builder(
//                         itemCount: popularProduct.attributeData.length,
//                         //snapshot.data!.data[0].attributes.length,
//                         shrinkWrap: true,
//                         itemBuilder: (BuildContext context, index) {
//                           return attributeList(
//                               popularProduct.attributeData[index], popularProduct.attributeData, index);
//                         }),
//                     addHeight(4),
//                     addHeight(8),
//                     Row(
//                       children: [
//                         Container(
//                           height: MediaQuery.of(context).size.height * 0.06,
//                           decoration: BoxDecoration(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(5.0)),
//                               border: Border.all(color: Colors.blueAccent)),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               InkWell(
//                                 onTap: (){
//                                   getUpdateCartVariationData(context,
//                                       popularProduct.id,
//                                       '${_controller.productQuantity}',
//                                       attributeSize,
//                                       attributeColor
//                                   ).then((value) {
//                                     if(value.status){
//                                       _controller.decrement();
//                                       Fluttertoast.showToast(
//                                         msg: value.message,  // message
//                                         toastLength: Toast.LENGTH_SHORT, // length
//                                         gravity: ToastGravity.CENTER,    // location// duration
//                                       );
//                                     };
//                                     return null;
//                                   });
//                                 },
//                                 child: Container(
//                                     padding: EdgeInsets.only(
//                                         top: 4, bottom: 4, left: 8),
//                                     child: Icon(
//                                       Icons.remove,
//                                       size: 16,
//                                       color: Colors.grey,
//                                     )),
//                               ),
//                               addWidth(10),
//                               Container(
//                                   height: MediaQuery.of(context).size.height,
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 8, vertical: 8),
//                                   color: Color(0xffffe6e7),
//                                   child: Center(child: Obx(() {
//                                     return Text(
//                                       '${_controller.productQuantity}',
//                                       style: TextStyle(
//                                           color: AppTheme.primaryColor,
//                                           fontSize: 16.0,
//                                           fontWeight: FontWeight.bold),
//                                     );
//                                   }))),
//                               addWidth(10),
//                               InkWell(
//                                 onTap: (){
//                                   getUpdateCartVariationData(context,
//                                       popularProduct.id,
//                                       '${_controller.productQuantity}',
//                                       attributeSize,
//                                       attributeColor
//                                   ).then((value) {
//                                     if(value.status){
//                                       _controller.increment();
//                                       Fluttertoast.showToast(
//                                         msg: value.message,  // message
//                                         toastLength: Toast.LENGTH_SHORT, // length
//                                         gravity: ToastGravity.CENTER,    // location// duration
//                                       );
//                                     };
//                                     return null;
//                                   });
//                                 },
//                                 child: Container(
//                                     padding: EdgeInsets.only(
//                                         top: 4, bottom: 4, right: 8),
//                                     child: Icon(
//                                       Icons.add,
//                                       size: 16,
//                                       color: Colors.grey,
//                                     )),
//                               ),
//                             ],
//                           ),
//                         ),
//                         addWidth(10),
//                         Expanded(
//                           child: CommonButton(
//                               buttonHeight: 6.5,
//                               buttonWidth: 60,
//                               text: 'ADD TO CART',
//                               onTap: () {
//                                 print("Atribute Data :: "+attributeSize+'\n'+ attributeColor);
//                                 getUpdateCartVariationData(context,
//                                     popularProduct.id,
//                                     '${_controller.productQuantity}',
//                                     attributeSize,
//                                     attributeColor
//                                 ).then((value) {
//                                   if(value.status){
//                                     Fluttertoast.showToast(
//                                       msg: value.message,  // message
//                                       toastLength: Toast.LENGTH_SHORT, // length
//                                       gravity: ToastGravity.CENTER,    // location// duration
//                                     );
//                                   };
//                                   return null;
//                                 });
//
//                               },
//                               mainGradient: AppTheme.primaryGradientColor),
//                         )
//                       ],
//                     ),
//                   ],
//                 )),
//           );
//         });
//   }
//
//   attributeList(AttributeData attributeData, List<AttributeData> attributeDatas, int parentIndex) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           attributeData.name,
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         addHeight(4),
//         Text(
//           'Please select any one option',
//           style: TextStyle(
//               fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
//         ),
//         addHeight(10),
//         ListView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: attributeData.items.length, //attribut.items.length,
//             shrinkWrap: true,
//             itemBuilder: (BuildContext context, index) {
//               return attributeOptionList(attributeData.items[index], index, attributeDatas, parentIndex);
//             }),
//       ],
//     );
//   }
//
//   attributeOptionList(Items item, int index, List<AttributeData> attributeDatas, int parentIndex) {
//     return Column(
//       children: [
//         Obx(() {
//           return InkWell(
//             onTap: () {
//               if (attributeDatas[parentIndex].name == 'Color') {
//                 attributeColor = item.name;
//                 _controller.currentIndex.value = index;
//               } else {
//                 attributeSize = item.name;
//                 _controller.currentIndex1.value = index;
//               }
//               print('VALUE DATA ' + attributeDatas[parentIndex].name);
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     item.name,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Image.asset(attributeDatas[parentIndex].name == 'Color'
//                       ? _controller.currentIndex.value == index
//                       ? AppAssets.radioCheck
//                       : AppAssets.radioUncheck
//                       : _controller.currentIndex1.value == index
//                       ? AppAssets.radioCheck
//                       : AppAssets.radioUncheck)
//                   /*Radio(
//                     value: length,
//                     groupValue: _value,
//                     onChanged: (lo) {
//                       setState(() {
//                         _value = lo as int;
//                         //print("lsjkfkdjg<<<<<<<<<<>>>>>>>>>>>"+_value.toString());
//                       });
//                     })*/
//                 ],
//               ),
//             ),
//           );
//         }),
//       ],
//     );
//   }
//
//   attributeOptionList01(Items item, int index) {
//     return Column(
//       children: [
//         Obx(() {
//           return InkWell(
//             onTap: () {
//               item.isSelected = !item.isSelected;
//               // _controller.currentIndex.value = index;
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     item.name,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Image.asset(item.isSelected
//                       ? AppAssets.radioCheck
//                       : AppAssets.radioUncheck)
//                 ],
//               ),
//             ),
//           );
//         }),
//       ],
//     );
//   }
// }