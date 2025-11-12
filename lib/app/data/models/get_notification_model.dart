class NotificationModel {
  bool? success;
  List<String>? message;
  List<NotificationArr>? notificationArr;

  NotificationModel({this.success, this.message, this.notificationArr});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    // ✅ Safe handling for 'message'
    if (json['message'] is List) {
      message = List<String>.from(json['message']);
    } else if (json['message'] is String) {
      message = [json['message']]; // wrap single string into list
    } else {
      message = [];
    }

    // ✅ Safe handling for 'notification_arr'
    if (json['notification_arr'] is List) {
      notificationArr = (json['notification_arr'] as List)
          .map((v) => NotificationArr.fromJson(v as Map<String, dynamic>))
          .toList();
    } else {
      notificationArr = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (notificationArr != null) {
      data['notification_arr'] =
          notificationArr!.map((v) => v.toJson()).toList();
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

  NotificationArr({
    this.notificationMessageId,
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
    this.createtime,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification_message_id'] = notificationMessageId;
    data['user_id'] = userId;
    data['user_image'] = userImage;
    data['other_user_id'] = otherUserId;
    data['username'] = username;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['name'] = name;
    data['action'] = action;
    data['action_id'] = actionId;
    data['action_json'] = actionJson;
    data['date_time'] = dateTime;
    data['title'] = title;
    data['message'] = message;
    data['read_status'] = readStatus;
    data['status'] = status;
    data['createtime'] = createtime;
    return data;
  }
}
