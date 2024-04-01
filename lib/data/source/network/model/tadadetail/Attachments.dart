import 'package:bmitserp/data/source/network/model/tadadetail/File.dart';
import 'package:bmitserp/data/source/network/model/tadadetail/Image.dart';

class Attachments {
  List<File> file;
  List<Image> image;

  Attachments({required this.file, required this.image});

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return Attachments(
        file: (json['file'] as List).map((i) => File.fromJson(i)).toList(),
        image: (json['image'] as List).map((i) => Image.fromJson(i)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.file != null) {
      data['file'] = this.file.map((v) => v.toJson()).toList();
    }
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
