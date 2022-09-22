class ModelCategoryData {
  ModelCategoryData({
    this.status,
    this.message,
    this.data,
  });
  var status;
  var message;
  var data;

  ModelCategoryData.fromJson(Map<String, dynamic> json){
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
    required this.parameters,
    required this.categories,
  });
  late final int count;
  late final Parameters parameters;
  late final List<Categories> categories;

  Data.fromJson(Map<String, dynamic> json){
    count = json['count'];
    parameters = Parameters.fromJson(json['parameters']);
    categories = List.from(json['categories']).map((e)=>Categories.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['parameters'] = parameters.toJson();
    _data['categories'] = categories.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Parameters {
  Parameters({
    required this.perPage,
    required this.page,
  });
  late final int perPage;
  late final int page;

  Parameters.fromJson(Map<String, dynamic> json){
    perPage = json['per_page'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['per_page'] = perPage;
    _data['page'] = page;
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