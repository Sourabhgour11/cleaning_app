class CreateBookingModel {
  bool? success;
  List<String>? msg;
  int? bookingId;
  String? bookingCode;

  CreateBookingModel(
      {this.success, this.msg, this.bookingId, this.bookingCode});

  CreateBookingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'].cast<String>();
    bookingId = json['booking_id'];
    bookingCode = json['booking_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    data['booking_id'] = this.bookingId;
    data['booking_code'] = this.bookingCode;
    return data;
  }
}
