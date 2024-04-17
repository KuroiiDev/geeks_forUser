class ResponseBookmark {
  ResponseBookmark({
      this.status, 
      this.id,});

  ResponseBookmark.fromJson(dynamic json) {
    status = json['status'];
    id = json['id'];
  }
  String? status;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['id'] = id;
    return map;
  }

}