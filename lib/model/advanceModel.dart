class Advance {
  final String id;
 

  Advance({ required this.id});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
     
    };
  }
}
