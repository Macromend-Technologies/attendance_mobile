class UserDetailsResponseModel {
  String? email;
  String? name;
  String? phone;

  UserDetailsResponseModel({this.email, this.name, this.phone});

  UserDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}
