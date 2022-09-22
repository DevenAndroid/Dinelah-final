class ModelGetProductVariationData {
  final bool? status;
  final String? message;
  final Data? data;

  ModelGetProductVariationData({
    this.status,
    this.message,
    this.data,
  });

  ModelGetProductVariationData.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'status' : status,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data {
  final bool? hasVariations;
  final List<Variations>? variations;

  Data({
    this.hasVariations,
    this.variations,
  });

  Data.fromJson(Map<String, dynamic> json)
      : hasVariations = json['has_variations'] as bool?,
        variations = (json['variations'] as List?)?.map((dynamic e) => Variations.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'has_variations' : hasVariations,
    'variations' : variations?.map((e) => e.toJson()).toList()
  };
}

class Variations {
  final Attributes? attributes;
  final bool? backordersAllowed;
  final int? displayPrice;
  final bool? isDownloadable;
  final bool? isInStock;
  final bool? isPurchasable;
  final String? isSoldIndividually;
  final bool? isVirtual;
  final String? maxQty;
  final int? minQty;
  final int? variationId;
  final bool? variationIsActive;
  final bool? variationIsVisible;
  final String? variationDescription;
  final String? cashbackAmount;
  final String? enableWholesale;
  final String? wholesalePrice;
  final String? wholesaleQuantity;

  Variations({
    this.attributes,
    this.backordersAllowed,
    this.displayPrice,
    this.isDownloadable,
    this.isInStock,
    this.isPurchasable,
    this.isSoldIndividually,
    this.isVirtual,
    this.maxQty,
    this.minQty,
    this.variationId,
    this.variationIsActive,
    this.variationIsVisible,
    this.variationDescription,
    this.cashbackAmount,
    this.enableWholesale,
    this.wholesalePrice,
    this.wholesaleQuantity,
  });

  Variations.fromJson(Map<String, dynamic> json)
      : attributes = (json['attributes'] as Map<String,dynamic>?) != null ? Attributes.fromJson(json['attributes'] as Map<String,dynamic>) : null,
        backordersAllowed = json['backorders_allowed'] as bool?,
        displayPrice = json['display_price'] as int?,
        isDownloadable = json['is_downloadable'] as bool?,
        isInStock = json['is_in_stock'] as bool?,
        isPurchasable = json['is_purchasable'] as bool?,
        isSoldIndividually = json['is_sold_individually'] as String?,
        isVirtual = json['is_virtual'] as bool?,
        maxQty = json['max_qty'] as String?,
        minQty = json['min_qty'] as int?,
        variationId = json['variation_id'] as int?,
        variationIsActive = json['variation_is_active'] as bool?,
        variationIsVisible = json['variation_is_visible'] as bool?,
        variationDescription = json['variation_description'] as String?,
        cashbackAmount = json['cashback_amount'] as String?,
        enableWholesale = json['enable_wholesale'] as String?,
        wholesalePrice = json['wholesale_price'] as String?,
        wholesaleQuantity = json['wholesale_quantity'] as String?;

  Map<String, dynamic> toJson() => {
    'attributes' : attributes?.toJson(),
    'backorders_allowed' : backordersAllowed,
    'display_price' : displayPrice,
    'is_downloadable' : isDownloadable,
    'is_in_stock' : isInStock,
    'is_purchasable' : isPurchasable,
    'is_sold_individually' : isSoldIndividually,
    'is_virtual' : isVirtual,
    'max_qty' : maxQty,
    'min_qty' : minQty,
    'variation_id' : variationId,
    'variation_is_active' : variationIsActive,
    'variation_is_visible' : variationIsVisible,
    'variation_description' : variationDescription,
    'cashback_amount' : cashbackAmount,
    'enable_wholesale' : enableWholesale,
    'wholesale_price' : wholesalePrice,
    'wholesale_quantity' : wholesaleQuantity
  };
}

class Attributes {
  final String? attributePaSize;

  Attributes({
    this.attributePaSize,
  });

  Attributes.fromJson(Map<String, dynamic> json)
      : attributePaSize = json['attribute_pa_size'] as String?;

  Map<String, dynamic> toJson() => {
    'attribute_pa_size' : attributePaSize
  };
}