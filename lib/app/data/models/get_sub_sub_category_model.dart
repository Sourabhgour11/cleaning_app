class GetSubSubCategoryModel {
  bool? success;
  List<String>? msg;
  List<CategoryArray>? categoryArray;

  GetSubSubCategoryModel({this.success, this.msg, this.categoryArray});

  GetSubSubCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    // Handle msg (can be String or List)
    if (json['msg'] is List) {
      msg = List<String>.from(json['msg']);
    } else if (json['msg'] is String) {
      msg = [json['msg']];
    } else {
      msg = [];
    }

    // Handle category_arr safely
    if (json['category_arr'] is List) {
      categoryArray = (json['category_arr'] as List)
          .map((v) => CategoryArray.fromJson(v))
          .toList();
    } else {
      categoryArray = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['msg'] = msg;
    if (categoryArray != null) {
      data['category_arr'] = categoryArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryArray {
  int? subCategoryId;
  int? catSubCatId;
  int? categoryId;
  String? name;
  String? image;
  int? amount;
  String? description;
  bool? status;
  int? likeUnlikeStatus; // 0 = not liked, 1 = liked
  String? likeUnlikeStatusLabel;
  String? createtime;

  CategoryArray({
    this.subCategoryId,
    this.catSubCatId,
    this.categoryId,
    this.name,
    this.image,
    this.amount,
    this.description,
    this.status,
    this.likeUnlikeStatus,
    this.likeUnlikeStatusLabel,
    this.createtime,
  });

  CategoryArray.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['sub_category_id'];
    catSubCatId = json['cat_sub_cat_id'];
    categoryId = json['category_id'];
    name = json['name'];
    image = json['image'];
    amount = json['amount'];
    description = json['description'];
    status = json['status'];
    likeUnlikeStatus = json['like_unlike_status'];
    likeUnlikeStatusLabel = json['like_unlike_status_label'];
    createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['sub_category_id'] = subCategoryId;
    data['cat_sub_cat_id'] = catSubCatId;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['image'] = image;
    data['amount'] = amount;
    data['description'] = description;
    data['status'] = status;
    data['like_unlike_status'] = likeUnlikeStatus;
    data['like_unlike_status_label'] = likeUnlikeStatusLabel;
    data['createtime'] = createtime;
    return data;
  }
}
