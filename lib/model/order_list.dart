class OrderListModel {
  bool? status;
  dynamic message;
  List<OderListData>? result;

  OrderListModel({this.status, this.message, this.result});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <OderListData>[];
      json['result'].forEach((v) {
        result!.add(new OderListData.fromJson(v));
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

class OderListData {
  int? orderId;
  dynamic orderDate;
  dynamic status;
  List<OrderDetails>? orderDetails;

  OderListData({this.orderId, this.orderDate, this.status, this.orderDetails});

  OderListData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderDate = json['order_date'];
    status = json['status'];
    if (json['orderDetails'] != null) {
      orderDetails = <OrderDetails>[];
      json['orderDetails'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_date'] = this.orderDate;
    data['status'] = this.status;
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int? inventoryId;
  dynamic product;
  int? totalOrders;

  OrderDetails({this.inventoryId, this.product, this.totalOrders});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    inventoryId = json['inventory_id'];
    product = json['product'];
    totalOrders = json['total_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inventory_id'] = this.inventoryId;
    data['product'] = this.product;
    data['total_orders'] = this.totalOrders;
    return data;
  }
}
