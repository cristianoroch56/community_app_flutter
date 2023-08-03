class Mymembersmodel {
  int? count;
  String? next;
  String? previous;
  Results? results;

  Mymembersmodel({this.count, this.next, this.previous, this.results});

  Mymembersmodel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    results =
        json['results'] != null ? Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.toJson();
    }
    return data;
  }
}

class Results {
  String? message;
  List<Data>? data;

  Results({this.message, this.data});

  Results.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? user;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? profilePic;
  String? relationWithMainMember;
  String? birthdate;
  String? education;
  bool? maritalStatus;
  String? currentlyLivingAt;
  String? createdAt;
  String? updatedAt;
  bool? pushNotification;

  Data(
      {this.id,
      this.user,
      this.firstName,
      this.lastName,
      this.mobileNumber,
      this.profilePic,
      this.relationWithMainMember,
      this.birthdate,
      this.education,
      this.maritalStatus,
      this.currentlyLivingAt,
      this.createdAt,
      this.updatedAt,
      this.pushNotification});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    profilePic = json['profile_pic'];
    relationWithMainMember = json['relation_with_main_member'];
    birthdate = json['birthdate'];
    education = json['education'];
    maritalStatus = json['marital_status'];
    currentlyLivingAt = json['currently_living_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pushNotification = json['push_notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile_number'] = mobileNumber;
    data['profile_pic'] = profilePic;
    data['relation_with_main_member'] = relationWithMainMember;
    data['birthdate'] = birthdate;
    data['education'] = education;
    data['marital_status'] = maritalStatus;
    data['currently_living_at'] = currentlyLivingAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['push_notification'] = pushNotification;
    return data;
  }
}
