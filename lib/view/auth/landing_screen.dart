// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:session_mate/commonWidget/custom_text.dart';
// import 'package:session_mate/commonWidget/network_assets.dart';
// import 'package:session_mate/utils/app_colors.dart';
// import 'package:session_mate/utils/app_constant.dart';
// import 'package:session_mate/utils/app_image_assets.dart';
// import 'package:session_mate/utils/app_string.dart';
// import 'package:session_mate/utils/size_config_utils.dart';
//
// class LandingScreen extends StatefulWidget {
//   const LandingScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LandingScreen> createState() => _LandingScreenState();
// }
//
// class _LandingScreenState extends State<LandingScreen> {
//   final List<Map<String, String>> imageSpeechData = [
//     {
//       'imageUrl':
//           'https://img.freepik.com/free-photo/caucasian-pretty-girl-typing-laptop-computer_74855-8843.jpg?t=st=1716013157~exp=1716016757~hmac=7de3a8985ac75278e158e2199be6b7be601dccd7bb1b8dee3c988e1bbd255ce0&w=996',
//       'title': 'Speech',
//     },
//     {
//       'imageUrl':
//           'https://img.freepik.com/free-photo/caucasian-pretty-girl-typing-laptop-computer_74855-8843.jpg?t=st=1716013157~exp=1716016757~hmac=7de3a8985ac75278e158e2199be6b7be601dccd7bb1b8dee3c988e1bbd255ce0&w=996',
//       'title': 'Special Education',
//     },
//     {
//       'imageUrl':
//           'https://img.freepik.com/free-photo/caucasian-pretty-girl-typing-laptop-computer_74855-8843.jpg?t=st=1716013157~exp=1716016757~hmac=7de3a8985ac75278e158e2199be6b7be601dccd7bb1b8dee3c988e1bbd255ce0&w=996',
//       'title': 'Sports',
//     },
//     {
//       'imageUrl':
//           'https://img.freepik.com/free-photo/caucasian-pretty-girl-typing-laptop-computer_74855-8843.jpg?t=st=1716013157~exp=1716016757~hmac=7de3a8985ac75278e158e2199be6b7be601dccd7bb1b8dee3c988e1bbd255ce0&w=996',
//       'title': 'Occupational Therapy',
//     },
//     {
//       'imageUrl':
//           'https://img.freepik.com/free-photo/caucasian-pretty-girl-typing-laptop-computer_74855-8843.jpg?t=st=1716013157~exp=1716016757~hmac=7de3a8985ac75278e158e2199be6b7be601dccd7bb1b8dee3c988e1bbd255ce0&w=996',
//       'title': 'Music',
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizeConfig.sH20,
//             Center(
//               child: Image.asset(
//                 AppImageAssets.landingImage,
//                 height: 100.h,
//                 // width: 68.w,
//               ),
//             ),
//             SizeConfig.sH30,
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 40.sp),
//               child: RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: AppStrings.thankYouFor,
//                       style: TextStyle(
//                         fontFamily: AppConstants.inter,
//                         color: AppColors.black,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 23.sp,
//                       ),
//                     ),
//                     TextSpan(
//                       text: AppStrings.submission,
//                       style: TextStyle(
//                         fontFamily: AppConstants.inter,
//                         color: AppColors.primaryColor,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 23.sp,
//                       ),
//                     ),
//                     TextSpan(
//                       text: '.',
//                       style: TextStyle(
//                         fontFamily: AppConstants.inter,
//                         color: AppColors.black,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 23.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizeConfig.sH30,
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 40.sp),
//               child: RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: AppStrings.yourDetailAreBeingVerified,
//                       style: TextStyle(
//                         fontFamily: AppConstants.inter,
//                         color: AppColors.black,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 23.sp,
//                       ),
//                     ),
//                     TextSpan(
//                       text: AppStrings.activatedShortly,
//                       style: TextStyle(
//                         fontFamily: AppConstants.inter,
//                         color: AppColors.primaryColor,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 23.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizeConfig.sH30,
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 40.sp),
//               child: CustomText(
//                 AppStrings.weLookForwardToSeeYou,
//                 color: AppColors.primaryColor,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 23.sp,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizeConfig.sH80,
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.generate(
//                   imageSpeechData.length,
//                   (index) => Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       width: 240.w,
//                       child: Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: NetWorkOcToAssets(
//                               imgUrl: imageSpeechData[index]['imageUrl'] ?? '',
//                               height: 150,
//                               // fit: BoxFit.cover,
//                             ),
//                           ),
//                           Positioned(
//                             left: 0,
//                             right: 0,
//                             bottom: 0,
//                             child: Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: const BoxDecoration(
//                                 color: Colors.teal,
//                                 borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(15),
//                                   bottomRight: Radius.circular(15),
//                                 ),
//                               ),
//                               child: Center(
//                                 child: CustomText(
//                                   imageSpeechData[index]['title'] ?? '',
//                                   color: Colors.white,
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizeConfig.sH100,
//           ],
//         ),
//       ),
//     );
//   }
// }
