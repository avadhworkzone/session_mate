import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_enum.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/regex.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/utils/typedef_utils.dart' as tpdf;

typedef OnChangeString = void Function(String value);

class CommonTextField extends StatelessWidget {
  final TextEditingController? textEditController;
  final String? title;
  final String? initialValue;
  final bool? isValidate;
  final bool? readOnly;
  final TextInputType? keyBoardType;
  final ValidationTypeEnum? validationType;
  final String regularExpression;
  final int? inputLength;
  final String? hintText;
  final String? validationMessage;
  final String? preFixIconPath;
  final int? maxLine;
  final int? maxLength;
  final Widget? sIcon;
  final Widget? pIcon;
  final bool? obscureValue;
  final bool? isCapitalize;
  final bool? underLineBorder;
  final bool? showLabel;
  final OnChangeString? onChange;
  final tpdf.OnTapTextField? onTap;
  final Color? borderColor;
  final Color? hintTextColor;
  final Color? fillColor;
  final double? borderWidth;
  final FontWeight? hintFontWeight;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final TextStyle? style;
  final Color? cursorColor;
  final TextInputAction? textInputAction;
  final TextInputFormatter? lowerCaseFormatter;

  const CommonTextField({
    super.key,
    this.validator,
    required this.regularExpression,
    this.title,
    this.textEditController,
    this.isValidate = true,
    this.isCapitalize = false,
    this.keyBoardType,
    this.validationType,
    this.inputLength,
    this.readOnly = false,
    this.underLineBorder = false,
    this.showLabel = false,
    this.hintText,
    this.validationMessage,
    this.maxLine,
    this.sIcon,
    this.pIcon,
    this.maxLength,
    this.preFixIconPath,
    this.onChange,
    this.initialValue = '',
    this.obscureValue,
    this.onTap,
    this.borderColor,
    this.hintTextColor,
    this.fillColor,
    this.borderWidth,
    this.hintFontWeight,
    this.contentPadding,
    this.style,
    this.cursorColor,
    this.textInputAction,
    this.lowerCaseFormatter,
  });

  /// PLEASE IMPORT GET X PACKAGE
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null || title!.isEmpty
            ? const SizedBox.shrink()
            : CustomText(
                title ?? '',
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black1c.withOpacity(0.8),
              ),
        title == null || title!.isEmpty
            ? const SizedBox.shrink()
            : const SizedBox.shrink(),
        SizedBox(
          width: Get.width,
          child: TextFormField(
            controller: textEditController,
            maxLength: maxLength,
            onTap: onTap,
            style: style ??
                TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.black,
                    fontFamily: AppConstants.inter,
                    fontWeight: FontWeight.w400),
            keyboardType: keyBoardType ?? TextInputType.text,
            maxLines: maxLine ?? 1,
            textCapitalization: isCapitalize!
                ? TextCapitalization.characters
                : TextCapitalization.sentences,
            inputFormatters: [
              LengthLimitingTextInputFormatter(inputLength),
              FilteringTextInputFormatter.allow(RegExp(regularExpression.tr)),
              NoLeadingSpaceFormatter(),
              lowerCaseFormatter ?? TextFormatter(),
            ],
            obscureText: validationType == ValidationTypeEnum.password
                ? obscureValue!
                : false,
            obscuringCharacter: '*',
            onChanged: onChange,
            enabled: !readOnly!,
            readOnly: readOnly!,
            validator: (value) {
              return isValidate == false
                  ? null
                  : value!.isEmpty
                      ? validationMessage ?? AppStrings.isRequired
                      : validationType == ValidationTypeEnum.email
                          ? ValidationMethod.validateEmail(value)
                          : null;
            },
            textInputAction: textInputAction,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: cursorColor ?? AppColors.black1c,
            cursorWidth: 1.5,
            decoration: InputDecoration(
              isDense: true,
              fillColor: fillColor ?? Colors.transparent,
              filled: true,
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 17.h),
              hintText: hintText!.tr,
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          borderColor ?? AppColors.black1c.withOpacity(0.4))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          borderColor ?? AppColors.black1c.withOpacity(0.4))),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          borderColor ?? AppColors.black1c.withOpacity(0.4))),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          borderColor ?? AppColors.black1c.withOpacity(0.4))),
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LocalAssets(
                    imagePath: preFixIconPath ?? '',
                  ),
                  SizeConfig.sW8,
                  Container(
                    color: AppColors.black1c.withOpacity(0.3),
                    height: 17,
                    width: 1,
                  ),
                  SizeConfig.sW8,
                ],
              ),
              suffixIcon: sIcon,
              prefixIconConstraints: BoxConstraints(maxWidth: 50.w),
              suffixIconConstraints: BoxConstraints(maxWidth: 50.w),
              counterText: ''.tr,
              // filled: true,
              // fillColor: ColorUtils.greyE7,
              labelStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w600),
              hintStyle: TextStyle(
                color: hintTextColor ?? AppColors.black1c.withOpacity(0.5),
                fontSize: 14.sp,
                fontFamily: AppConstants.inter,
                fontWeight: hintFontWeight ?? FontWeight.normal,
              ),
              errorMaxLines: 2,
            ),
          ),
        ),
      ],
    );
  }
}

class CommonReadableTextField extends StatelessWidget {
  final TextEditingController? textEditController;
  final String? title;
  final String? initialValue;
  final bool? isValidate;
  final bool? readOnly;
  final TextInputType? keyBoardType;
  final ValidationTypeEnum? validationType;
  final String regularExpression;
  final int? inputLength;
  final String? hintText;
  final String? validationMessage;
  final String? preFixIconPath;
  final int? maxLine;
  final int? maxLength;
  final Widget? sIcon;
  final Widget? pIcon;
  final bool? obscureValue;
  final bool? isCapitalize;
  final bool? underLineBorder;
  final bool? showLabel;
  final OnChangeString? onChange;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Color? hintTextColor;
  final Color? fillColor;
  final double? borderWidth;
  final FontWeight? hintFontWeight;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final TextStyle? style;
  final Color? cursorColor;
  final TextInputAction? textInputAction;

  const CommonReadableTextField({
    super.key,
    this.validator,
    required this.regularExpression,
    this.title,
    this.textEditController,
    this.isValidate = true,
    this.isCapitalize = false,
    this.keyBoardType,
    this.validationType,
    this.inputLength,
    this.readOnly = false,
    this.underLineBorder = false,
    this.showLabel = false,
    this.hintText,
    this.validationMessage,
    this.maxLine,
    this.sIcon,
    this.pIcon,
    this.maxLength,
    this.preFixIconPath,
    this.onChange,
    this.initialValue = '',
    this.obscureValue,
    this.onTap,
    this.borderColor,
    this.hintTextColor,
    this.fillColor,
    this.borderWidth,
    this.hintFontWeight,
    this.contentPadding,
    this.style,
    this.cursorColor,
    this.textInputAction,
  });

  /// PLEASE IMPORT GET X PACKAGE
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.width,
          child: TextFormField(
            controller: textEditController,
            maxLength: maxLength,
            style: style ??
                TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.black,
                    fontFamily: AppConstants.inter,
                    fontWeight: FontWeight.w400),
            keyboardType: keyBoardType ?? TextInputType.text,
            maxLines: maxLine ?? 1,
            textCapitalization: isCapitalize!
                ? TextCapitalization.characters
                : TextCapitalization.sentences,
            inputFormatters: [
              LengthLimitingTextInputFormatter(inputLength),
              FilteringTextInputFormatter.allow(RegExp(regularExpression.tr)),
              NoLeadingSpaceFormatter(),
            ],
            obscureText: validationType == ValidationTypeEnum.password
                ? obscureValue!
                : false,
            obscuringCharacter: '*',
            onChanged: onChange,
            enabled: !readOnly!,
            readOnly: true,
            validator: (value) {
              return isValidate == false
                  ? null
                  : value!.isEmpty
                      ? validationMessage ?? AppStrings.isRequired
                      : validationType == ValidationTypeEnum.email
                          ? ValidationMethod.validateEmail(value)
                          // : validationType == ValidationTypeEnum.name
                          //     ? ValidationMethod.validateName(value)
                          //     : validationType == ValidationTypeEnum.address
                          //         ? ValidationMethod.validateAddress(value)
                          : null;
            },
            textInputAction: textInputAction,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: cursorColor ?? AppColors.black1c,
            cursorWidth: 1.5,
            decoration: InputDecoration(
              isDense: true,
              fillColor: fillColor ?? Colors.transparent,
              filled: true,
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 17.h),
              hintText: hintText!.tr,
              // errorBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: AppColors.white),
              //     borderRadius: BorderRadius.circular(10.r)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          borderColor ?? AppColors.black1c.withOpacity(0.4))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          borderColor ?? AppColors.black1c.withOpacity(0.4))),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          borderColor ?? AppColors.black1c.withOpacity(0.4))),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          borderColor ?? AppColors.black1c.withOpacity(0.4))),

              suffixIcon: sIcon,
              prefixIconConstraints: BoxConstraints(maxWidth: 50.w),
              suffixIconConstraints: BoxConstraints(maxWidth: 50.w),
              counterText: ''.tr,
              // filled: true,
              // fillColor: ColorUtils.greyE7,
              labelStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w600),
              hintStyle: TextStyle(
                color: hintTextColor ?? AppColors.black1c.withOpacity(0.5),
                fontSize: 14.sp,
                fontFamily: AppConstants.inter,
                fontWeight: hintFontWeight ?? FontWeight.normal,
              ),
              errorMaxLines: 2,
            ),
          ),
        ),
      ],
    );
  }
}

///COMMON ROUNDED TEXTFIELD
commonRoundedTextField(
    {required String text,
    required TextEditingController textEditingController,
    void Function(String)? onChanged}) {
  return SizedBox(
    width: Get.width / 1.5,
    child: TextFormField(
      onChanged: onChanged,
      controller: textEditingController,
      cursorColor: AppColors.white,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 15.w),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: AppColors.white,
                width: 1.5,
              )),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: AppColors.white,
                width: 1.5,
              )),
          hintText: text,
          hintStyle: TextStyle(color: AppColors.white)),
    ),
  );
}
