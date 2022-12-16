import 'package:dinelah/controller/CategoryController.dart';
import 'package:dinelah/controller/SearchController.dart';
import 'package:dinelah/models/ModelHomeData.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/screens/item/ItemProduct.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_assets.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  CategoryScreenState createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  final scrollController = ScrollController();
  List<Categories>? categories;
  final _categoryController = Get.put(CategoryController());
  final searchController = TextEditingController();

  var tappedIndex;
  // int termId = Get.arguments[1];

  ScrollController scrollController1 = ScrollController();

  scrollListener() {
    scrollController1.addListener(() {
      if (scrollController1.position.maxScrollExtent ==
          scrollController1.position.pixels) {
        _categoryController.getMoreProducts(context).then((value) {
          setState(() {});
        });
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();

    _categoryController.onClose();
    searchController.clear();
  }

  @override
  void initState() {
    super.initState();
    _categoryController.categoryId = Get.arguments[1].toString();
    print(_categoryController.categoryId);
    scrollListener();

    categories = Get.arguments[0];
    _categoryController.getProduct();

    Future.delayed(const Duration(seconds: 1)).then((value) async {
      _animateToIndex(Get.arguments[2]);
    });
  }

  void _animateToIndex(int index) {
    scrollController.animateTo(
      index * 150.0,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double itemHeight = screenSize.height / 3.9;
    // final double itemWidth = screenSize.width / 2;
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xfff3f3f3),
          image: DecorationImage(
            image: AssetImage(
              AppAssets.dashboardBg,
            ),
            alignment: Alignment.topRight,
            fit: BoxFit.contain,
          ),
        ),
        child: Scaffold(
          appBar: backAppBar("Category"),
          //buildAppBar(false, 'Category', _scaffoldKey, 1),
          backgroundColor: Colors.transparent,
          body: Obx(() {
            return SizedBox(
              width: screenSize.width,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchView(context, () {
                      applySearch(context);
                    }, searchController),
                    addHeight(20),
                    SizedBox(
                      height: 48,
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: categories!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return categoryList(categories, index);
                          }),
                    ),
                    addHeight(20),
                    !_categoryController.isDataLoading.value
                        ? SizedBox(height: 200, child: loader(context))
                        : Expanded(
                            child: GridView.builder(
                                itemCount: _categoryController
                                    .model.value.data!.products.length,
                                controller: scrollController1,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12.0,
                                  mainAxisSpacing: 12.0,
                                  mainAxisExtent: 234,
                                  // childAspectRatio:
                                  // MediaQuery.of(context).size.width /
                                  //     (MediaQuery.of(context).size.height /
                                  //         1.76),
                                ),
                                itemBuilder: (context, index) {
                                  return ItemProduct(
                                      _categoryController,
                                      _categoryController
                                          .model.value.data!.products,
                                      index,
                                      itemHeight,
                                      false);
                                }),
                          ),
                    addHeight(10),
                    if (_categoryController.allLoaded.value)
                      const Center(
                          child: Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text("No More Products"),
                      ))
                  ],
                ),
              ),
            );
          }),
        ));
  }

  Widget categoryList(List<Categories>? categories, int index) {
    return InkWell(
      onTap: () {
        _animateToIndex(index);
        setState(() {
          tappedIndex = index;
          _categoryController.categoryId = categories![index].termId.toString();
          _categoryController.getProduct();
        });
      },
      child: Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: _categoryController.categoryId ==
                          categories![index].termId.toString() ||
                      tappedIndex == index
                  ? Colors.black
                  : AppTheme.colorWhite,
              borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: [
              Material(
                borderRadius: BorderRadius.circular(50),
                elevation: 3,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Image.network(
                      categories[0].imageUrl.toString(),
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: CircularProgressIndicator(
                              color: AppTheme.primaryColor,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              addWidth(8),
              Text(
                categories[index].name.toString(),
                style: TextStyle(
                    color: _categoryController.categoryId ==
                                categories[index].termId.toString() ||
                            tappedIndex == index
                        ? AppTheme.colorWhite
                        : AppTheme.textColorDarkBLue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )
            ],
          )),
    );
  }

  void applySearch(BuildContext context) {
    final controller = Get.put(SearchController());
    controller.context = context;
    if (searchController.text.isEmpty) {
      showToast('Please enter something to search');
    } else {
      Get.toNamed(MyRouter.searchProductScreen,
          arguments: [searchController.text]);
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
