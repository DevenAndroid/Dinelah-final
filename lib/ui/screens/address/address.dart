import 'package:dinelah/ui/screens/address/billing_addressScreen.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:flutter/material.dart';
import '../../../res/app_assets.dart';
import '../../../res/theme/theme.dart';
import 'shipping_addressScreen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen>
    with SingleTickerProviderStateMixin {
  //late Future<ModelSingleOrderData> futureAlbum;
  late TabController tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final AddressController _addressController = Get.put(AddressController());

  @override
  void initState() {
    // TODO: implement initState

    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xfffff8f9),
        image: DecorationImage(
          image: AssetImage(AppAssets.hostBgShape,
          ),
          alignment: Alignment.topRight,
          fit: BoxFit.contain,
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: backAppBar('Address'),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0)
                ),
                child: TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
                  tabs: const [
                    Tab(
                      child: Text('Billing Address',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Tab(
                      child: Text('Shipping Address',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                    )
                  ],
                  labelStyle: const TextStyle(fontSize: 18.0, color: Colors.white),
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 18.0, color: Colors.black),
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppTheme.primaryColor,
                  ),),
              ),
              addHeight(8),
              Expanded(
                child: TabBarView(
                  children: const [
                    BillingAddress(),
                    ShippingAddress(),
                  ],
                  controller: tabController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}














