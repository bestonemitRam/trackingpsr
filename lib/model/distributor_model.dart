
class DistributorModel {
  bool? status;
  dynamic message;
  DistributorData? result;

  DistributorModel({this.status, this.message, this.result});

  DistributorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null
        ? new DistributorData.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class DistributorData {
  List<DistributorList>? distributorList;
  dynamic baseImageUrl;

  DistributorData({this.distributorList, this.baseImageUrl});

  DistributorData.fromJson(Map<String, dynamic> json) {
    if (json['distributor_list'] != null) {
      distributorList = <DistributorList>[];
      json['distributor_list'].forEach((v) {
        distributorList!.add(new DistributorList.fromJson(v));
      });
    }
    baseImageUrl = json['base_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distributorList != null) {
      data['distributor_list'] =
          this.distributorList!.map((v) => v.toJson()).toList();
    }
    data['base_image_url'] = this.baseImageUrl;
    return data;
  }
}

class DistributorList {
  int? id;
  dynamic distributorAvatar;
  dynamic distributorOrgName;
  dynamic distributorLatitude;
  dynamic distributorLongitude;
  int? isVarified;
  dynamic name;
  dynamic address;
  dynamic mail;
  dynamic contactNumber;
  int? isActive;
  dynamic createdAt;
  dynamic cancelChequeImage;
  dynamic pancardImage;
  dynamic aadharcardImageFront;
  dynamic aadharcardImageBack;
  dynamic gstNo;
  dynamic appointmentForm;
  dynamic distributor_data;

  DistributorList(
      {this.id,
      this.distributorAvatar,
      this.distributorOrgName,
      this.distributorLatitude,
      this.distributorLongitude,
      this.isVarified,
      this.name,
      this.address,
      this.mail,
      this.contactNumber,
      this.isActive,
      this.createdAt,
      this.cancelChequeImage,
      this.pancardImage,
      this.aadharcardImageFront,
      this.aadharcardImageBack,
      this.gstNo,
      this.appointmentForm,
      this.distributor_data});

  DistributorList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    distributorAvatar = json['distributor_avatar'];
    distributorOrgName = json['distributor_org_name'];
    distributorLatitude = json['distributor_latitude'];
    distributorLongitude = json['distributor_longitude'];
    isVarified = json['is_varified'];
    name = json['name'];
    address = json['address'];
    mail = json['mail'];
    contactNumber = json['contact_number'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    cancelChequeImage = json['cancel_cheque_image'];
    pancardImage = json['pancard_image'];
    aadharcardImageFront = json['aadharcard_image_front'];
    aadharcardImageBack = json['aadharcard_image_back'];
    gstNo = json['gst_no'];
    appointmentForm = json['appointment_form'];
    distributor_data = json['distributor_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['distributor_avatar'] = this.distributorAvatar;
    data['distributor_org_name'] = this.distributorOrgName;
    data['distributor_latitude'] = this.distributorLatitude;
    data['distributor_longitude'] = this.distributorLongitude;
    data['is_varified'] = this.isVarified;
    data['name'] = this.name;
    data['address'] = this.address;
    data['mail'] = this.mail;
    data['contact_number'] = this.contactNumber;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['cancel_cheque_image'] = this.cancelChequeImage;
    data['pancard_image'] = this.pancardImage;
    data['aadharcard_image_front'] = this.aadharcardImageFront;
    data['aadharcard_image_back'] = this.aadharcardImageBack;
    data['gst_no'] = this.gstNo;
    data['appointment_form'] = this.appointmentForm;
    data['distributor_data'] = this.distributor_data;
    return data;
  }
}
