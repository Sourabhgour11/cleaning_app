class GetSubCategoryByCategoryIdModel {
  bool? success;
  List<String>? msg;
  List<CategoryArr>? categoryArr;

  GetSubCategoryByCategoryIdModel({
    this.success,
    this.msg,
    this.categoryArr,
  });

  GetSubCategoryByCategoryIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    // Handle msg (can be String or List)
    if (json['msg'] is List) {
      msg = List<String>.from(json['msg']);
    } else if (json['msg'] is String) {
      msg = [json['msg']];
    } else {
      msg = [];
    }

    // Handle category_arr (can be List or String or null)
    if (json['category_arr'] is List) {
      categoryArr = (json['category_arr'] as List)
          .map((v) => CategoryArr.fromJson(v))
          .toList();
    } else {
      // When category_arr is not a list (e.g., "No data found")
      categoryArr = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['msg'] = msg;
    if (categoryArr != null) {
      data['category_arr'] = categoryArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryArr {
  int? subCategoryId;
  int? categoryId;
  String? name;
  String? image;
  double? amount;
  String? description;
  bool? status;
  String? createtime;

  CategoryArr({
    this.subCategoryId,
    this.categoryId,
    this.name,
    this.image,
    this.amount,
    this.description,
    this.status,
    this.createtime,
  });

  CategoryArr.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    name = json['name'];
    image = json['image'];

    // Handle amount (int, double, string)
    final amountValue = json['amount'];
    if (amountValue is int) {
      amount = amountValue.toDouble();
    } else if (amountValue is double) {
      amount = amountValue;
    } else if (amountValue is String) {
      amount = double.tryParse(amountValue) ?? 0.0;
    } else {
      amount = 0.0;
    }

    description = json['description'];
    status = json['status'] is bool
        ? json['status']
        : json['status'] == 1 || json['status'] == '1';
    createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['sub_category_id'] = subCategoryId;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['image'] = image;
    data['amount'] = amount;
    data['description'] = description;
    data['status'] = status;
    data['createtime'] = createtime;
    return data;
  }
}
