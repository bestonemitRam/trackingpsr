import 'dart:convert';
import 'dart:io';

import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:bmitserp/data/source/network/model/leaveissue/IssueLeaveResponse.dart';
import 'package:bmitserp/data/source/network/model/tadadetail/tadadetailresponse.dart';
import 'package:bmitserp/model/attachment.dart';
import 'package:bmitserp/utils/constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class EditTadaController extends GetxController {
  var fileList = [].obs;
  var attachmentList = <Attachment>[].obs;
  String id = "";
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final expensesController = TextEditingController();
  final key = GlobalKey<FormState>();

  void onFileClicked() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    final platformFile = result?.files.single;
    if (platformFile != null) {
      fileList.add(platformFile);
    }
  }

  showOptionDailog() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 60);
      if (image != null) {
        fileList.add(image);
      }
    } on Exception catch (e) {
      print("cxjkbjvkbsdjv" + e.toString());
    }
  }

  void checkForm(String id) {
    if (key.currentState!.validate()) {
      print("kdfhgjdfhgk");
      editTada(id);
    }
  }

  Future<String> getTadaDetail() async {
    var uri =
        Uri.parse(Constant.TADA_DETAIL_URL + "/${Get.arguments["tadaId"]}");

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    try {
      EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);
      final response = await http.get(
        uri,
        headers: headers,
      );
      debugPrint(response.body.toString());

      final responseData = json.decode(response.body);
      EasyLoading.dismiss(animation: true);

      if (response.statusCode == 200) {
        final tadaResponse = TadaDetailResponse.fromJson(responseData);

        final data = tadaResponse.data;
        final attachmentsdata = <Attachment>[];
        int count = 0;

        if (data != null && data.attachments != null) {
          for (var attachment in data!.attachments!) {
            count = count + 1;
            attachmentsdata
                .add(Attachment(count, attachment.pathLink!, "image"));
          }
        }

        // for (var attachment in data.attachments.file)
        //  {
        //   attachmentsdata
        //       .add(Attachment(attachment.id, attachment.url, "file"));
        // }

        print("dfgkjhkjhdf ${parse(data!.title!).body!.text}");

        titleController.text = parse(data!.title!).body!.text;
        descriptionController.text = parse(data.description).body!.text;
        expensesController.text = data.totalExpense!;
        attachmentList.value = attachmentsdata;
        id = data.id.toString();

        return "Loaded";
      } else {
        var errorMessage = responseData['message'];
        print(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      print(e);
      showToast(e.toString());
      throw e;
    }
  }

  Future<String> editTada(String id) async {
    try {
      var uri = Uri.parse(APIURL.TADA_UPDATE_URL + "$id");

      print("lfdgjhkfghjk ${uri}");

      Preferences preferences = Preferences();
      String token = await preferences.getToken();
      int getUserID = await preferences.getUserId();

      Map<String, String> headers = {
        'Accept': 'application/json; charset=UTF-8',
        'user_token': '$token',
        'user_id': '$getUserID',
      };

      if (fileList.isNotEmpty) {
        var requests = http.MultipartRequest('POST', uri);
        requests.headers.addAll(headers);

        requests.fields.addAll({
          "title": titleController.text,
          "description": descriptionController.text,
          "total_expense": expensesController.text,
        });

        for (var filed in fileList) {
          final file = File(filed.path!);
          final stream = http.ByteStream(Stream.castFrom(file.openRead()));
          final length = await file.length();

          final multipartFile = http.MultipartFile(
              'attachments[]', stream, length,
              filename: filed.name);
          requests.files.add(multipartFile);
        }

        EasyLoading.show(
            status: "Loading", maskType: EasyLoadingMaskType.black);
        final responseStream = await requests.send();

        final response = await http.Response.fromStream(responseStream);

        EasyLoading.dismiss(animation: true);
        debugPrint(response.toString());
        final responseData = json.decode(response.body);

        if (response.statusCode == 200) {
          print("fhjgjfgjk  ${response.statusCode}");

          showToast("Tada has been updated");
          Get.back();
          return "Loaded";
        } else {
          var errorMessage = responseData['message'];
          print(errorMessage);
          throw errorMessage;
        }
      } else {
        EasyLoading.show(
            status: "Loading", maskType: EasyLoadingMaskType.black);
        var response = await http.post(uri, headers: headers, body: {
          "title": titleController.text,
          "description": descriptionController.text,
          "total_expense": expensesController.text,
          'attachments[]': ''
        });

        EasyLoading.dismiss(animation: true);
        debugPrint(response.toString());
        final responseData = json.decode(response.body);
        print("fhjgddjfgjk  ${response.statusCode}");

        if (response.statusCode == 200) {
          showToast("Tada has been updated");
          Get.back();
          return "Loaded";
        } else {
          var errorMessage = responseData['message'];
          print(errorMessage);
          throw errorMessage;
        }
      }
    } catch (e) {
      showToast(e.toString());
      return "Failed";
    }
  }

  void removeItem(int index) {
    fileList.removeAt(index);
  }

  Future<void> removeAttachment(int id, int index) async {
    var uri = Uri.parse(Constant.TADA_DELETE_ATTACHMENT_URL + "/$id");

    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);
      final response = await http.get(
        uri,
        headers: headers,
      );

      EasyLoading.dismiss(animation: true);
      debugPrint(response.body.toString());

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final tadaResponse = IssueLeaveResponse.fromJson(responseData);

        attachmentList.removeAt(index);
      } else {
        EasyLoading.dismiss(animation: true);
        var errorMessage = responseData['message'];
        print(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  void onInit() {
    getTadaDetail();
    id = Get.arguments['tadaId'];
    super.onInit();
  }

  Future<void> launchUrls(String _url) async {
    if (!await launchUrl(Uri.parse(_url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> launchFile(String _url) async {
    if (!await launchUrl(Uri.file(_url))) {
      throw Exception('Could not launch $_url');
    }
  }
}
