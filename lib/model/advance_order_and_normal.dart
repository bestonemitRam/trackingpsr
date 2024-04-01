class AdvanceAndNormalOrder
 {
  bool? status;
  String? message;
  AdvanceOrderData? result;

  AdvanceAndNormalOrder({this.status, this.message, this.result});

  AdvanceAndNormalOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new AdvanceOrderData.fromJson(json['result']) : null;
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

class AdvanceOrderData {
  List<AdvanceOrders>? advanceOrders;
  List<NormalInventory>? normalInventory;
  String? baseURL;

  AdvanceOrderData({this.advanceOrders, this.normalInventory, this.baseURL});

  AdvanceOrderData.fromJson(Map<String, dynamic> json) {
    if (json['advanceOrders'] != null) {
      advanceOrders = <AdvanceOrders>[];
      json['advanceOrders'].forEach((v) {
        advanceOrders!.add(new AdvanceOrders.fromJson(v));
      });
    }
    if (json['normalInventory'] != null) {
      normalInventory = <NormalInventory>[];
      json['normalInventory'].forEach((v) {
        normalInventory!.add(new NormalInventory.fromJson(v));
      });
    }
    baseURL = json['baseURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.advanceOrders != null) {
      data['advanceOrders'] =
          this.advanceOrders!.map((v) => v.toJson()).toList();
    }
    if (this.normalInventory != null) {
      data['normalInventory'] =
          this.normalInventory!.map((v) => v.toJson()).toList();
    }
    data['baseURL'] = this.baseURL;
    return data;
  }
}

class AdvanceOrders {
  int? distributorAdvanceOrderId;
  String? retailerShopImage;
  String? retailerMobileNumber;
  String? retailerName;
  String? orderDate;

  AdvanceOrders(
      {this.distributorAdvanceOrderId,
      this.retailerShopImage,
      this.retailerMobileNumber,
      this.retailerName,
      this.orderDate});

  AdvanceOrders.fromJson(Map<String, dynamic> json) {
    distributorAdvanceOrderId = json['distributor_advance_order_id'];
    retailerShopImage = json['retailer_shop_image'];
    retailerMobileNumber = json['retailer_mobile_number'];
    retailerName = json['retailer_name'];
    orderDate = json['order_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distributor_advance_order_id'] = this.distributorAdvanceOrderId;
    data['retailer_shop_image'] = this.retailerShopImage;
    data['retailer_mobile_number'] = this.retailerMobileNumber;
    data['retailer_name'] = this.retailerName;
    data['order_date'] = this.orderDate;
    return data;
  }
}

class NormalInventory {
  int? salesPersonInventoryId;
  int? totalQuantityTaken;
  String? typeName;
  String? productName;
  String? uomName;

  NormalInventory(
      {this.salesPersonInventoryId,
      this.totalQuantityTaken,
      this.typeName,
      this.productName,
      this.uomName});

  NormalInventory.fromJson(Map<String, dynamic> json) {
    salesPersonInventoryId = json['sales_person_inventory_id'];
    totalQuantityTaken = json['total_quantity_taken'];
    typeName = json['type_name'];
    productName = json['product_name'];
    uomName = json['uom_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sales_person_inventory_id'] = this.salesPersonInventoryId;
    data['total_quantity_taken'] = this.totalQuantityTaken;
    data['type_name'] = this.typeName;
    data['product_name'] = this.productName;
    data['uom_name'] = this.uomName;
    return data;
  }
}
