import 'dart:convert';

class PenguinModel {
  int id;
  String penguin;
  String scientificName;
  int height;
  int weight;
  String distribution;
  String details;
  List images;

  PenguinModel({
    required this.id,
    required this.penguin,
    required this.scientificName,
    required this.height,
    required this.weight,
    required this.distribution,
    required this.details,
    required this.images,
  });

  PenguinModel.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      penguin = json["penguin"],
      scientificName = json["scientificName"],
      height = json["height"],
      weight = json["weight"],
      distribution = json["distribution"],
      details = json["details"],
      images = json["images"].toList();
}

class ImageLists {
  List<String> images;

  ImageLists({required this.images});
  ImageLists.fromJson(List<String> json) : images = json;
}
