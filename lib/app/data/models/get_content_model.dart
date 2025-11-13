class GetUserBookingsModel {
  bool? success;
  List<String>? msg;
  int? totalRecords;
  String? upcomingBookings;
  List<PastBookings>? pastBookings;

  GetUserBookingsModel(
      {this.success,
        this.msg,
        this.totalRecords,
        this.upcomingBookings,
        this.pastBookings});

  GetUserBookingsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'].cast<String>();
    totalRecords = json['total_records'];
    upcomingBookings = json['upcoming_bookings'];
    if (json['past_bookings'] != null) {
      pastBookings = <PastBookings>[];
      json['past_bookings'].forEach((v) {
        pastBookings!.add(new PastBookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    data['total_records'] = this.totalRecords;
    data['upcoming_bookings'] = this.upcomingBookings;
    if (this.pastBookings != null) {
      data['past_bookings'] =
          this.pastBookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PastBookings {
  int? bookingId;
  String? bookingCode;
  int? userId;
  int? professionalsCount;
  String? categoryName;
  Null? catSubCategoryName;
  String? subCategoryName;
  int? duration;
  String? address;
  int? materials;
  String? materialsLabel;
  String? instructions;
  String? bookingDate;
  String? bookingStartTime;
  String? bookingEndTime;
  int? status;
  String? statusLabel;
  int? totalAmount;
  int? subTotal;
  int? serviceFee;
  int? vehicleId;
  String? createtime;
  String? updatetime;

  PastBookings(
      {this.bookingId,
        this.bookingCode,
        this.userId,
        this.professionalsCount,
        this.categoryName,
        this.catSubCategoryName,
        this.subCategoryName,
        this.duration,
        this.address,
        this.materials,
        this.materialsLabel,
        this.instructions,
        this.bookingDate,
        this.bookingStartTime,
        this.bookingEndTime,
        this.status,
        this.statusLabel,
        this.totalAmount,
        this.subTotal,
        this.serviceFee,
        this.vehicleId,
        this.createtime,
        this.updatetime});

  PastBookings.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    bookingCode = json['booking_code'];
    userId = json['user_id'];
    professionalsCount = json['professionals_count'];
    categoryName = json['category_name'];
    catSubCategoryName = json['cat_sub_category_name'];
    subCategoryName = json['sub_category_name'];
    duration = json['duration'];
    address = json['address'];
    materials = json['materials'];
    materialsLabel = json['materials_label'];
    instructions = json['instructions'];
    bookingDate = json['booking_date'];
    bookingStartTime = json['booking_start_time'];
    bookingEndTime = json['booking_end_time'];
    status = json['status'];
    statusLabel = json['status_label'];
    totalAmount = json['total_amount'];
    subTotal = json['sub_total'];
    serviceFee = json['service_fee'];
    vehicleId = json['vehicle_id'];
    createtime = json['createtime'];
    updatetime = json['updatetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['booking_code'] = this.bookingCode;
    data['user_id'] = this.userId;
    data['professionals_count'] = this.professionalsCount;
    data['category_name'] = this.categoryName;
    data['cat_sub_category_name'] = this.catSubCategoryName;
    data['sub_category_name'] = this.subCategoryName;
    data['duration'] = this.duration;
    data['address'] = this.address;
    data['materials'] = this.materials;
    data['materials_label'] = this.materialsLabel;
    data['instructions'] = this.instructions;
    data['booking_date'] = this.bookingDate;
    data['booking_start_time'] = this.bookingStartTime;
    data['booking_end_time'] = this.bookingEndTime;
    data['status'] = this.status;
    data['status_label'] = this.statusLabel;
    data['total_amount'] = this.totalAmount;
    data['sub_total'] = this.subTotal;
    data['service_fee'] = this.serviceFee;
    data['vehicle_id'] = this.vehicleId;
    data['createtime'] = this.createtime;
    data['updatetime'] = this.updatetime;
    return data;
  }
}
