class NotificationModel {
  bool? success;
  List<String>? message;
  List<NotificationArr>? notificationArr;

  NotificationModel({this.success, this.message, this.notificationArr});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
    if (json['notification_arr'] != null) {
      notificationArr = <NotificationArr>[];
      json['notification_arr'].forEach((v) {
        notificationArr!.add(new NotificationArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.notificationArr != null) {
      data['notification_arr'] =
          this.notificationArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationArr {
  int? notificationMessageId;
  int? userId;
  String? userImage;
  int? otherUserId;
  String? username;
  String? fName;
  String? lName;
  String? name;
  String? action;
  int? actionId;
  String? actionJson;
  String? dateTime;
  String? title;
  String? message;
  int? readStatus;
  bool? status;
  String? createtime;

  NotificationArr(
      {this.notificationMessageId,
        this.userId,
        this.userImage,
        this.otherUserId,
        this.username,
        this.fName,
        this.lName,
        this.name,
        this.action,
        this.actionId,
        this.actionJson,
        this.dateTime,
        this.title,
        this.message,
        this.readStatus,
        this.status,
        this.createtime});

  NotificationArr.fromJson(Map<String, dynamic> json) {
    notificationMessageId = json['notification_message_id'];
    userId = json['user_id'];
    userImage = json['user_image'];
    otherUserId = json['other_user_id'];
    username = json['username'];
    fName = json['f_name'];
    lName = json['l_name'];
    name = json['name'];
    action = json['action'];
    actionId = json['action_id'];
    actionJson = json['action_json'];
    dateTime = json['date_time'];
    title = json['title'];
    message = json['message'];
    readStatus = json['read_status'];
    status = json['status'];
    createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_message_id'] = this.notificationMessageId;
    data['user_id'] = this.userId;
    data['user_image'] = this.userImage;
    data['other_user_id'] = this.otherUserId;
    data['username'] = this.username;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['name'] = this.name;
    data['action'] = this.action;
    data['action_id'] = this.actionId;
    data['action_json'] = this.actionJson;
    data['date_time'] = this.dateTime;
    data['title'] = this.title;
    data['message'] = this.message;
    data['read_status'] = this.readStatus;
    data['status'] = this.status;
    data['createtime'] = this.createtime;
    return data;
  }
}
