class DataModel {
  final String inventory_id;
  final String total_orders;

  DataModel({required this.inventory_id, required this.total_orders});

  Map<String, dynamic> toJson() {
    return {
      'inventory_id': inventory_id,
      'total_orders': total_orders,
    };
  }
}
