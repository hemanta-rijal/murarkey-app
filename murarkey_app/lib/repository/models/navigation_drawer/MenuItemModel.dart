class MenuItemModel {
  String label;
  String type;
  String classType;
  String data;

  MenuItemModel({this.label, this.type, this.classType, this.data});

  MenuItemModel.fromJson(Map<String, dynamic> json) {
  label = json['label'];
  type = json['type'];
  classType = json['class'];
  data = json['data'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['label'] = this.label;
  data['type'] = this.type;
  data['class'] = this.classType;
  data['data'] = this.data;
  return data;
  }
}