
import 'package:get/get.dart';

class ModelProduct {
  ModelProduct({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.dateCreated,
    required this.type,
    required this.description,
    required this.shortDescription,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.currencySymbol,
    required this.storeId,
    required this.storeName,
    required this.averageRating,
    required this.ratingCount,
    required this.manageStock,
    required this.stockStatus,
    required this.stockQuantity,
    required this.lowStockAmount,
    required this.isInWishlist,
    required this.onSale,
    required this.purchasable,
    required this.featured,
    required this.virtual,
    required this.downloadable,
    required this.categoryId,
    required this.categoryName,
    required this.categorySlug,
    required this.imageUrl,
    required this.attributeData,
  });
  dynamic id;
  dynamic name;
  dynamic slug;
  dynamic permalink;
  dynamic dateCreated;
  dynamic type;
  dynamic description;
  dynamic shortDescription;
  dynamic price;
  dynamic regularPrice;
  dynamic salePrice;
  dynamic currencySymbol;
  dynamic storeId;
  dynamic storeName;
  dynamic averageRating;
  dynamic ratingCount;
  dynamic manageStock;
  dynamic stockStatus;
  dynamic stockQuantity;
  dynamic lowStockAmount;
  RxBool isInWishlist = false.obs;
  dynamic onSale;
  dynamic purchasable;
  dynamic featured;
  dynamic virtual;
  dynamic downloadable;
  dynamic categoryId;
  dynamic categoryName;
  dynamic categorySlug;
  dynamic imageUrl;
  late final List<AttributeData> attributeData;

  ModelProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    permalink = json['permalink'];
    dateCreated = json['date_created'];
    type = json['type'];
    description = json['description'];
    shortDescription = json['short_description'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    currencySymbol = json['currency_symbol'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    manageStock = json['manage_stock'];
    stockStatus = json['stock_status'];
    stockQuantity = json['stock_quantity'];
    lowStockAmount = json['low_stock_amount'];
    isInWishlist.value = json['is_in_wishlist'];
    onSale = json['on_sale'];
    purchasable = json['purchasable'];
    featured = json['featured'];
    virtual = json['virtual'];
    downloadable = json['downloadable'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categorySlug = json['category_slug'];
    imageUrl = json['image_url'];
    attributeData = List.from(json['attribute_data'])
        .map((e) => AttributeData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['permalink'] = permalink;
    _data['date_created'] = dateCreated;
    _data['type'] = type;
    _data['description'] = description;
    _data['short_description'] = shortDescription;
    _data['price'] = price;
    _data['regular_price'] = regularPrice;
    _data['sale_price'] = salePrice;
    _data['currency_symbol'] = currencySymbol;
    _data['store_id'] = storeId;
    _data['store_name'] = storeName;
    _data['average_rating'] = averageRating;
    _data['rating_count'] = ratingCount;
    _data['manage_stock'] = manageStock;
    _data['stock_status'] = stockStatus;
    _data['stock_quantity'] = stockQuantity;
    _data['low_stock_amount'] = lowStockAmount;
    _data['is_in_wishlist'] = isInWishlist.value;
    _data['on_sale'] = onSale;
    _data['purchasable'] = purchasable;
    _data['featured'] = featured;
    _data['virtual'] = virtual;
    _data['downloadable'] = downloadable;
    _data['category_id'] = categoryId;
    _data['category_name'] = categoryName;
    _data['category_slug'] = categorySlug;
    _data['image_url'] = imageUrl;
    _data['attribute_data'] = attributeData.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AttributeData {
  AttributeData({
    required this.name,
    required this.items,
  });
  late final name;
  late final List<Items> items;

  AttributeData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['items'] = items.map((e) => e.toJson()).toList();
    return _data;
  }
}

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
    required this.isSelected,
  });
  late final dynamic termId;
  late final name;
  late final slug;
  late final termGroup;
  late final termTaxonomyId;
  late final taxonomy;
  late final description;
  late final parent;
  late final count;
  late final filter;
  late final isSelected;

  Items.fromJson(Map<String, dynamic> json) {
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
    isSelected = json['is_selected'];
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
    _data['is_selected'] = isSelected;
    return _data;
  }
}
