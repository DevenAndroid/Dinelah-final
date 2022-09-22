class ModelGetAttributeData {
  ModelGetAttributeData({
    required this.status,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String message;
  late final List<Data> data;

  ModelGetAttributeData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.name,
    required this.items,
  });
  late final String name;
  late final List<Items> items;

  Data.fromJson(Map<String, dynamic> json){
    name = json['name'];
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['items'] = items.map((e)=>e.toJson()).toList();
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
}