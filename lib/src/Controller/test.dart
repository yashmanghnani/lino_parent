class MyClass {
  String? name;
  String? mobile;

  MyClass({this.name, this.mobile});

  MyClass.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['mobile'] = mobile;
    return data;
  }
}
