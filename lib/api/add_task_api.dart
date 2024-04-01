import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/utils/service.dart';

class UpdateTaskApi {
  final Map<String, dynamic> body;
  UpdateTaskApi(this.body);

  Future updateSetValue() async {
    ServiceWithHeaderWithbody service =
        ServiceWithHeaderWithbody(APIURL.UPDATE_TASK, body);
    var data = await service.postdatawithoutbody();
    return data;
  }
}
