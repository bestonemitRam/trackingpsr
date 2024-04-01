class Image {
    int id;
    String url;

    Image({required this.id,required this.url});

    factory Image.fromJson(Map<String, dynamic> json) {
        return Image(
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