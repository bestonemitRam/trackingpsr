import 'package:bmitserp/data/source/network/model/changepassword/ChangePasswordResponse.dart';
import 'package:bmitserp/repositories/changepasswordrepository.dart';
import 'package:flutter/cupertino.dart';

class ChangePasswordProvider with ChangeNotifier {
  ChangePasswordRepository repository = ChangePasswordRepository();

  Future<ChangePasswordResponse> changePassword(
      String old, String newPassword, String confirm) async {
    try {
      final response =
          await repository.changePassword(old, newPassword, confirm);

      return response;
    } catch (e) {
      throw e;
    }
  }
}
