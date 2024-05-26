class MantraModel {
  String? mantraName;

  MantraModel({this.mantraName});

  MantraModel.fromJson(Map<String, dynamic> json) {
    mantraName = json['mantra_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mantra_name'] = this.mantraName;
    return data;
  }
}
