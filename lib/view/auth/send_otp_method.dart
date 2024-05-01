import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/loading_dialog.dart';
import 'package:session_mate/view/auth/otp_verification_screen.dart';

Future<bool?> sendOtp(
    {required String phoneNumber,
    required BuildContext context,
    required bool isLoginScreen}) async {
  showLoadingDialog(context: context);
  FirebaseAuth auth = FirebaseAuth.instance;
  phoneCodeSent(String verificationID, [int? forceResendinToken]) {
    hideLoadingDialog(context: context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          verificationIDFinal: verificationID,
          isLoginScreen: isLoginScreen,
        ),
      ),
    );
  }

  try {
    await auth.verifyPhoneNumber(
        phoneNumber: "+91 $phoneNumber",
        timeout: const Duration(seconds: 100),
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException exception) {
          print('VERI FAILED :${exception.code}');
          print('VERI FAILED ERROR :$exception');
          hideLoadingDialog(context: context);
          // setLoader(false);
          if (exception.code == 'invalid-phone-number' ||
              exception.code == "missing-client-identifier") {
            // hideLoadingDialog(context: context);
            commonSnackBar(message: 'The provided phone number is not valid.');
          } else if (exception.code == "too-many-requests") {
            // hideLoadingDialog(context: context);
            commonSnackBar(
                message:
                    'We have blocked all requests from this device due to unusual activity. Try again later.');
          }
        },
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: (String verificationId) {});
  } catch (e) {
    commonSnackBar(message: "Something went wrong, try Again!");
  }
  return null;
}
