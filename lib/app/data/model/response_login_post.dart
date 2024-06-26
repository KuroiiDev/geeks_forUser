/// status : "success"
/// data : {"id":1,"email":"user@example.com","name":"user","role":"USER","created_at":"2024-02-29T05:48:13.000000Z","updated_at":"2024-02-29T05:48:13.000000Z"}

class ResponseLoginPost {
  ResponseLoginPost({
      this.status, 
      this.data,});

  ResponseLoginPost.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// id : 1
/// email : "user@example.com"
/// name : "user"
/// role : "USER"
/// created_at : "2024-02-29T05:48:13.000000Z"
/// updated_at : "2024-02-29T05:48:13.000000Z"

class Data {
  Data({
      this.id, 
      this.email, 
      this.name, 
      this.role, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? email;
  String? name;
  String? role;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['name'] = name;
    map['role'] = role;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}