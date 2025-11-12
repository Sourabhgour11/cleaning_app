class GetContentModel {
  bool? success;
  List<String>? message;
  List<ContentArr>? contentArr;

  GetContentModel({this.success, this.message, this.contentArr});

  GetContentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
    if (json['content_arr'] != null) {
      contentArr = <ContentArr>[];
      json['content_arr'].forEach((v) {
        contentArr!.add(new ContentArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.contentArr != null) {
      data['content_arr'] = this.contentArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentArr {
  int? contentId;
  int? contentType;
  String? content;
  String? contentUrl;
  bool? status;

  ContentArr(
      {this.contentId,
        this.contentType,
        this.content,
        this.contentUrl,
        this.status});

  ContentArr.fromJson(Map<String, dynamic> json) {
    contentId = json['content_id'];
    contentType = json['content_type'];
    content = json['content'];
    contentUrl = json['content_url'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_id'] = this.contentId;
    data['content_type'] = this.contentType;
    data['content'] = this.content;
    data['content_url'] = this.contentUrl;
    data['status'] = this.status;
    return data;
  }
}
