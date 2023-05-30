import 'dart:convert';

Clothes clothesFromJson(String str) => Clothes.fromJson(json.decode(str));

String clothesToJson(Clothes data2) => json.encode(data2.toJson());

class Clothes {
  Clothes({
    required this.status2,
    required this.data2,
  });

  String status2;
  List<Data2> data2;

  factory Clothes.fromJson(Map<String, dynamic> json) => Clothes(
    status2: json["status"],
    data2: List<Data2>.from(json["data"].map((x) => Data2.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status2,
    "data": List<dynamic>.from(data2.map((x) => x.toJson())),
  };
}

class Data2 {
  Data2({
    required this.cloth,
  });

  String cloth;

  factory Data2.fromJson(Map<String, dynamic> json) => Data2(
    cloth: json["Cloth"],
  );

  Map<String, dynamic> toJson() => {
    "Cloth": cloth,
  };
}
