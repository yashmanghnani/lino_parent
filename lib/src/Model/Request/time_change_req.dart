class TimeChangeReq {
  String userId;
  int minutes;

  TimeChangeReq({
    required this.userId,
    required this.minutes
  });

  TimeChangeReq.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        minutes = json['minutes'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['minutes'] = minutes;
    return data;
  }
}
