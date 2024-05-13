import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/modal/user_model.dart';
import 'package:session_mate/service/auth_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/loading_dialog.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/bottomBar/bottom_bar_screen.dart';
import 'package:session_mate/viewModel/otp_view_model.dart';
import 'package:session_mate/viewModel/sign_in_view_model.dart';
import 'package:session_mate/viewModel/sign_up_view_model.dart';

class OtpVerificationScreen extends StatefulWidget {
  OtpVerificationScreen(
      {super.key,
      required this.verificationIDFinal,
      required this.isLoginScreen,
      required this.countryCode,
      required this.phoneNumber});

  String verificationIDFinal;
  String countryCode;
  String phoneNumber;
  bool isLoginScreen;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  OtpViewModel otpViewModel = Get.find();
  SignUpViewModel signUpViewModel = Get.put(SignUpViewModel());
  SignInViewModel signInViewModel = Get.put(SignInViewModel());

  // SignUpViewModel signUpViewModel = Get.find();
  // SignInViewModel signInViewModel = Get.find();
  UserModel model = UserModel();

  @override
  void initState() {
    otpViewModel.startTimer();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    otpViewModel.stopTimer();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          otpViewModel.pinPutController.value.clear();
          return Future.value(true);
        },
        child: Material(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
            child: Obx(() {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // const Icon(Icons.arrow_back_ios),
                        CustomText(
                          AppStrings.verification,
                          fontWeight: FontWeight.w500,
                          fontSize: 26.sp,
                        ),
                        SizedBox(
                          width: 20.w,
                        )
                      ],
                    ),
                  ),
                  SizeConfig.sH20,
                  LocalAssets(
                    imagePath: AppImageAssets.otpVerificationImage,
                    height: Get.width / 1.5,
                    width: Get.width / 1.5,
                  ),
                  CustomText(
                    AppStrings.otpVerificationTxt,
                    fontSize: 16.sp,
                    textAlign: TextAlign.center,
                  ),
                  SizeConfig.sH10,
                  CustomText('+${widget.countryCode} - ${widget.phoneNumber}',
                      fontWeight: FontWeight.w600, fontSize: 15.sp),
                  SizeConfig.sH50,
                  Pinput(
                    // validator: (val) => ValidationMethod.validateOtp(val),
                    controller: otpViewModel.pinPutController.value,
                    length: 6,
                    showCursor: true,
                    keyboardType: TextInputType.number,
                    defaultPinTheme: PinTheme(
                        height: 45.h,
                        width: 45.w,
                        textStyle: TextStyle(fontSize: 15.sp),
                        decoration: BoxDecoration(
                            color: AppColors.whiteF6,
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(color: AppColors.primaryColor))),
                    onChanged: (val) {},
                  ),
                  SizeConfig.sH35,
                  if (int.parse(otpViewModel
                          .strDigits(otpViewModel.myDuration.value.inSeconds.remainder(60))
                          .value) >
                      0)
                    CustomText(
                      '${otpViewModel.strDigits(otpViewModel.myDuration.value.inMinutes.remainder(60))}:${otpViewModel.strDigits(otpViewModel.myDuration.value.inSeconds.remainder(60))}',
                      fontWeight: FontWeight.w600,
                      color: AppColors.black1c,
                    ),
                  SizeConfig.sH15,
                  CustomText(
                    AppStrings.otpNotReceivedTxt,
                    color: AppColors.black.withOpacity(0.30),
                    fontSize: 16.sp,
                  ),
                  SizeConfig.sH5,
                  int.parse(otpViewModel
                              .strDigits(otpViewModel.myDuration.value.inSeconds.remainder(60))
                              .value) >
                          0
                      ? CustomText(
                          AppStrings.sendAgainAfterTxt,
                          color: AppColors.primaryColor.withOpacity(0.30),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        )
                      : InkWell(
                          onTap: () {
                            reSendOtp();
                          },
                          child: CustomText(
                            AppStrings.sendAgainTxt,
                            color: AppColors.primaryColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  SizeConfig.sH10,
                  CustomBtn(
                      onTap: () {
                        verifyOtp();
                      },
                      title: AppStrings.submit)
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  /// verify otp method
  Future<void> verifyOtp() async {
    try {
      if (otpViewModel.pinPutController.value.text.isEmpty) {
        commonSnackBar(message: "Please enter otp");
        return;
      }
      showLoadingDialog(context: context);

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationIDFinal ?? '',
          smsCode: otpViewModel.pinPutController.value.text);
      FirebaseAuth _auth = FirebaseAuth.instance;
      final User? user = (await _auth.signInWithCredential(credential)).user;

      if (user != null) {
        print(FirebaseAuth.instance.currentUser!.phoneNumber);
        if (widget.isLoginScreen) {
          commonSnackBar(message: AppStrings.loginSuccessfully);
          await SharedPreferenceUtils.setIsLogin(true);
          await SharedPreferenceUtils.setUserId(signInViewModel.signInPhoneNoController.value.text);
          signInViewModel.signInEmailController.value.clear();
          signInViewModel.signInPhoneNoController.value.clear();
          signInViewModel.signInPasswordController.value.clear();
          hideLoadingDialog(context: context);
          CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).update({
            "latitude": SharedPreferenceUtils.getLatitude(),
            "longitude": SharedPreferenceUtils.getLongitude()
          });
          Get.offAll(() => const BottomBar());
          // onLoginTap();
        } else {
          hideLoadingDialog(context: context);
          signUpOnTap();
        }

        // await AuthServices.deleteBlockedUser(number: widget.phoneNumber);
        // await authServices.signIn(context: context);
      } else {
        print("Authentication failed");
        hideLoadingDialog(context: context);
      }
    } on FirebaseAuthException catch (e) {
      hideLoadingDialog(context: context);
      if (e.code == "invalid-verification-code") {
        // if (remainingAttempt == 0) {
        //   final status =
        //       await AuthServices.addBlockedUser(number: widget.phoneNumber);
        //   if (status) {
        //     Functions.toast("Your number is blocked, try after 24 hours");
        //   }
        //
        //   print(e.toString());
        //   return;
        // }
        // commonSnackBar(
        //     message: "Invalid Otp, $remainingAttempt attempts remaining");
        print('frg yhythjuyjh${e.toString()}');
      } else {
        commonSnackBar(message: e.toString());
        print('invalid code === ${e.code}');
      }
    }
  }

  /// sign up
  signUpOnTap() async {
    model.email = signUpViewModel.signUpEmailController.value.text;
    model.mobileNumber = signUpViewModel.signUpPhoneNoController.value.text;
    model.password = signUpViewModel.signUpPasswordController.value.text;
    model.subscriptionType = AppStrings.freeSubscription;
    model.isSubscription = false;
    model.latitude = SharedPreferenceUtils.getLatitude();
    model.longitude = SharedPreferenceUtils.getLongitude();
    model.subscriptionStartDate =
        "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : "${DateTime.now().month}"}-${DateTime.now().day < 10 ? "0${DateTime.now().day}" : "${DateTime.now().day}"}";
    model.subscriptionEndDate =
        "${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : "${DateTime.now().month}"}-${DateTime.now().day < 10 ? "0${DateTime.now().day}" : "${DateTime.now().day}"}";
    print(model.subscriptionStartDate);
    print(model.subscriptionEndDate);
    showLoadingDialog(context: context);

    final checkUserExistStatus = await AuthService.checkUserExist(model.mobileNumber!);
    if (checkUserExistStatus) {
      /// LOADING FALSE
      /// SHOW TOAST M<SG USER ALREADY EXIST
      hideLoadingDialog(context: context);
      commonSnackBar(message: AppStrings.userExistError);
      return;
    }
    final status = await AuthService.signUp(model);
    if (status) {
      commonSnackBar(message: AppStrings.loginSuccessfully);
      hideLoadingDialog(context: context);
      // PreferenceManagerUtils.setUserId(model.mobileNumber ?? '');
      // PreferenceManagerUtils.setLoginExist('true');
      // Get.offAll(() => DoctorSelectionScreen());
      await SharedPreferenceUtils.setIsLogin(true);
      await SharedPreferenceUtils.setUserId(signUpViewModel.signUpPhoneNoController.value.text);
      Get.to(() => const BottomBar());
    } else {
      hideLoadingDialog(context: context);
      commonSnackBar(message: AppStrings.userExistError);
    }
  }

  /// resend otp
  Future<bool?> reSendOtp() async {
    showLoadingDialog(context: context);
    FirebaseAuth auth = FirebaseAuth.instance;
    phoneCodeSent(String verificationID, [int? forceResendinToken]) {
      hideLoadingDialog(context: context);
      widget.verificationIDFinal = '$verificationID';
      otpViewModel.resetTimer();
    }

    try {
      await auth.verifyPhoneNumber(
          phoneNumber: "+${widget.countryCode} ${widget.phoneNumber}",
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
}
