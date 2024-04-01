class RetailerModel {
  bool? status;
  dynamic message;
  ResultData? result;

  RetailerModel({this.status, this.message, this.result});

  RetailerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new ResultData.fromJson(json['result']) : null;
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

class ResultData {
  List<RetailersList>? retailersList;
  dynamic baseURL;

  ResultData({this.retailersList, this.baseURL});

  ResultData.fromJson(Map<String, dynamic> json) {
    if (json['retailersList'] != null) {
      retailersList = <RetailersList>[];
      json['retailersList'].forEach((v) {
        retailersList!.add(new RetailersList.fromJson(v));
      });
    }
    baseURL = json['baseURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.retailersList != null) {
      data['retailersList'] =
          this.retailersList!.map((v) => v.toJson()).toList();
    }
    data['baseURL'] = this.baseURL;
    return data;
  }
}

class RetailersList {
  int? id;
  dynamic retailerName;
  dynamic retailerShopName;
  dynamic retailerAddress;
  dynamic retailerLatitude;
  dynamic retailerLongitude;
  dynamic retailerShopImage;
  dynamic retailer_mobile_number;
  dynamic retailer_data;
  int? isVarified;

  RetailersList(
      {this.id,
      this.retailerName,
      this.retailerShopName,
      this.retailerAddress,
      this.retailerLatitude,
      this.retailerLongitude,
      this.retailerShopImage,
      this.retailer_mobile_number,
      this.retailer_data,
      this.isVarified});

  RetailersList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    retailerName = json['retailer_name'];
    retailerShopName = json['retailer_shop_name'];
    retailerAddress = json['retailer_address'];
    retailerLatitude = json['retailer_latitude'];
    retailerLongitude = json['retailer_longitude'];
    retailerShopImage = json['retailer_shop_image'];
    retailer_mobile_number = json['retailer_mobile_number'];
    retailer_data = json['retailer_data'];
    isVarified = json['is_varified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['retailer_name'] = this.retailerName;
    data['retailer_shop_name'] = this.retailerShopName;
    data['retailer_address'] = this.retailerAddress;
    data['retailer_latitude'] = this.retailerLatitude;
    data['retailer_longitude'] = this.retailerLongitude;
    data['retailer_shop_image'] = this.retailerShopImage;
    data['retailer_mobile_number'] = this.retailer_mobile_number;
    data['is_varified'] = this.isVarified;
    data['retailer_data'] = this.retailer_data;

    return data;
  }
}
