import 'package:get/get.dart';

class ModelAllAttributesReq {
  String? name;
  RxString? currentIndex;
  int? termId;
  ModelAllAttributesReq(this.name, this.currentIndex, this.termId);

  ModelAllAttributesReq.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    currentIndex!.value = json['currentIndex'];
    termId = json['term_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['currentIndex'] = currentIndex!.value;
    data['term_id'] = termId;
    return data;
  }
}
