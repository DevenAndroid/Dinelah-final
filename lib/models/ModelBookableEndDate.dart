class ModelBookableEndDateData {
  ModelBookableEndDateData({
    required this.status,
    required this.endTimeSlots,
  });
  late final bool status;
  late final List<EndTimeSlots> endTimeSlots;

  ModelBookableEndDateData.fromJson(Map<String, dynamic> json){
    status = json['status'];
    endTimeSlots = List.from(json['end_time_slots']).map((e)=>EndTimeSlots.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['end_time_slots'] = endTimeSlots.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class EndTimeSlots {
  EndTimeSlots({
    required this.time,
    required this.isAvailable,
    required this.message,
    required this.duration,
  });
  late final String time;
  late final bool isAvailable;
  late final String message;
  late final int duration;

  EndTimeSlots.fromJson(Map<String, dynamic> json){
    time = json['time'];
    isAvailable = json['is_available'];
    message = json['message'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['time'] = time;
    _data['is_available'] = isAvailable;
    _data['message'] = message;
    _data['duration'] = duration;
    return _data;
  }
}