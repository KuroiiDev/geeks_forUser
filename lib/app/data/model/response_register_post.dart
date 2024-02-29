/// status : "success"
/// data : {"name":"user","email":"user@example.com","role":"USER","updated_at":"2024-02-29T05:48:13.000000Z","created_at":"2024-02-29T05:48:13.000000Z","id":1}

class ResponseRegisterPost {
  ResponseRegisterPost({
      this.status, 
      this.data,});

  ResponseRegisterPost.fromJson(dynamic json) {
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

/// name : "user"
/// email : "user@example.com"
/// role : "USER"
/// updated_at : "2024-02-29T05:48:13.000000Z"
/// created_at : "2024-02-29T05:48:13.000000Z"
/// id : 1

class Data {
  Data({
      this.name, 
      this.email, 
      this.role, 
      this.updatedAt, 
      this.createdAt, 
      this.id,});

  Data.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  String? name;
  String? email;
  String? role;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}