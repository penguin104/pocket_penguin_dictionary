import 'dart:convert';

class PenguinModel {
  final int id;
  final String name;
  final double height;
  final double weight;
  final String distribution;
  final String details;
  final List<String> images;

  PenguinModel(
    this.id,
    this.name,
    this.height,
    this.weight,
    this.distribution,
    this.details,
    this.images,
  );
}

void JsonDecode() {
  final jsonData;
  jsonData = jsonDecode("lib/data/penguin_kind.json");
  print(jsonData);
}
