class Attachment {
  String attachment_url;
  String extension;
  String type;

  Attachment(
      {required this.attachment_url,
      required this.extension,
      required this.type});

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      attachment_url: json['attachment_url'],
      extension: json['extension'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attachment_url'] = this.attachment_url;
    data['extension'] = this.extension;
    data['type'] = this.type;
    return data;
  }
}
