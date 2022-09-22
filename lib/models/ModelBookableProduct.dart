class ModelBookableProductData {
  bool? status;
  String? message;
  Data? data;

  ModelBookableProductData({this.status, this.message, this.data});

  ModelBookableProductData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? productName;
  String? image;
  String? type;
  bool? hasPersons;
  int? maxPersons;
  int? minPersons;
  bool? hasPersonTypes;
  bool? hasPersonCostMultiplier;
  bool? hasPersonQtyMultiplier;
  bool? hasResources;
  List<PersonTypeData>? personTypeData;
  String? durationType;
  String? durationUnit;
  int? minDuration;
  int? maxDuration;
  int? bufferPeriod;
  MaxDate? maxDate;
  MaxDate? minDate;
  String? firstBlockTime;
  String? calendarDisplayMode;
  String? description;
  String? shortDescription;
  String? price;
  String? currencySymbol;
  Store? store;
  bool? onSale;
  String? averageRating;
  int? ratingCount;
  List<AvailableDates>? availableDates;
  List<ResourceList>? resourceList;

  Data(
      {this.id,
      this.productName,
      this.image,
      this.type,
      this.hasPersons,
      this.maxPersons,
      this.minPersons,
      this.hasPersonTypes,
      this.hasPersonCostMultiplier,
      this.hasPersonQtyMultiplier,
      this.hasResources,
      this.personTypeData,
      this.durationType,
      this.durationUnit,
      this.minDuration,
      this.maxDuration,
      this.bufferPeriod,
      this.maxDate,
      this.minDate,
      this.firstBlockTime,
      this.calendarDisplayMode,
      this.description,
      this.shortDescription,
      this.price,
      this.currencySymbol,
      this.store,
      this.onSale,
      this.averageRating,
      this.ratingCount,
      this.availableDates,
      this.resourceList});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    image = json['image'];
    type = json['type'];
    hasPersons = json['has_persons'];
    maxPersons = json['max_persons'];
    minPersons = json['min_persons'];
    hasResources = json['has_resources'];
    hasPersonTypes = json['has_person_types'];
    hasPersonCostMultiplier = json['has_person_cost_multiplier'];
    hasPersonQtyMultiplier = json['has_person_qty_multiplier'];
    if (json['person_type_data'] != null) {
      personTypeData = <PersonTypeData>[];
      json['person_type_data'].forEach((v) {
        personTypeData!.add(PersonTypeData.fromJson(v));
      });
    }
    durationType = json['duration_type'];
    durationUnit = json['duration_unit'];
    minDuration = json['min_duration'];
    maxDuration = json['max_duration'];
    bufferPeriod = json['buffer_period'];
    maxDate =
        json['max_date'] != null ? MaxDate.fromJson(json['max_date']) : null;
    minDate =
        json['min_date'] != null ? MaxDate.fromJson(json['min_date']) : null;
    firstBlockTime = json['first_block_time'];
    calendarDisplayMode = json['calendar_display_mode'];
    description = json['description'];
    shortDescription = json['short_description'];
    price = json['price'];
    currencySymbol = json['currency_symbol'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    onSale = json['on_sale'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    if (json['available_dates'] != null) {
      availableDates = <AvailableDates>[];
      json['available_dates'].forEach((v) {
        availableDates!.add(AvailableDates.fromJson(v));
      });
    }
    if (json['resource_list'] != null) {
      resourceList = <ResourceList>[];
      json['resource_list'].forEach((v) {
        resourceList!.add(ResourceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    data['image'] = image;
    data['type'] = type;
    data['has_persons'] = hasPersons;
    data['max_persons'] = maxPersons;
    data['min_persons'] = minPersons;
    data['has_person_types'] = hasPersonTypes;
    data['has_resources'] = hasResources;
    data['has_person_cost_multiplier'] = hasPersonCostMultiplier;
    data['has_person_qty_multiplier'] = hasPersonQtyMultiplier;
    if (personTypeData != null) {
      data['person_type_data'] =
          personTypeData!.map((v) => v.toJson()).toList();
    }
    data['duration_type'] = durationType;
    data['duration_unit'] = durationUnit;
    data['min_duration'] = minDuration;
    data['max_duration'] = maxDuration;
    data['buffer_period'] = bufferPeriod;
    if (maxDate != null) {
      data['max_date'] = maxDate!.toJson();
    }
    if (minDate != null) {
      data['min_date'] = minDate!.toJson();
    }
    data['first_block_time'] = firstBlockTime;
    data['calendar_display_mode'] = calendarDisplayMode;
    data['description'] = description;
    data['short_description'] = shortDescription;
    data['price'] = price;
    data['currency_symbol'] = currencySymbol;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    data['on_sale'] = onSale;
    data['average_rating'] = averageRating;
    data['rating_count'] = ratingCount;
    if (availableDates != null) {
      data['available_dates'] = availableDates!.map((v) => v.toJson()).toList();
    }
    if (resourceList != null) {
      data['resource_list'] = resourceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PersonTypeData {
  int? id;
  String? name;
  String? min;
  String? max;
  late final List<String> value;

  PersonTypeData({this.id, this.name, this.min, this.max});

  PersonTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    min = json['min'];
    max = json['max'];
    value = List.castFrom<dynamic, String>(json['value']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['min'] = min;
    _data['max'] = max;
    _data['value'] = value;
    return _data;
  }
}

class MaxDate {
  int? value;
  String? unit;

  MaxDate({this.value, this.unit});

  MaxDate.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['unit'] = unit;
    return data;
  }
}

class Store {
  int? id;
  String? name;

  Store({this.id, this.name});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class AvailableDates {
  String? date;
  bool? isAvailable;
  String? message;
  List<TimeSlots>? timeSlots;

  AvailableDates({this.date, this.isAvailable, this.message, this.timeSlots});

  AvailableDates.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    isAvailable = json['is_available'];
    message = json['message'];
    if (json['time_slots'] != null) {
      timeSlots = <TimeSlots>[];
      json['time_slots'].forEach((v) {
        timeSlots!.add(TimeSlots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['is_available'] = isAvailable;
    data['message'] = message;
    if (timeSlots != null) {
      data['time_slots'] = timeSlots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSlots {
  String? time;
  bool? isAvailable;
  String? message;

  TimeSlots({this.time, this.isAvailable, this.message});

  TimeSlots.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    isAvailable = json['is_available'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['is_available'] = isAvailable;
    data['message'] = message;
    return data;
  }
}

class ResourceList {
  int? id;
  String? name;
  String? baseCosts;
  String? blockCosts;

  ResourceList({this.id, this.name, this.baseCosts, this.blockCosts});

  ResourceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    baseCosts = json['base_costs'];
    blockCosts = json['block_costs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['base_costs'] = baseCosts;
    data['block_costs'] = blockCosts;
    return data;
  }
}
