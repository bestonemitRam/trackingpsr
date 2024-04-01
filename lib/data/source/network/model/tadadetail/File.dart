class File {
    int id;
    String url;

    File({required this.id,required this.url});

    factory File.fromJson(Map<String, dynamic> json) {
        return File(
            id: json['id'], 
            url: json['url'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['url'] = this.url;
        return data;
    }
}