class ModelUpdateCart {
  ModelUpdateCart({
    required this.status,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String message;
  late final Data data;

  ModelUpdateCart.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.count,
    required this.cartmeta,
    required this.items,
  });
  late final int count;
  late final Cartmeta cartmeta;
  late final List<Items> items;

  Data.fromJson(Map<String, dynamic> json){
    count = json['count'];
    cartmeta = Cartmeta.fromJson(json['cartmeta']);
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['cartmeta'] = cartmeta.toJson();
    _data['items'] = items.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Cartmeta {
  Cartmeta({
    required this.subtotal,
    required this.subtotalTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.shippingTaxes,
    required this.discountTotal,
    required this.discountTax,
    required this.cartContentsTotal,
    required this.cartContentsTax,
    required this.cartContentsTaxes,
    required this.feeTotal,
    required this.feeTax,
    required this.feeTaxes,
    required this.total,
    required this.totalTax,
    required this.currencySymbol,
  });
  late final String subtotal;
  late final int subtotalTax;
  late final String shippingTotal;
  late final int shippingTax;
  late final List<dynamic> shippingTaxes;
  late final int discountTotal;
  late final int discountTax;
  late final String cartContentsTotal;
  late final int cartContentsTax;
  late final List<dynamic> cartContentsTaxes;
  late final String feeTotal;
  late final int feeTax;
  late final List<dynamic> feeTaxes;
  late final String total;
  late final int totalTax;
  late final String currencySymbol;

  Cartmeta.fromJson(Map<String, dynamic> json){
    subtotal = json['subtotal'];
    subtotalTax = json['subtotal_tax'];
    shippingTotal = json['shipping_total'];
    shippingTax = json['shipping_tax'];
    shippingTaxes = List.castFrom<dynamic, dynamic>(json['shipping_taxes']);
    discountTotal = json['discount_total'];
    discountTax = json['discount_tax'];
    cartContentsTotal = json['cart_contents_total'];
    cartContentsTax = json['cart_contents_tax'];
    cartContentsTaxes = List.castFrom<dynamic, dynamic>(json['cart_contents_taxes']);
    feeTotal = json['fee_total'];
    feeTax = json['fee_tax'];
    feeTaxes = List.castFrom<dynamic, dynamic>(json['fee_taxes']);
    total = json['total'];
    totalTax = json['total_tax'];
    currencySymbol = json['currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subtotal'] = subtotal;
    _data['subtotal_tax'] = subtotalTax;
    _data['shipping_total'] = shippingTotal;
    _data['shipping_tax'] = shippingTax;
    _data['shipping_taxes'] = shippingTaxes;
    _data['discount_total'] = discountTotal;
    _data['discount_tax'] = discountTax;
    _data['cart_contents_total'] = cartContentsTotal;
    _data['cart_contents_tax'] = cartContentsTax;
    _data['cart_contents_taxes'] = cartContentsTaxes;
    _data['fee_total'] = feeTotal;
    _data['fee_tax'] = feeTax;
    _data['fee_taxes'] = feeTaxes;
    _data['total'] = total;
    _data['total_tax'] = totalTax;
    _data['currency_symbol'] = currencySymbol;
    return _data;
  }
}

class Items {
  Items({
    required this.product,
    required this.quantity,
    this.variation,
    this.addons,
  });
  late final Product product;
  late final int quantity;
  late final Null variation;
  late final Null addons;

  Items.fromJson(Map<String, dynamic> json){
    product = Product.fromJson(json['product']);
    quantity = json['quantity'];
    variation = null;
    addons = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product'] = product.toJson();
    _data['quantity'] = quantity;
    _data['variation'] = variation;
    _data['addons'] = addons;
    return _data;
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.type,
    required this.status,
    required this.featured,
    required this.catalogVisibility,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
    required this.onSale,
    required this.purchasable,
    required this.totalSales,
    required this.virtual,
    required this.downloadable,
    required this.downloads,
    required this.downloadLimit,
    required this.downloadExpiry,
    required this.externalUrl,
    required this.buttonText,
    required this.taxStatus,
    required this.taxClass,
    required this.manageStock,
    this.stockQuantity,
    required this.backorders,
    required this.backordersAllowed,
    required this.backordered,
    this.lowStockAmount,
    required this.soldIndividually,
    required this.weight,
    required this.shippingRequired,
    required this.shippingTaxable,
    required this.shippingClass,
    required this.shippingClassId,
    required this.reviewsAllowed,
    required this.averageRating,
    required this.ratingCount,
    required this.upsellIds,
    required this.crossSellIds,
    required this.parentId,
    required this.purchaseNote,
    required this.attributes,
    required this.defaultAttributes,
    required this.variations,
    required this.groupedProducts,
    required this.menuOrder,
    required this.stockStatus,
    required this.currencySymbol,
    required this.currency,
    required this.imageUrl,
  });
  late final int id;
  late final String name;
  late final String slug;
  late final String permalink;
  late final String dateCreated;
  late final String dateCreatedGmt;
  late final String dateModified;
  late final String dateModifiedGmt;
  late final String type;
  late final String status;
  late final bool featured;
  late final String catalogVisibility;
  late final String description;
  late final String shortDescription;
  late final String sku;
  late final String price;
  late final String regularPrice;
  late final String salePrice;
  late final Null dateOnSaleFrom;
  late final Null dateOnSaleFromGmt;
  late final Null dateOnSaleTo;
  late final Null dateOnSaleToGmt;
  late final bool onSale;
  late final bool purchasable;
  late final int totalSales;
  late final bool virtual;
  late final bool downloadable;
  late final List<dynamic> downloads;
  late final int downloadLimit;
  late final int downloadExpiry;
  late final String externalUrl;
  late final String buttonText;
  late final String taxStatus;
  late final String taxClass;
  late final bool manageStock;
  late final Null stockQuantity;
  late final String backorders;
  late final bool backordersAllowed;
  late final bool backordered;
  late final Null lowStockAmount;
  late final bool soldIndividually;
  late final String weight;
  late final bool shippingRequired;
  late final bool shippingTaxable;
  late final String shippingClass;
  late final int shippingClassId;
  late final bool reviewsAllowed;
  late final String averageRating;
  late final int ratingCount;
  late final List<dynamic> upsellIds;
  late final List<dynamic> crossSellIds;
  late final int parentId;
  late final String purchaseNote;
  late final List<dynamic> attributes;
  late final List<dynamic> defaultAttributes;
  late final List<dynamic> variations;
  late final List<dynamic> groupedProducts;
  late final int menuOrder;
  late final String stockStatus;
  late final String currencySymbol;
  late final String currency;
  late final String imageUrl;

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    permalink = json['permalink'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    type = json['type'];
    status = json['status'];
    featured = json['featured'];
    catalogVisibility = json['catalog_visibility'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    dateOnSaleFrom = null;
    dateOnSaleFromGmt = null;
    dateOnSaleTo = null;
    dateOnSaleToGmt = null;
    onSale = json['on_sale'];
    purchasable = json['purchasable'];
    totalSales = json['total_sales'];
    virtual = json['virtual'];
    downloadable = json['downloadable'];
    downloads = List.castFrom<dynamic, dynamic>(json['downloads']);
    downloadLimit = json['download_limit'];
    downloadExpiry = json['download_expiry'];
    externalUrl = json['external_url'];
    buttonText = json['button_text'];
    taxStatus = json['tax_status'];
    taxClass = json['tax_class'];
    manageStock = json['manage_stock'];
    stockQuantity = null;
    backorders = json['backorders'];
    backordersAllowed = json['backorders_allowed'];
    backordered = json['backordered'];
    lowStockAmount = null;
    soldIndividually = json['sold_individually'];
    weight = json['weight'];
    shippingRequired = json['shipping_required'];
    shippingTaxable = json['shipping_taxable'];
    shippingClass = json['shipping_class'];
    shippingClassId = json['shipping_class_id'];
    reviewsAllowed = json['reviews_allowed'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    upsellIds = List.castFrom<dynamic, dynamic>(json['upsell_ids']);
    crossSellIds = List.castFrom<dynamic, dynamic>(json['cross_sell_ids']);
    parentId = json['parent_id'];
    purchaseNote = json['purchase_note'];
    attributes = List.castFrom<dynamic, dynamic>(json['attributes']);
    defaultAttributes = List.castFrom<dynamic, dynamic>(json['default_attributes']);
    variations = List.castFrom<dynamic, dynamic>(json['variations']);
    groupedProducts = List.castFrom<dynamic, dynamic>(json['grouped_products']);
    menuOrder = json['menu_order'];
    stockStatus = json['stock_status'];
    currencySymbol = json['currency_symbol'];
    currency = json['currency'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['permalink'] = permalink;
    _data['date_created'] = dateCreated;
    _data['date_created_gmt'] = dateCreatedGmt;
    _data['date_modified'] = dateModified;
    _data['date_modified_gmt'] = dateModifiedGmt;
    _data['type'] = type;
    _data['status'] = status;
    _data['featured'] = featured;
    _data['catalog_visibility'] = catalogVisibility;
    _data['description'] = description;
    _data['short_description'] = shortDescription;
    _data['sku'] = sku;
    _data['price'] = price;
    _data['regular_price'] = regularPrice;
    _data['sale_price'] = salePrice;
    _data['date_on_sale_from'] = dateOnSaleFrom;
    _data['date_on_sale_from_gmt'] = dateOnSaleFromGmt;
    _data['date_on_sale_to'] = dateOnSaleTo;
    _data['date_on_sale_to_gmt'] = dateOnSaleToGmt;
    _data['on_sale'] = onSale;
    _data['purchasable'] = purchasable;
    _data['total_sales'] = totalSales;
    _data['virtual'] = virtual;
    _data['downloadable'] = downloadable;
    _data['downloads'] = downloads;
    _data['download_limit'] = downloadLimit;
    _data['download_expiry'] = downloadExpiry;
    _data['external_url'] = externalUrl;
    _data['button_text'] = buttonText;
    _data['tax_status'] = taxStatus;
    _data['tax_class'] = taxClass;
    _data['manage_stock'] = manageStock;
    _data['stock_quantity'] = stockQuantity;
    _data['backorders'] = backorders;
    _data['backorders_allowed'] = backordersAllowed;
    _data['backordered'] = backordered;
    _data['low_stock_amount'] = lowStockAmount;
    _data['sold_individually'] = soldIndividually;
    _data['weight'] = weight;
    _data['shipping_required'] = shippingRequired;
    _data['shipping_taxable'] = shippingTaxable;
    _data['shipping_class'] = shippingClass;
    _data['shipping_class_id'] = shippingClassId;
    _data['reviews_allowed'] = reviewsAllowed;
    _data['average_rating'] = averageRating;
    _data['rating_count'] = ratingCount;
    _data['upsell_ids'] = upsellIds;
    _data['cross_sell_ids'] = crossSellIds;
    _data['parent_id'] = parentId;
    _data['purchase_note'] = purchaseNote;
    _data['attributes'] = attributes;
    _data['default_attributes'] = defaultAttributes;
    _data['variations'] = variations;
    _data['grouped_products'] = groupedProducts;
    _data['menu_order'] = menuOrder;
    _data['stock_status'] = stockStatus;
    _data['currency_symbol'] = currencySymbol;
    _data['currency'] = currency;
    _data['image_url'] = imageUrl;
    return _data;
  }
}