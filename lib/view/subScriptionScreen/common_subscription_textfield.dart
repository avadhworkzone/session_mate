import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_enum.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/regex.dart';

class CommonSubscriptionTextField extends StatefulWidget {
  final double? height;
  final double? width;
  final String? hintText;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? isValidate;
  final String? validationMessage;
  final ValidationTypeEnum? validationType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final Color? focusedBorderColor;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
   const CommonSubscriptionTextField({super.key, this.hintText, this.controller, this.keyboardType, this.validator, this.isValidate = true, this.validationMessage, this.validationType, this.prefixIcon, this.focusedBorderColor, this.labelText, this.labelStyle, this.height, this.width, this.focusNode, this.onChanged, this.suffixIcon, this.prefix, this.suffix, this.onFieldSubmitted});

  @override
  State<CommonSubscriptionTextField> createState() => _CommonSubscriptionTextFieldState();
}

class _CommonSubscriptionTextFieldState extends State<CommonSubscriptionTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 42.66.h,
      width: widget.width ?? 295.w,
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged ,
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: (value) {
          return widget.isValidate == false
              ? null
              : value!.isEmpty
              ? widget.validationMessage ?? AppStrings.isRequired
              : widget.validationType == ValidationTypeEnum.email
              ? ValidationMethod.validateEmail(value)
          : widget.validationType == ValidationTypeEnum.name
              ? ValidationMethod.validateName(value)
              : widget.validationType == ValidationTypeEnum.address
                  ? ValidationMethod.validateAddress(value)
              : null;
        },
        style:  TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          fontFamily: AppConstants.poppins,
          color: AppColors.black1c,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 12.w),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(
                color: AppColors.subscriptionBorderColor
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
                color: widget.focusedBorderColor ?? AppColors.black1c
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            fontFamily: AppConstants.poppins,
            color: AppColors.hintTextClr,
          ),
          labelText: widget.labelText,
          labelStyle: widget.labelStyle,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          suffix: widget.suffix,
          prefix: widget.prefix,
        ),
      ),
    );
  }
}
