import 'package:get/get.dart';
import '/data/network_caller/network_caller.dart';
import '/data/network_caller/network_response.dart';
import '/data/utility/urls.dart';

class ForgetPasswordController extends GetxController {
  bool _requestInProgress = false;
  String _failedMessage = '';
  String _email = '';
  String _otp = '';

  bool get loginInProgress => _requestInProgress;
  String get failureMessage => _failedMessage;
  String get email => _email;
  String get otp => _otp;

  Future<bool> sendEmail(String email) async {
    _requestInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().getRequest("${Urls.verifyEmail}/$email");
    _requestInProgress = false;
    update();
    if (response.isSuccess) {
      _email = email;
      return true;
    } else {
      _failedMessage = response.errorMessage ?? '';
    }
    return false;
  }

  Future<bool> sendOTP(String otp) async {
    _requestInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller()
        .getRequest("${Urls.recoverVerifyOTP}/$email/$otp");
    _requestInProgress = false;
    update();
    if (response.isSuccess) {
      _otp = otp;
      return true;
    } else {
      _failedMessage = response.errorMessage ?? '';
    }
    return false;
  }

  Future<bool> changePassword(String otp) async {
    _requestInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller()
        .getRequest("${Urls.recoverVerifyOTP}/$email/$otp");
    _requestInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      _failedMessage = response.errorMessage ?? '';
    }
    return false;
  }
}
