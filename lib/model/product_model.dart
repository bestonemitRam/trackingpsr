class ProdectModel {
  bool? status;
  dynamic message;
  List<ProductList>? result;

  ProdectModel({this.status, this.message, this.result});

  ProdectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <ProductList>[];
      json['result'].forEach((v) {
        result!.add(new ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  int? inventoryId;
  dynamic productName;
  dynamic availableQuantity;
  int? quantity;

  ProductList(
      {this.inventoryId,
      this.productName,
      this.availableQuantity,
      this.quantity});

  ProductList.fromJson(Map<String, dynamic> json) {
    inventoryId = json['inventory_id'];
    productName = json['productName'];
    availableQuantity = json['available_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inventory_id'] = this.inventoryId;
    data['productName'] = this.productName;
    data['available_quantity'] = this.availableQuantity;
    return data;
  }
}
