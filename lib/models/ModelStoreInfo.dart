import 'package:dinelah/models/PopularProduct.dart';

class ModelStoreInfoData {
  ModelStoreInfoData({
    this.status,
    this.message,
    this.data,
  });
  bool? status;
  String? message;
  Data? data;

  ModelStoreInfoData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.storeInfo,
    required this.slider,
    required this.storeProducts,
  });
  late final StoreInfo storeInfo;
  late final Slider slider;
  late final List<ModelProduct> storeProducts;

  Data.fromJson(Map<String, dynamic> json){
    storeInfo = StoreInfo.fromJson(json['store_info']);
    slider = Slider.fromJson(json['slider']);
    storeProducts = List.from(json['store_products']).map((e)=>ModelProduct.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['store_info'] = storeInfo.toJson();
    _data['slider'] = slider.toJson();
    _data['store_products'] = storeProducts.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class StoreInfo {
  StoreInfo({
    required this.id,
    required this.storeName,
    required this.banner,
    required this.categories,
    required this.rating,
    required this.storeOpenClose,
    required this.address,
  });
  late final int id;
  late final String storeName;
  late final String banner;
  late final List<Categories> categories;
  late final Rating rating;
  late final StoreOpenClose storeOpenClose;
  late final String address;

  StoreInfo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    storeName = json['store_name'];
    banner = json['banner'];
    categories = List.from(json['categories']).map((e)=>Categories.fromJson(e)).toList();
    rating = Rating.fromJson(json['rating']);
    storeOpenClose = StoreOpenClose.fromJson(json['store_open_close']);
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['store_name'] = storeName;
    _data['banner'] = banner;
    _data['categories'] = categories.map((e)=>e.toJson()).toList();
    _data['rating'] = rating.toJson();
    _data['store_open_close'] = storeOpenClose.toJson();
    _data['address'] = address;
    return _data;
  }
}

class Categories {
  Categories({
    required this.id,
    required this.name,
    required this.slug,
  });
  late final int id;
  late final String name;
  late final String slug;

  Categories.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    return _data;
  }
}

class Rating {
  Rating({
    required this.rating,
    required this.count,
  });
  dynamic rating;
  late final int count;

  Rating.fromJson(Map<String, dynamic> json){
    rating = json['rating'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rating'] = rating;
    _data['count'] = count;
    return _data;
  }
}

class StoreOpenClose {
  StoreOpenClose({
    required this.enabled,
    required this.time,
  });
  late final bool enabled;
  late final List<StoreTime> time;

  StoreOpenClose.fromJson(Map<String, dynamic> json){
    enabled = json['enabled'];
    time = List.from(json['time']).map((e)=>StoreTime.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['enabled'] = enabled;
    _data['time'] = time.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class StoreTime {
  StoreTime({
    required this.day,
    required this.status,
    required this.openingTime,
    required this.closingTime,
  });
  late final String day;
  late final String status;
  late final String openingTime;
  late final String closingTime;

  StoreTime.fromJson(Map<String, dynamic> json){
    day = json['day'];
    status = json['status'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['status'] = status;
    _data['opening_time'] = openingTime;
    _data['closing_time'] = closingTime;
    return _data;
  }
}

class Slider {
  Slider({
    required this.isBanner,
    required this.isSlider,
    required this.sliderEnable,
    required this.slides,
  });
  late final int isBanner;
  late final int isSlider;
  late final String sliderEnable;
  late final List<Slides> slides;

  Slider.fromJson(Map<String, dynamic> json){
    isBanner = json['is_banner'];
    isSlider = json['is_slider'];
    sliderEnable = json['slider_enable'];
    slides = List.from(json['slides']).map((e)=>Slides.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['is_banner'] = isBanner;
    _data['is_slider'] = isSlider;
    _data['slider_enable'] = sliderEnable;
    _data['slides'] = slides.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Slides {
  Slides({
    required this.url,
    required this.productId,
    required this.productCategory,
    required this.type,
  });
  late final String url;
  late final String productId;
  late final String productCategory;
  late final String type;

  Slides.fromJson(Map<String, dynamic> json){
    url = json['url'];
    productId = json['product_id'];
    productCategory = json['product_category'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['product_id'] = productId;
    _data['product_category'] = productCategory;
    _data['type'] = type;
    return _data;
  }
}

/*class AttributeData {
  AttributeData({
    required this.name,
    required this.items,
  });
  late final String name;
  late final List<Items> items;

  AttributeData.fromJson(Map<String, dynamic> json){
    name = json['name'];
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['items'] = items.map((e)=>e.toJson()).toList();
    return _data;
  }
}*/
/*

class Items {
  Items({
    required this.termId,
    required this.name,
    required this.slug,
    required this.termGroup,
    required this.termTaxonomyId,
    required this.taxonomy,
    required this.description,
    required this.parent,
    required this.count,
    required this.filter,
  });
  late final int termId;
  late final String name;
  late final String slug;
  late final int termGroup;
  late final int termTaxonomyId;
  late final String taxonomy;
  late final String description;
  late final int parent;
  late final int count;
  late final String filter;

  Items.fromJson(Map<String, dynamic> json){
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];
    parent = json['parent'];
    count = json['count'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['term_id'] = termId;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['term_group'] = termGroup;
    _data['term_taxonomy_id'] = termTaxonomyId;
    _data['taxonomy'] = taxonomy;
    _data['description'] = description;
    _data['parent'] = parent;
    _data['count'] = count;
    _data['filter'] = filter;
    return _data;
  }
}*/
