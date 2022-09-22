class ModelVendorStores {
  ModelVendorStores({
    this.status,
    this.message,
    this.data,
  });
  dynamic status;
  dynamic message;
  Data? data;

  ModelVendorStores.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final dataJson = <String, dynamic>{};
    dataJson['status'] = status;
    dataJson['message'] = message;
    dataJson['data'] = data!.toJson();
    return dataJson;
  }
}

class Data {
  Data({
    required this.slider,
    required this.count,
    required this.parameters,
    required this.page,
    required this.perPage,
    required this.stores,
  });
  late final Slider slider;
  late final int count;
  late final Parameters parameters;
  late final int page;
  late final int perPage;
  late final List<ModelStores> stores;

  Data.fromJson(Map<String, dynamic> json) {
    slider = Slider.fromJson(json['slider']);
    count = json['count'];
    parameters = Parameters.fromJson(json['parameters']);
    page = json['page'];
    perPage = json['per_page'];
    stores = List.from(json['stores']).map((e) => ModelStores.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['slider'] = slider.toJson();
    data['count'] = count;
    data['parameters'] = parameters.toJson();
    data['page'] = page;
    data['per_page'] = perPage;
    data['stores'] = stores.map((e) => e.toJson()).toList();
    return data;
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

  Slider.fromJson(Map<String, dynamic> json) {
    isBanner = json['is_banner'];
    isSlider = json['is_slider'];
    sliderEnable = json['slider_enable'];
    slides = List.from(json['slides']).map((e) => Slides.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['is_banner'] = isBanner;
    data['is_slider'] = isSlider;
    data['slider_enable'] = sliderEnable;
    data['slides'] = slides.map((e) => e.toJson()).toList();
    return data;
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

  Slides.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    productId = json['product_id'];
    productCategory = json['product_category'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['product_id'] = productId;
    data['product_category'] = productCategory;
    data['type'] = type;
    return data;
  }
}

class Parameters {
  Parameters({
    required this.perPage,
    // required this.page,
  });
  late final int perPage;
  // late final int page;

  Parameters.fromJson(Map<String, dynamic> json) {
    perPage = json['per_page'];
    // page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['per_page'] = perPage;
    // data['page'] = page;
    return data;
  }
}

class ModelStores {
  ModelStores({
    required this.id,
    required this.storeName,
    required this.firstName,
    required this.storePhone,
    required this.lastName,
    this.social,
    required this.showEmail,
    required this.address,
    required this.location,
    required this.banner,
    required this.bannerId,
    required this.gravatar,
    required this.gravatarId,
    required this.shopUrl,
    required this.productsPerPage,
    required this.showMoreProductTab,
    required this.tocEnabled,
    required this.storeToc,
    required this.featured,
    required this.rating,
    required this.enabled,
    required this.registered,
    required this.payment,
    required this.trusted,
    required this.categories,
    required this.storeOpenClose,
    required this.links,
  });
  late final int id;
  late final String storeName;
  late final String storePhone;
  late final String firstName;
  late final String lastName;
  late final Social? social;
  late final bool showEmail;
  late final String address;
  late final String location;
  late final String banner;
  late final int bannerId;
  late final String gravatar;
  late final int gravatarId;
  late final String shopUrl;
  late final int productsPerPage;
  late final bool showMoreProductTab;
  late final bool tocEnabled;
  late final String storeToc;
  late final bool featured;
  late final Rating rating;
  late final bool enabled;
  late final String registered;
  late final String payment;
  late final bool trusted;
  late final List<Categories> categories;
  late final StoreOpenClose storeOpenClose;
  late final Links links;

  ModelStores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    firstName = json['first_name'];
    storePhone = json['store_phone'];
    lastName = json['last_name'];
    social = null;
    showEmail = json['show_email'];
    address = json['address'] ?? '';
    location = json['location'];
    banner = json['banner'];
    bannerId = json['banner_id'];
    gravatar = json['gravatar'];
    gravatarId = json['gravatar_id'];
    shopUrl = json['shop_url'];
    productsPerPage = json['products_per_page'];
    showMoreProductTab = json['show_more_product_tab'];
    tocEnabled = json['toc_enabled'];
    storeToc = json['store_toc'];
    featured = json['featured'];
    rating = Rating.fromJson(json['rating']);
    enabled = json['enabled'];
    registered = json['registered'];
    payment = json['payment'];
    trusted = json['trusted'];
    categories = List.from(json['categories'])
        .map((e) => Categories.fromJson(e))
        .toList();
    storeOpenClose = StoreOpenClose.fromJson(json['store_open_close']);
    links = Links.fromJson(json['links']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['store_name'] = storeName;
    data['first_name'] = firstName;
    data['store_phone'] = storePhone;
    data['last_name'] = lastName;
    data['social'] = social;
    data['show_email'] = showEmail;
    data['address'] = address;
    data['location'] = location;
    data['banner'] = banner;
    data['banner_id'] = bannerId;
    data['gravatar'] = gravatar;
    data['gravatar_id'] = gravatarId;
    data['shop_url'] = shopUrl;
    data['products_per_page'] = productsPerPage;
    data['show_more_product_tab'] = showMoreProductTab;
    data['toc_enabled'] = tocEnabled;
    data['store_toc'] = storeToc;
    data['featured'] = featured;
    data['rating'] = rating.toJson();
    data['enabled'] = enabled;
    data['registered'] = registered;
    data['payment'] = payment;
    data['trusted'] = trusted;
    data['categories'] = categories.map((e) => e.toJson()).toList();
    data['store_open_close'] = storeOpenClose.toJson();
    data['links'] = links.toJson();
    return data;
  }
}

class Social {
  Social({
    required this.fb,
    required this.twitter,
    required this.pinterest,
    required this.linkedin,
    required this.youtube,
    required this.instagram,
    required this.flickr,
  });
  late final String fb;
  late final String twitter;
  late final String pinterest;
  late final String linkedin;
  late final String youtube;
  late final String instagram;
  late final String flickr;

  Social.fromJson(Map<String, dynamic> json) {
    fb = json['fb'];
    twitter = json['twitter'];
    pinterest = json['pinterest'];
    linkedin = json['linkedin'];
    youtube = json['youtube'];
    instagram = json['instagram'];
    flickr = json['flickr'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fb'] = fb;
    data['twitter'] = twitter;
    data['pinterest'] = pinterest;
    data['linkedin'] = linkedin;
    data['youtube'] = youtube;
    data['instagram'] = instagram;
    data['flickr'] = flickr;
    return data;
  }
}

class Rating {
  Rating({
    required this.rating,
    required this.count,
  });
  dynamic rating;
  late final int count;

  Rating.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['rating'] = rating;
    data['count'] = count;
    return data;
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

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}

class StoreOpenClose {
  StoreOpenClose({
    required this.enabled,
    required this.time,
  });
  late final bool enabled;
  late final List<Time> time;

  StoreOpenClose.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    time = List.from(json['time']).map((e) => Time.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['enabled'] = enabled;
    data['time'] = time.map((e) => e.toJson()).toList();
    return data;
  }
}

class Time {
  Time({
    required this.day,
    required this.status,
    required this.openingTime,
    required this.closingTime,
  });
  late final String day;
  late final String status;
  late final String openingTime;
  late final String closingTime;

  Time.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    status = json['status'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['status'] = status;
    data['opening_time'] = openingTime;
    data['closing_time'] = closingTime;
    return data;
  }
}

class Links {
  Links({
    required this.self,
    required this.collection,
  });
  late final List<Self> self;
  late final List<Collection> collection;

  Links.fromJson(Map<String, dynamic> json) {
    self = List.from(json['self']).map((e) => Self.fromJson(e)).toList();
    collection = List.from(json['collection'])
        .map((e) => Collection.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['self'] = self.map((e) => e.toJson()).toList();
    data['collection'] = collection.map((e) => e.toJson()).toList();
    return data;
  }
}

class Self {
  Self({
    required this.href,
  });
  late final String href;

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

class Collection {
  Collection({
    required this.href,
  });
  late final String href;

  Collection.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}
