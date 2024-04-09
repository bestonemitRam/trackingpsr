import 'dart:convert';
import 'dart:ffi';
import 'dart:io';


import 'package:bmitserp/api/apiConstant.dart';
import 'package:bmitserp/data/source/datastore/preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart'; // Add this import

class RetailerController extends GetxController {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  Rx<File?> imageFile = Rx<File?>(null);
  RxString currentAddress = RxString('');
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;

  Future<void> pickImage() async {
    addressController.clear();
    fetchCurrentAddress();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> fetchCurrentAddress() async {
    try {
      Position position = await _getCurrentLocation();
      lat.value = position.latitude;
      long.value = position.longitude;
      String address = await _getAddressFromCoordinates(position);
      ditributorData.text = address;
      addressController.text = address;
    } catch (e) {
      currentAddress.value = 'Unable to fetch address';
      ditributorData.text = 'Unable to fetch address';
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied';
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> _getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude ?? 0.0, position.longitude ?? 0.0);
    
      Placemark place = placemarks[0];
      return "${place.street}, ${place.subThoroughfare} ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country},  ${place.isoCountryCode} ,${place.name}, ${place.subAdministrativeArea} , ${place.thoroughfare}";
    } catch (e) {
      return "Address not found";
    }
  }

  Future<bool> RegisterRetailer() async {
    var uri = Uri.parse(APIURL.CREATE_RETAILER);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    dynamic response;
    try {
      if (imageFile.value!.path != '') {
        EasyLoading.show(
            status: "Created..", maskType: EasyLoadingMaskType.black);

        var request = http.MultipartRequest('POST', uri);
        Map<String, String> headers = {
          'Accept': 'application/json; charset=UTF-8',
          'user_token': '$token',
          'user_id': '$getUserID',
        };

        request.headers.addAll(headers);

        final file = await http.MultipartFile.fromPath(
            'retailer_shop_image', imageFile.value!.path);
        request.files.add(file);
        request.fields['retailer_latitude'] = lat.toString();
        request.fields['retailer_longitude'] = long.toString();
        request.fields['retailer_mobile_number'] =
            contactController.text.trim();
        request.fields['retailer_name'] = nameController.text.trim();
        request.fields['retailer_data'] = addressController.text.trim();

        try {
          final streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse)
              .timeout(Duration(seconds: 60));
          var out = jsonDecode(response.body);
          if (response.statusCode == 201) {
            EasyLoading.dismiss(animation: true);
            Fluttertoast.showToast(
                msg: "Retailer  created successfully !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
            nameController.clear();
            contactController.clear();
            addressController.clear();
            imageFile.value = null;
            lat.close();
            long.close();

            return true;
          } else {
            EasyLoading.dismiss(animation: true);
            Fluttertoast.showToast(
                msg: "${out['message']}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
            return false;
          }
        } catch (e) {
          EasyLoading.dismiss(animation: true);
          // Fluttertoast.showToast(
          //     msg: "Something went wrong! Please try again",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIosWeb: 1,
          //     fontSize: 16.0);
      
        }

        return Future.error('error');
      } else {
        EasyLoading.dismiss(animation: true);
        return false;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<bool> editRetailer(String id) async {

    var uri = Uri.parse(APIURL.RETAILER_UPDATE + "${id}");

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    dynamic response;
    try {
      EasyLoading.show(
          status: "Updating..", maskType: EasyLoadingMaskType.black);

      var request = http.MultipartRequest('POST', uri);
      Map<String, String> headers = {
        'Accept': 'application/json; charset=UTF-8',
        'user_token': '$token',
        'user_id': '$getUserID',
      };

      request.headers.addAll(headers);
      if (imageFile.value != null) {
        final file = await http.MultipartFile.fromPath(
            'retailer_shop_image', imageFile.value!.path);
        request.files.add(file);
      }

      request.fields['retailer_latitude'] = lat.toString();
      request.fields['retailer_longitude'] = long.toString();
      request.fields['retailer_mobile_number'] = contactController.text.trim();
      request.fields['retailer_name'] = nameController.text.trim();
      request.fields['retailer_data'] = addressController.text.trim();

      try {
        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);
        var out = jsonDecode(response.body);

        if (response.statusCode == 201) {
          EasyLoading.dismiss(animation: true);
          Fluttertoast.showToast(
              msg: "Retailer  Updated Successfully !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          nameController.clear();
          contactController.clear();
          addressController.clear();
          imageFile.value = null;
          lat.close();
          long.close();

          return true;
        } else {
          EasyLoading.dismiss(animation: true);
          Fluttertoast.showToast(
              msg: "${out['message']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          return false;
        }
      } catch (e) {
        EasyLoading.dismiss(animation: true);
        // Fluttertoast.showToast(
        //     msg: "Something went wrong! Please try again",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     fontSize: 16.0);
      
      }

      return Future.error('error');
    } catch (error) {
      EasyLoading.dismiss(animation: true);
      throw error;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    addressController.dispose();
    imageFile.close();
    lat.close();
    long.close();

    super.dispose();
  }
  ////////////////////////////////////// create distributors ///////////

  Rx<File?> distributorProfile = Rx<File?>(null);

  Future<void> pickDisImage() async {
    ditributorData.clear();
    fetchCurrentAddress();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      distributorProfile.value = File(pickedFile.path);
    }
  }

  Rx<File?> cancelCheque = Rx<File?>(null);
  Future<void> cancelchequeDisImage() async {
   
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      cancelCheque.value = File(pickedFile.path);
    }
  }

  Rx<File?> pancardImage = Rx<File?>(null);
  Future<void> pancard() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      pancardImage.value = File(pickedFile.path);
    }
  }

  Rx<File?> aadhImagefront = Rx<File?>(null);
  Future<void> picAadharfront() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      aadhImagefront.value = File(pickedFile.path);
    }
  }

  Rx<File?> aadhImagefback = Rx<File?>(null);
  Future<void> picAadharback() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      aadhImagefback.value = File(pickedFile.path);
    }
  }

  final ditributorData = TextEditingController();
  final disNameController = TextEditingController();
  final disemailController = TextEditingController();
  final discontactController = TextEditingController();
  final disgstNumberController = TextEditingController();
  final disOrgNameController = TextEditingController();

  var fileList = [].obs;
  final key = GlobalKey<FormState>();

  Future<void> addDocument() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      fileList.add(pickedFile);
    }
  }

  Future<bool> createrDistributor() async {
    var uri = Uri.parse(APIURL.CREATE_DISTRIBUTOR);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    dynamic response;
    try {
      if (distributorProfile.value != null) {
        EasyLoading.show(
            status: "Created..", maskType: EasyLoadingMaskType.black);

        var request = http.MultipartRequest('POST', uri);
        Map<String, String> headers = {
          'Accept': 'application/json; charset=UTF-8',
          'user_token': '$token',
          'user_id': '$getUserID',
        };

        if (distributorProfile.value != null) {
          request.headers.addAll(headers);
          final file = await http.MultipartFile.fromPath(
              'distributor_avatar', distributorProfile.value!.path);
          request.files.add(file);
        }
        if (cancelCheque.value != null) {
        
          request.headers.addAll(headers);
          final file = await http.MultipartFile.fromPath(
              'cancel_cheque_image', cancelCheque.value!.path);
          request.files.add(file);
        }
        if (pancardImage.value != null) {
      
          request.headers.addAll(headers);
          final file = await http.MultipartFile.fromPath(
              'pancard_image', pancardImage.value!.path);
          request.files.add(file);
        }
        if (aadhImagefront.value != null) {
        
          request.headers.addAll(headers);
          final file = await http.MultipartFile.fromPath(
              'aadharcard_image_front', aadhImagefront.value!.path);
          request.files.add(file);
        }
        if (aadhImagefback.value != null) {
        
          request.headers.addAll(headers);
          final file = await http.MultipartFile.fromPath(
              'aadharcard_image_back', aadhImagefback.value!.path);
          request.files.add(file);
        }

        if (fileList.isNotEmpty) {
          for (var filed in fileList) {
            final file = File(filed.path!);
            final stream = http.ByteStream(Stream.castFrom(file.openRead()));
            final length = await file.length();

            final multipartFile = http.MultipartFile(
                'appointment_form[]', stream, length,
                filename: filed.name);
            request.files.add(multipartFile);
          }
        }
        request.fields['distributor_org_name'] =
            disOrgNameController.text.trim();
        request.fields['distributor_data'] = ditributorData.text.trim();
        request.fields['distributor_latitude'] = lat.toString();
        request.fields['distributor_longitude'] = long.toString();
        request.fields['name'] = disNameController.text.trim();
        request.fields['mail'] = disemailController.text.trim();
        request.fields['contact_number'] = discontactController.text.trim();
        request.fields['gst_no'] = disgstNumberController.text.trim();

        try {
          final streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse)
              .timeout(Duration(seconds: 60));
         

          var out = jsonDecode(response.body);

          if (response.statusCode == 201) {
            Fluttertoast.showToast(
                msg: "Distributor  created successfully !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
            nameController.clear();
            contactController.clear();
            addressController.clear();
            imageFile.value = null;
            lat.close();
            long.close();
            EasyLoading.dismiss(animation: true);
            return true;
          } else {
            EasyLoading.dismiss(animation: true);
            Fluttertoast.showToast(
                msg: "${out['message']}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
            return false;
          }
        } catch (e) {
          EasyLoading.dismiss(animation: true);
          Fluttertoast.showToast(
              msg: "Something went wrong! Please try again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        }

        return Future.error('error');
      } else {
        EasyLoading.dismiss(animation: true);
        Fluttertoast.showToast(
            msg: "Something went wrong! Please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        return false;
      }
    } catch (error) {
      EasyLoading.dismiss(animation: true);
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      throw error;
    }
  }

  Future<bool> editDistributor(String id) async {
    var uri = Uri.parse(APIURL.DISTRIBUTORS_UPDATE + "${id}");

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    bool result = await InternetConnectionChecker().hasConnection;

    dynamic response;
    try {
      if (result == true)
       {
        {
          EasyLoading.show(
              status: "Created..", maskType: EasyLoadingMaskType.black);
          var request = http.MultipartRequest('POST', uri);
          Map<String, String> headers = {
            'Accept': 'application/json; charset=UTF-8',
            'user_token': '$token',
            'user_id': '$getUserID',
          };
          request.headers.addAll(headers);

          if (distributorProfile.value != null) {
            final file = await http.MultipartFile.fromPath(
                'distributor_avatar', distributorProfile.value!.path);
            request.files.add(file);
          }
          if (cancelCheque.value != null) {
        
            final file = await http.MultipartFile.fromPath(
                'cancel_cheque_image', cancelCheque.value!.path);
            request.files.add(file);
          }
          if (pancardImage.value != null) {
            final file = await http.MultipartFile.fromPath(
                'pancard_image', pancardImage.value!.path);
            request.files.add(file);
          }
          if (aadhImagefront.value != null) {
            final file = await http.MultipartFile.fromPath(
                'aadharcard_image_front', aadhImagefront.value!.path);
            request.files.add(file);
          }
          if (aadhImagefback.value != null) {
            final file = await http.MultipartFile.fromPath(
                'aadharcard_image_back', aadhImagefback.value!.path);
            request.files.add(file);
          }

          if (fileList.isNotEmpty) {
            for (var filed in fileList) {
        
              final file = File(filed.path!);
              final stream = http.ByteStream(Stream.castFrom(file.openRead()));
              final length = await file.length();

              final multipartFile = http.MultipartFile(
                  'appointment_form[]', stream, length,
                  filename: filed.name);
              request.files.add(multipartFile);
            }
          }

          request.fields.addAll({
            'distributor_org_name': disOrgNameController.text.trim(),
            'distributor_data': ditributorData.text.trim(),
            'distributor_latitude': lat.toString(),
            'distributor_longitude': long.toString(),
            'name': disNameController.text.trim(),
            'mail': disemailController.text.trim(),
            'contact_number': discontactController.text.trim(),
            'gst_no': disgstNumberController.text.trim(),
          });

        
          try {
            final streamedResponse = await request.send();
            final response = await http.Response.fromStream(streamedResponse);
            var out = jsonDecode(response.body);
           
          
        
         if (response.statusCode == 201)
             {
              Fluttertoast.showToast(
                  msg: "Distributor Updated successfully !",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  fontSize: 16.0);

              nameController.clear();
              contactController.clear();
              addressController.clear();
              imageFile.value = null;
              lat.close();
              long.close();
              EasyLoading.dismiss(animation: true);
              return true;
            } 
            else 
            {
              EasyLoading.dismiss(animation: true);
              Fluttertoast.showToast(
                  msg: "Please Update any field",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  fontSize: 16.0);
              
              return false;
            }
          } catch (e) {
            EasyLoading.dismiss(animation: true);
            Fluttertoast.showToast(
                msg: "Please change any thing",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          }

          return Future.error('error');
        }
      } else {
        EasyLoading.dismiss(animation: true);
        Fluttertoast.showToast(
            msg: "Please Check Your Internet connection's !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        return false;
      }
    } catch (error) {
      EasyLoading.dismiss(animation: true);
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      throw error;
    }
  }


}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 12);
}
