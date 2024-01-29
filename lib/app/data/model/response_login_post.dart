/// status : true
/// message : "Login Successfully"
/// token : "6|bXd4QJ7xf7ojBrWZe0NlqSkHxydBoCtYyyoDq9zbb69da588"

class ResponseLoginPost {
  ResponseLoginPost({
      this.status, 
      this.message, 
      this.token,});

  ResponseLoginPost.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
  }
  bool? status;
  String? message;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['token'] = token;
    return map;
  }

}