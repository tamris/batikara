import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  var otpCode = ''.obs;

  void onOtpCompleted(String code) {
    otpCode.value = code;
    // Lakukan validasi OTP ke backend di sini
    print("OTP entered: $code");
  }
}
