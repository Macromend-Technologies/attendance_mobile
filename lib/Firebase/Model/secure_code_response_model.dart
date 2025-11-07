class SecureCodeResponseModel {
  int? code;
  String? createdAt;
  bool? isDelete;

  SecureCodeResponseModel({this.code, this.createdAt, this.isDelete});

  SecureCodeResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    createdAt = json['created_at'];
    isDelete = json['is_delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['created_at'] = this.createdAt;
    data['is_delete'] = this.isDelete;
    return data;
  }
}
