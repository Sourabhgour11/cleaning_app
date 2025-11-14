class GetHomeScreenDataModel {
  bool? success;
  List<String>? msg;
  List<HomeData>? data;

  GetHomeScreenDataModel({
    this.success,
    this.msg,
    this.data,
  });

  factory GetHomeScreenDataModel.fromJson(Map<String, dynamic> json) {
    return GetHomeScreenDataModel(
      success: json['success'] ?? false,
      msg: _parseMessage(json['msg']),
      data: _parseList<HomeData>(json['data'], HomeData.fromJson),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'msg': msg,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }

  static List<String> _parseMessage(dynamic msgData) {
    if (msgData is List) {
      return msgData.where((e) => e != null).map((e) => e.toString()).toList();
    } else if (msgData is String) {
      return [msgData];
    }
    return [];
  }

  static List<T>? _parseList<T>(dynamic data, T Function(Map<String, dynamic>) fromJson) {
    if (data == null) return null;

    if (data is List) {
      final List<T> result = [];
      for (final item in data) {
        try {
          if (item != null && item is Map<String, dynamic>) {
            final parsedItem = fromJson(item);
            result.add(parsedItem);
          }
        } catch (e) {
          print('Error parsing list item: $e');
        }
      }
      return result;
    }

    return null;
  }
}

class HomeData {
  List<BannerArr>? bannerArr;
  List<CategoryArr>? categoryArr;
  List<SubCategoryArr>? subCategoryArr;
  List<VoucherCode>? voucherCode;

  HomeData({
    this.bannerArr,
    this.categoryArr,
    this.subCategoryArr,
    this.voucherCode,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      bannerArr: _parseList<BannerArr>(json['banner_arr'], BannerArr.fromJson),
      categoryArr: _parseList<CategoryArr>(json['category_arr'], CategoryArr.fromJson),
      subCategoryArr: _parseList<SubCategoryArr>(json['sub_category_arr'], SubCategoryArr.fromJson),
      voucherCode: _parseList<VoucherCode>(json['voucher_code'], VoucherCode.fromJson),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banner_arr': bannerArr?.map((e) => e.toJson()).toList(),
      'category_arr': categoryArr?.map((e) => e.toJson()).toList(),
      'sub_category_arr': subCategoryArr?.map((e) => e.toJson()).toList(),
      'voucher_code': voucherCode?.map((e) => e.toJson()).toList(),
    };
  }

  static List<T>? _parseList<T>(dynamic data, T Function(Map<String, dynamic>) fromJson) {
    if (data == null) return null;

    if (data is List) {
      final List<T> result = [];
      for (final item in data) {
        try {
          if (item != null && item is Map<String, dynamic>) {
            final parsedItem = fromJson(item);
            result.add(parsedItem);
          }
        } catch (e) {
          print('Error parsing list item: $e');
        }
      }
      return result;
    }

    return null;
  }
}

// ------------------ Banner ------------------
class BannerArr {
  int? bannerId;
  String? image;

  BannerArr({this.bannerId, this.image});

  factory BannerArr.fromJson(Map<String, dynamic> json) {
    return BannerArr(
      bannerId: _parseInt(json['banner_id']),
      image: _parseString(json['image']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banner_id': bannerId,
      'image': image,
    };
  }
}

// ------------------ Category ------------------
class CategoryArr {
  int? categoryId;
  String? name;
  String? image;

  CategoryArr({this.categoryId, this.name, this.image});

  factory CategoryArr.fromJson(Map<String, dynamic> json) {
    return CategoryArr(
      categoryId: _parseInt(json['category_id']),
      name: _parseString(json['name']),
      image: _parseString(json['image']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'name': name,
      'image': image,
    };
  }
}

// ------------------ SubCategory ------------------
class SubCategoryArr {
  int? categoryId;
  String? categoryName;
  String? image;
  List<SubCategory>? subcategories;
  String? subcategoriesText;

  SubCategoryArr({
    this.categoryId,
    this.categoryName,
    this.image,
    this.subcategories,
    this.subcategoriesText,
  });

  factory SubCategoryArr.fromJson(Map<String, dynamic> json) {
    final subData = json['subcategories'];

    return SubCategoryArr(
      categoryId: _parseInt(json['category_id']),
      categoryName: _parseString(json['category_name']),
      image: _parseString(json['image']),
      subcategories: _parseSubcategories(subData),
      subcategoriesText: _parseSubcategoriesText(subData),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
      'image': image,
      'subcategories': subcategories != null && subcategories!.isNotEmpty
          ? subcategories!.map((e) => e.toJson()).toList()
          : subcategoriesText ?? '',
    };
  }

  static List<SubCategory>? _parseSubcategories(dynamic subData) {
    if (subData is List) {
      final List<SubCategory> result = [];
      for (final item in subData) {
        try {
          if (item != null && item is Map<String, dynamic>) {
            result.add(SubCategory.fromJson(item));
          }
        } catch (e) {
          print('Error parsing subcategory: $e');
        }
      }
      return result;
    }
    return null;
  }

  static String _parseSubcategoriesText(dynamic subData) {
    if (subData is String) {
      return subData;
    }
    return '';
  }
}

class SubCategory {
  int? subCategoryId;
  String? name;
  String? image;
  double? amount;
  String? description;

  SubCategory({
    this.subCategoryId,
    this.name,
    this.image,
    this.amount,
    this.description,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      subCategoryId: _parseInt(json['cat_sub_cat_id']),
      name: _parseString(json['name']),
      image: _parseString(json['image']),
      amount: _parseDouble(json['amount']),
      description: _parseString(json['description']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cat_sub_cat_id': subCategoryId,
      'name': name,
      'image': image,
      'amount': amount,
      'description': description,
    };
  }
}

// ------------------ Voucher ------------------
class VoucherCode {
  int? voucherCodeId;
  int? amount;
  String? code;

  VoucherCode({this.voucherCodeId, this.amount, this.code});

  factory VoucherCode.fromJson(Map<String, dynamic> json) {
    return VoucherCode(
      voucherCodeId: _parseInt(json['voucher_code_id']),
      amount: _parseInt(json['amount']),
      code: _parseString(json['code']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voucher_code_id': voucherCodeId,
      'amount': amount,
      'code': code,
    };
  }
}

// Helper functions
int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}

double? _parseDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString());
}

String _parseString(dynamic value) {
  if (value == null) return '';
  if (value is String) return value;
  return value.toString();
}