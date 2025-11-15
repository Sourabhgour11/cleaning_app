class GetUserBookingModel {
  bool? success;
  List<String>? msg;
  int? totalRecords;
  List<UpcomingBookings>? upcomingBookings;
  List<PastBookings>? pastBookings;

  GetUserBookingModel({
    this.success,
    this.msg,
    this.totalRecords,
    this.upcomingBookings,
    this.pastBookings,
  });

  GetUserBookingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    /// msg can be list or single string
    if (json['msg'] is List) {
      msg = List<String>.from(json['msg']);
    } else if (json['msg'] is String) {
      msg = [json['msg']];
    }

    totalRecords = json['total_records'];

    /// FIXED UPCOMING BOOKINGS
    if (json['upcoming_bookings'] is List) {
      upcomingBookings = [];
      json['upcoming_bookings'].forEach((v) {
        upcomingBookings!.add(UpcomingBookings.fromJson(v));
      });
    }
    else {
      /// When it's string like "No upcoming bookings"
      upcomingBookings = [];
    }

    /// PAST BOOKINGS
    if (json['past_bookings'] is List) {
      pastBookings = [];
      json['past_bookings'].forEach((v) {
        pastBookings!.add(PastBookings.fromJson(v));
      });
    } else {
      pastBookings = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['msg'] = msg;
    data['total_records'] = totalRecords;

    data['upcoming_bookings'] =
        upcomingBookings?.map((v) => v.toJson()).toList();

    data['past_bookings'] =
        pastBookings?.map((v) => v.toJson()).toList();

    return data;
  }
}


class UpcomingBookings {
  String? catSubCategoryName;
  String? categoryName;
  String? subCategoryName;
  int? bookingId;
  String? bookingCode;
  int? userId;
  int? categoryId;
  int? subCategoryId;
  int? catSubCatId;
  int? duration;
  int? professionalsCount;
  String? address;
  int? materials;
  String? instructions;
  String? bookingDate;
  String? bookingStartTime;
  String? bookingEndTime;
  int? status;
  int? rescheduleStatus;
  String? rescheduleDate;
  String? rescheduleStartTime;
  String? rescheduleEndTime;
  int? totalAmount;
  int? subTotal;
  int? serviceFee;
  String? voucherCode;
  int? voucherDiscount;
  int? cleanerId;
  int? vehicleId;
  int? deleteFlag;
  String? createtime;
  String? updatetime;
  String? mysqltime;

  UpcomingBookings({
    this.catSubCategoryName,
    this.categoryName,
    this.subCategoryName,
    this.bookingId,
    this.bookingCode,
    this.userId,
    this.categoryId,
    this.subCategoryId,
    this.catSubCatId,
    this.duration,
    this.professionalsCount,
    this.address,
    this.materials,
    this.instructions,
    this.bookingDate,
    this.bookingStartTime,
    this.bookingEndTime,
    this.status,
    this.rescheduleStatus,
    this.rescheduleDate,
    this.rescheduleStartTime,
    this.rescheduleEndTime,
    this.totalAmount,
    this.subTotal,
    this.serviceFee,
    this.voucherCode,
    this.voucherDiscount,
    this.cleanerId,
    this.vehicleId,
    this.deleteFlag,
    this.createtime,
    this.updatetime,
    this.mysqltime,
  });

  UpcomingBookings.fromJson(Map<String, dynamic> json) {
    catSubCategoryName = json['cat_sub_category_name'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
    bookingId = json['booking_id'];
    bookingCode = json['booking_code'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    catSubCatId = json['cat_sub_cat_id'];
    duration = json['duration'];
    professionalsCount = json['professionals_count'];
    address = json['address'];
    materials = json['materials'];
    instructions = json['instructions'];
    bookingDate = json['booking_date'];
    bookingStartTime = json['booking_start_time'];
    bookingEndTime = json['booking_end_time'];
    status = json['status'];
    rescheduleStatus = json['reschedule_status'];
    rescheduleDate = json['reschedule_date'];
    rescheduleStartTime = json['reschedule_start_time'];
    rescheduleEndTime = json['reschedule_end_time'];
    totalAmount = json['total_amount'];
    subTotal = json['sub_total'];
    serviceFee = json['service_fee'];
    voucherCode = json['voucher_code'];
    voucherDiscount = json['voucher_discount'];
    cleanerId = json['cleaner_id'];
    vehicleId = json['vehicle_id'];
    deleteFlag = json['delete_flag'];
    createtime = json['createtime'];
    updatetime = json['updatetime'];
    mysqltime = json['mysqltime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'cat_sub_category_name': catSubCategoryName,
      'category_name': categoryName,
      'sub_category_name': subCategoryName,
      'booking_id': bookingId,
      'booking_code': bookingCode,
      'user_id': userId,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'cat_sub_cat_id': catSubCatId,
      'duration': duration,
      'professionals_count': professionalsCount,
      'address': address,
      'materials': materials,
      'instructions': instructions,
      'booking_date': bookingDate,
      'booking_start_time': bookingStartTime,
      'booking_end_time': bookingEndTime,
      'status': status,
      'reschedule_status': rescheduleStatus,
      'reschedule_date': rescheduleDate,
      'reschedule_start_time': rescheduleStartTime,
      'reschedule_end_time': rescheduleEndTime,
      'total_amount': totalAmount,
      'sub_total': subTotal,
      'service_fee': serviceFee,
      'voucher_code': voucherCode,
      'voucher_discount': voucherDiscount,
      'cleaner_id': cleanerId,
      'vehicle_id': vehicleId,
      'delete_flag': deleteFlag,
      'createtime': createtime,
      'updatetime': updatetime,
      'mysqltime': mysqltime,
    };
  }
}


class PastBookings {
  Null? catSubCategoryName;
  String? categoryName;
  String? subCategoryName;
  int? bookingId;
  String? bookingCode;
  int? userId;
  int? categoryId;
  int? subCategoryId;
  int? catSubCatId;
  int? duration;
  int? professionalsCount;
  String? address;
  int? materials;
  String? instructions;
  String? bookingDate;
  String? bookingStartTime;
  String? bookingEndTime;
  int? status;
  int? rescheduleStatus;
  Null? rescheduleDate;
  Null? rescheduleStartTime;
  Null? rescheduleEndTime;
  int? totalAmount;
  int? subTotal;
  int? serviceFee;
  String? voucherCode;
  int? voucherDiscount;
  int? cleanerId;
  int? vehicleId;
  int? deleteFlag;
  String? createtime;
  String? updatetime;
  String? mysqltime;

  PastBookings(
      {this.catSubCategoryName,
        this.categoryName,
        this.subCategoryName,
        this.bookingId,
        this.bookingCode,
        this.userId,
        this.categoryId,
        this.subCategoryId,
        this.catSubCatId,
        this.duration,
        this.professionalsCount,
        this.address,
        this.materials,
        this.instructions,
        this.bookingDate,
        this.bookingStartTime,
        this.bookingEndTime,
        this.status,
        this.rescheduleStatus,
        this.rescheduleDate,
        this.rescheduleStartTime,
        this.rescheduleEndTime,
        this.totalAmount,
        this.subTotal,
        this.serviceFee,
        this.voucherCode,
        this.voucherDiscount,
        this.cleanerId,
        this.vehicleId,
        this.deleteFlag,
        this.createtime,
        this.updatetime,
        this.mysqltime});

  PastBookings.fromJson(Map<String, dynamic> json) {
    catSubCategoryName = json['cat_sub_category_name'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
    bookingId = json['booking_id'];
    bookingCode = json['booking_code'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    catSubCatId = json['cat_sub_cat_id'];
    duration = json['duration'];
    professionalsCount = json['professionals_count'];
    address = json['address'];
    materials = json['materials'];
    instructions = json['instructions'];
    bookingDate = json['booking_date'];
    bookingStartTime = json['booking_start_time'];
    bookingEndTime = json['booking_end_time'];
    status = json['status'];
    rescheduleStatus = json['reschedule_status'];
    rescheduleDate = json['reschedule_date'];
    rescheduleStartTime = json['reschedule_start_time'];
    rescheduleEndTime = json['reschedule_end_time'];
    totalAmount = json['total_amount'];
    subTotal = json['sub_total'];
    serviceFee = json['service_fee'];
    voucherCode = json['voucher_code'];
    voucherDiscount = json['voucher_discount'];
    cleanerId = json['cleaner_id'];
    vehicleId = json['vehicle_id'];
    deleteFlag = json['delete_flag'];
    createtime = json['createtime'];
    updatetime = json['updatetime'];
    mysqltime = json['mysqltime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_sub_category_name'] = this.catSubCategoryName;
    data['category_name'] = this.categoryName;
    data['sub_category_name'] = this.subCategoryName;
    data['booking_id'] = this.bookingId;
    data['booking_code'] = this.bookingCode;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['cat_sub_cat_id'] = this.catSubCatId;
    data['duration'] = this.duration;
    data['professionals_count'] = this.professionalsCount;
    data['address'] = this.address;
    data['materials'] = this.materials;
    data['instructions'] = this.instructions;
    data['booking_date'] = this.bookingDate;
    data['booking_start_time'] = this.bookingStartTime;
    data['booking_end_time'] = this.bookingEndTime;
    data['status'] = this.status;
    data['reschedule_status'] = this.rescheduleStatus;
    data['reschedule_date'] = this.rescheduleDate;
    data['reschedule_start_time'] = this.rescheduleStartTime;
    data['reschedule_end_time'] = this.rescheduleEndTime;
    data['total_amount'] = this.totalAmount;
    data['sub_total'] = this.subTotal;
    data['service_fee'] = this.serviceFee;
    data['voucher_code'] = this.voucherCode;
    data['voucher_discount'] = this.voucherDiscount;
    data['cleaner_id'] = this.cleanerId;
    data['vehicle_id'] = this.vehicleId;
    data['delete_flag'] = this.deleteFlag;
    data['createtime'] = this.createtime;
    data['updatetime'] = this.updatetime;
    data['mysqltime'] = this.mysqltime;
    return data;
  }
}
