import 'package:dinelah/models/PopularProduct.dart';

class ModelHomeData {
  ModelHomeData({
    this.status,
    this.message,
    this.data,
  });
  bool? status;
  String? message;
  Data? data;

  ModelHomeData.fromJson(Map<String, dynamic> json){
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
    required this.slider,
    required this.category,
    required this.popularProducts,
  });
  late final Slider slider;
  late final Category category;
  late final List<ModelProduct> popularProducts;

  Data.fromJson(Map<String, dynamic> json){
    slider = Slider.fromJson(json['slider']);
    category = Category.fromJson(json['category']);
    popularProducts = List.from(json['popular_products']).map((e)=>ModelProduct.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['slider'] = slider.toJson();
    _data['category'] = category.toJson();
    _data['popular_products'] = popularProducts.map((e)=>e.toJson()).toList();
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
  late final bool isBanner;
  late final bool isSlider;
  late final bool sliderEnable;
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
  late final int productId;
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

class Category {
  Category({
    required this.enabled,
    required this.showCategory,
    required this.categories,
  });
  late final bool enabled;
  late final String showCategory;
  late final List<Categories> categories;

  Category.fromJson(Map<String, dynamic> json){
    enabled = json['enabled'];
    showCategory = json['show_category'];
    categories = List.from(json['categories']).map((e)=>Categories.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['enabled'] = enabled;
    _data['show_category'] = showCategory;
    _data['categories'] = categories.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Categories {
  Categories({
    required this.termId,
    required this.name,
    required this.slug,
    required this.imageUrl,
  });
  late final int termId;
  late final String name;
  late final String slug;
  late final String imageUrl;

  Categories.fromJson(Map<String, dynamic> json){
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['term_id'] = termId;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['image_url'] = imageUrl;
    return _data;
  }
}
