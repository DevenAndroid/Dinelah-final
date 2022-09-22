import 'package:dinelah/controller/BookableProductController.dart';
import 'package:dinelah/controller/BottomNavController.dart';
import 'package:dinelah/models/ModelBookableProduct.dart';
import 'package:dinelah/repositories/bookable_Add_To_Cart_repository.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/widget/common_button.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../res/app_assets.dart';

class BookingProductWithCalender extends StatefulWidget {
  const BookingProductWithCalender({Key? key}) : super(key: key);

  @override
  BookingProductWithCalenderState createState() =>
      BookingProductWithCalenderState();
}

class BookingProductWithCalenderState
    extends State<BookingProductWithCalender> {
  var mList = List<TimeSlots>.empty(growable: true);
  var mListTime = List<String>.empty(growable: true);

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  String? timeSlug;

  String? startTimeSlug = '';

  var selectedtime;
  var selectedtim;

  final controller = Get.put(BookableProductController());

  // List<String> child = ['1'];
  // List<String> adult = ['1'];
  String? selectedChild; // = '1';
  String? selectedAdult; // = '1';

  String? yearSlug;
  String? monthSlug;
  String? daySlug;

  @override
  void initState() {
    super.initState();
    selectedtime = 0;
  }

  @override
  void dispose() {
    super.dispose();
    controller.onClose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    controller.context ??= context;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xfffff8f9),
        image: DecorationImage(
          image: AssetImage(
            AppAssets.singleProductShapeBg,
          ),
          alignment: Alignment.topRight,
          fit: BoxFit.contain,
        ),
      ),
      child: Scaffold(
        appBar: backAppBar('Booking Product'),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Obx(() {
            if (yearSlug == null) {
              yearSlug = DateFormat('yyyy').format(DateTime.now());
              monthSlug = DateFormat('MM').format(DateTime.now());
              daySlug = DateFormat('dd').format(DateTime.now());
            }
            if (controller.isDataLoading.value) {
              var formattedDate1 = DateFormat('yyyy-MM-dd').format(selectedDay);
              for (var date in controller.model.value.data!.availableDates!) {
                if (formattedDate1.toString() == date.date.toString()) {
                  for (var item in date.timeSlots!) {
                    if (!mList.contains(item)) {
                      mList.add(item);
                    }
                  }
                  for (var item in date.timeSlots!) {
                    if (!mListTime.contains(item.time)) {
                      mListTime.add(item.time!);
                    }
                    if (startTimeSlug == '') {
                      startTimeSlug = date.timeSlots![0].time;
                      controller.context = context;
                      if (controller.model.value.data!.durationType!
                              .toString()
                              .toLowerCase() ==
                          'customer') {
                        controller.mListEndTime.clear();
                        controller.getBookableEndDateData(
                            Get.arguments[0],
                            yearSlug.toString(),
                            monthSlug.toString(),
                            daySlug.toString(),
                            startTimeSlug);
                      }
                    }
                  }
                }
              }
            }
            return !controller.isDataLoading.value
                ? loader(context)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Select Date and Time',
                          style: TextStyle(
                              color: AppTheme.colorWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          controller.model.value.data!.description.toString(),
                          style: const TextStyle(
                              height: 1.8, color: Colors.white, fontSize: 20),
                        ),
                      ),
                      addHeight(20.0),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32)),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TableCalendar(
                              firstDay: DateTime(2010),
                              lastDay: DateTime(2030),
                              focusedDay: DateTime.now(),
                              calendarFormat: format,
                              onFormatChanged: (CalendarFormat format) {
                                setState(() {
                                  format = format;
                                });
                              },
                              startingDayOfWeek: StartingDayOfWeek.sunday,
                              daysOfWeekVisible: true,
                              onDaySelected:
                                  (DateTime selectDay, DateTime focusDay) {
                                var formattedDate =
                                    DateFormat('yyyy-MM-dd').format(selectDay);

                                yearSlug = DateFormat('yyyy').format(selectDay);
                                monthSlug = DateFormat('MM').format(selectDay);
                                daySlug = DateFormat('dd').format(selectDay);

                                setState(() {
                                  selectedDay = selectDay;
                                  focusedDay = focusDay;
                                });

                                mList.clear();
                                //New Work
                                for (var date in controller
                                    .model.value.data!.availableDates!) {
                                  if (formattedDate.toString() ==
                                      date.date.toString()) {
                                    for (var item in date.timeSlots!) {
                                      if (!mList.contains(item)) {
                                        mList.add(item); // = date.timeSlots;
                                      }
                                    }
                                    for (var item in date.timeSlots!) {
                                      startTimeSlug = date.timeSlots![0].time;
                                      if (!mListTime.contains(item.time)) {
                                        mListTime.add(item.time!);
                                      }
                                    }
                                  }

                                  if (mList.isNotEmpty) {
                                    controller.context = context;
                                    controller.getBookableEndDateData(
                                        Get.arguments[0],
                                        yearSlug.toString(),
                                        monthSlug.toString(),
                                        daySlug.toString(),
                                        mListTime[0]);
                                  }
                                }
                              },
                              selectedDayPredicate: (DateTime day) {
                                return isSameDay(selectedDay, day);
                              },
                              calendarStyle: const CalendarStyle(
                                isTodayHighlighted: true,
                                selectedDecoration: BoxDecoration(
                                    color: AppTheme.primaryColor,
                                    shape: BoxShape.circle),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12),
                              child: Container(
                                child:
                                    controller.model.value.data!.durationType ==
                                            'fixed'
                                        ?
                                    SizedBox(
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .height *
                                            //     0.60,
                                            child: mList.length > 1
                                                ? GridView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 4,
                                                      childAspectRatio: 2.0,
                                                      mainAxisSpacing: 8.0,
                                                      crossAxisSpacing: 10.0,
                                                    ),
                                                    itemBuilder: (_, index) {
                                                      return timeSlot(
                                                          mList, index);
                                                    },
                                              itemCount: mList.length,
                                                  )
                                                : const Center(
                                                    child: Text(
                                                    "Time slots not found",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppTheme
                                                            .newprimaryColor),
                                                  )),
                                          )
                                        : SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('Start Time'),
                                                    addHeight(10),
                                                    Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                      ),
                                                      child: mListTime.isEmpty
                                                          ? const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: Center(
                                                                  child: Text(
                                                                'Sorry, we don\'t\nhave time slot of today',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              )),
                                                            )
                                                          : DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton(
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      value:
                                                                          startTimeSlug,
                                                                      items: mListTime.map(
                                                                          (String
                                                                              items) {
                                                                        return DropdownMenuItem(
                                                                            value:
                                                                                items,
                                                                            child:
                                                                                Container(
                                                                              width: screenSize.width * 0.30,
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(items,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 16,
                                                                                  )),
                                                                            ));
                                                                      }).toList(),
                                                                      onChanged:
                                                                          (String?
                                                                              newValue) {
                                                                        setState(
                                                                            () {
                                                                          startTimeSlug =
                                                                              newValue!;
                                                                        });
                                                                        controller
                                                                            .mListEndTime
                                                                            .clear();

                                                                        controller.context =
                                                                            context;
                                                                        controller.getBookableEndDateData(
                                                                            Get.arguments[0],
                                                                            yearSlug.toString(),
                                                                            monthSlug.toString(),
                                                                            daySlug.toString(),
                                                                            newValue);
                                                                      }),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                addWidth(12),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('End Time'),
                                                    addHeight(10),
                                                    Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                      ),
                                                      child: !controller
                                                              .isEndDataLoading
                                                              .value
                                                          ? const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8.0,
                                                                      horizontal:
                                                                          38),
                                                              child:
                                                                  CupertinoActivityIndicator(),
                                                            )
                                                          : controller.mListEndTime
                                                                      .isEmpty &&
                                                                  controller
                                                                          .mListEndTime
                                                                          .length >
                                                                      1
                                                              ? const SizedBox
                                                                  .shrink()
                                                              : DropdownButtonHideUnderline(
                                                                  child: DropdownButton(
                                                                      style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      value: controller.dropdownEndTimeValue.value,
                                                                      items: controller.mListEndTime.map((String items) {
                                                                        return DropdownMenuItem(
                                                                          value:
                                                                              items,
                                                                          child: Container(
                                                                              width: screenSize.width * 0.30,
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(
                                                                                items,
                                                                                style: const TextStyle(fontSize: 16),
                                                                              )),
                                                                        );
                                                                      }).toList(),
                                                                      onChanged: (String? newValue) {
                                                                        setState(
                                                                            () {
                                                                          controller
                                                                              .dropdownEndTimeValue
                                                                              .value = newValue!;
                                                                        });
                                                                      }),
                                                                ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12),
                              child: controller.model.value.data!.hasPersons ==
                                      true
                                  ? const Text(
                                      'Person',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.textColorDarkBLue),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                            Container(
                              height: 70,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child:
            controller
                .model.value.data!.personTypeData!.isEmpty?

            SizedBox.shrink():
            controller
                .model.value.data!.personTypeData!.length == 1
                ?
            personData(
            controller
                .model.value.data!.personTypeData!, 0)
            :
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller
                                      .model.value.data!.personTypeData!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return personData(
                                        controller
                                            .model.value.data!.personTypeData!,
                                        index);
                                  }),
                            ),
                            addHeight(20),
                            !controller.model.value.data!.hasResources!
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12),
                                    child: controller
                                                .model.value.data!.hasPersons ==
                                            true
                                        ? const Text(
                                            'Resources Type',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppTheme.textColorDarkBLue),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                            !controller.model.value.data!.hasResources!
                                ? const SizedBox.shrink()
                                : Container(
                                    margin: const EdgeInsets.only(left: 16),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.grey),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                          value: controller.resourcesValue.value
                                              .toString(),
                                          items: controller.resourcesList
                                              .map((String person) {
                                            return DropdownMenuItem(
                                              value: person,
                                              child: Container(
                                                  width: screenSize.width * .84,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    person,
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  )),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              controller.resourcesValue.value =
                                                  value.toString();
                                            });
                                          }),
                                    ),
                                  ),
                            !controller.model.value.data!.hasResources!
                                ? const SizedBox.shrink()
                                : addHeight(20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: CommonButton(
                                  buttonHeight: 6.5,
                                  buttonWidth: 100,
                                  text: 'CONFIRM',
                                  onTap: () {
                                    debugPrint(
                                        ":::::::::yearSlug:::=>$yearSlug");
                                    debugPrint(
                                        ":::::::::monthSlug:::=>$monthSlug");
                                    debugPrint(":::::::::daySlug:::=>$daySlug");
                                    debugPrint(
                                        ":::::::::timeSlug:::=>$selectedtim");
                                    debugPrint(
                                        ":::::::::selectedChild:::=>$selectedChild");
                                    debugPrint(
                                        ":::::::::selectedAdult:::=>$selectedAdult");
                                    debugPrint(
                                        ":::::::::startTimeSlug:::=>$startTimeSlug");
                                    debugPrint(
                                        ":::::::::endTimeSlug:::=>${controller.dropdownEndTimeValue}");

                                    if (controller.model.value.data!
                                                .durationType ==
                                            'fixed' &&
                                        selectedtim == null) {
                                      getAlertDialog('Add Cart',
                                          'Please check your time slot.\nMight be you don\'t have time slot for selected date',
                                          () {
                                        Get.back();
                                      });
                                    } else {
                                      getBookableAddToCartData(
                                              context,
                                              Get.arguments[0].toString(),
                                              1,
                                              yearSlug.toString(),
                                              monthSlug.toString(),
                                              daySlug.toString(),
                                              selectedtim.toString(),
                                              controller.model.value.data!
                                                      .personTypeData!.isEmpty
                                                  ? '0'
                                                  : controller.model.value.data!
                                                      .personTypeData![0].id
                                                      .toString(),
                                              selectedChild.toString(),
                                              controller.model.value.data!
                                                      .personTypeData!.isEmpty
                                                  ? '0'
                                                  : controller.model.value.data!
                                                      .personTypeData![1].id
                                                      .toString(),
                                              selectedAdult.toString(),
                                              startTimeSlug.toString(),
                                              controller.dropdownEndTimeValue
                                                  .toString(),
                                              controller.resourcesValue.value)
                                          .then((value) {
                                        if (value.status) {
                                          final bottomNavController =
                                              Get.put(BottomNavController());
                                          bottomNavController.getData();
                                          showToast(value.message);
                                          Get.offAllNamed(
                                              MyRouter.customBottomBar);
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: value.message, // message
                                            toastLength:
                                                Toast.LENGTH_SHORT, // length
                                            gravity:
                                                ToastGravity.CENTER, // location
                                          );
                                        }
                                      });
                                    }
                                  },
                                  mainGradient: AppTheme.primaryGradientColor),
                            ),
                            addHeight(16.0),
                          ],
                        ),
                      ),
                    ],
                  );
          }),
        ),
      ),
    );
  }

  Widget personData(List<PersonTypeData> personTypeData, int index) {
    if (selectedChild == null){
      selectedChild = personTypeData[0].value[0];
    }
    if (selectedAdult == null && personTypeData.length >= 2){
      selectedAdult =  personTypeData[1].value[0];
    }

    return Container(
      margin: index == 0
          ? const EdgeInsets.only(right: 16)
          : const EdgeInsets.only(right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            personTypeData[index].name.toString(),
            style: const TextStyle(color: Colors.grey),
          ),
          addHeight(4),
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  value: personTypeData[index].name == personTypeData[0].name
                      ? selectedChild
                      : selectedAdult,
                  items: personTypeData[index].value.map((String person) {
                    return DropdownMenuItem(
                      value: person,
                      child: Container(
                          width: 120,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            person,
                            style: const TextStyle(fontSize: 18),
                          )),
                    );
                  }).toList(),
                  onChanged: (String? newvalue) {
                    setState(() {
                      if (personTypeData[index].name ==
                          personTypeData[0].name) {
                        selectedChild = newvalue;
                      } else {
                        selectedAdult = newvalue;
                      }
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget timeSlot(
    List<TimeSlots> mList,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedtime = index;
          selectedtim = mList[index].time.toString();
        });
      },
      child: Container(
          decoration: BoxDecoration(
            color: selectedtim == null || selectedtime != index
                ? Colors.grey.shade200
                : Colors.red,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
          child: Center(
              child: Text(
            mList[index].time!,
            style: TextStyle(
                color: selectedtim == null || selectedtime != index
                    ? AppTheme.textColorDarkBLue
                    : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ))),
    );
  }
}
