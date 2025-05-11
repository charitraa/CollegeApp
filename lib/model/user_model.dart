class UserModel {
  String? token;
  User? user;

  UserModel({this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? uuid;
  String? parentTable;
  String? parentId;
  String? username;
  String? email;
  int? emailVerifiedAt;
  String? mobile;
  String? status;
  int? isActive;

  User(
      {this.uuid,
        this.parentTable,
        this.parentId,
        this.username,
        this.email,
        this.emailVerifiedAt,
        this.mobile,
        this.status,
        this.isActive});

  User.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    parentTable = json['parent_table'];
    parentId = json['parent_id'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    status = json['status'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['parent_table'] = this.parentTable;
    data['parent_id'] = this.parentId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile'] = this.mobile;
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    return data;
  }
}
