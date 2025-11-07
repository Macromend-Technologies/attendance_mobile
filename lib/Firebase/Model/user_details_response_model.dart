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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}
