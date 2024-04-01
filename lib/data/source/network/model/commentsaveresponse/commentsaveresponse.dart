import '../commentsaveresponse/Data.dart';

class commentsaveresponse {
    Data data;
    String message;
    bool status;
    int status_code;

    commentsaveresponse({required this.data,required this.message,required this.status,required this.status_code});

    factory commentsaveresponse.fromJson(Map<String, dynamic> json) {
        return commentsaveresponse(
            data: Data.fromJson(json['data']),
            message: json['message'], 
            status: json['status'], 
            status_code: json['status_code'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['status'] = this.status;
        data['status_code'] = this.status_code;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}