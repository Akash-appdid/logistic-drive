import 'dart:convert';

List<HomeItem> homeItemFromJson(String str) =>
    List<HomeItem>.from(json.decode(str).map((x) => HomeItem.fromJson(x)));

String homeItemToJson(List<HomeItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeItem {
  int? id;
  String? title;
  int? homeItemCategoryId;
  HomeItemCategory? homeItemCategory;
  int itemQuantity;

  HomeItem(
      {this.id,
      this.title,
      this.homeItemCategoryId,
      this.homeItemCategory,
      this.itemQuantity = 0});

  factory HomeItem.fromJson(Map<String, dynamic> json) => HomeItem(
        id: json["id"],
        title: json["title"],
        homeItemCategoryId: json["home_item_category_id"],
        homeItemCategory: json["home_item_category"] == null
            ? null
            : HomeItemCategory.fromJson(json["home_item_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "home_item_category_id": homeItemCategoryId,
        "home_item_category": homeItemCategory?.toJson(),
      };
}

class HomeItemCategory {
  int? id;
  String? title;

  HomeItemCategory({
    this.id,
    this.title,
  });

  factory HomeItemCategory.fromJson(Map<String, dynamic> json) =>
      HomeItemCategory(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
