// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
// import 'package:shipment_merchent_app/utils/constants/colors.dart';
// import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
// import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
//
// import '../controller/barcode_scan_controller.dart';
//
// class BarcodeScanScreen extends StatefulWidget {
//   @override
//   _BarcodeScanScreenState createState() => _BarcodeScanScreenState();
// }
//
// class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   final BarcodeScanController barcodeController = Get.put(BarcodeScanController());
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: TColors.bg,
//       appBar: const TAppBar(
//         title: 'استلام راجع',
//         showBackArrow: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(4.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 2.h),
//             GestureDetector(
//               onTap: () {
//                 if (controller != null) {
//                   controller!.resumeCamera();
//                 }
//               },
//               child: Center(
//                 child: Container(
//                   height: 25.h,
//                   width: 80.w,
//                   decoration: BoxDecoration(
//                     color: TColors.white,
//                     borderRadius: BorderRadius.circular(10.sp),
//                     border: Border.all(
//                       color: TColors.primary,
//                       width: 2,
//                     ),
//                   ),
//                   child: Center(
//                     child: _buildQrView(context),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 3.h),
//             Center(
//               child: Text(
//                 'امسح الرمز لاسترجاع الشحنة!',
//                 style: CustomTextStyle.headlineTextStyle
//                     .apply(color: TColors.primary, fontSizeFactor: 1.1),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: 1.h),
//             Center(
//               child: Text(
//                 'يرجى التأني إلى مسح الرمز لاسترجاع الشحنة من المندوب، وذلك لاستكمال عملية الاسترجاع.',
//                 style: CustomTextStyle.greyTextStyle.apply(fontSizeFactor: 0.8),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: 4.h),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
//               decoration: BoxDecoration(
//                 color: TColors.white,
//                 borderRadius: BorderRadius.circular(10.sp),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Text(
//                       'قم بتوجيه الكاميرا إلى الباركود',
//                       style: CustomTextStyle.headlineTextStyle
//                           .apply(color: TColors.black, fontSizeFactor: 1.0),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   CustomSizedBox.textSpacingVertical(),
//                   _buildOrDivider(),
//                   CustomSizedBox.textSpacingVertical(),
//                   Obx(() => TextFormField(
//                     initialValue: barcodeController.barcode.value,
//                     decoration: InputDecoration(
//                       hintText: 'رقم الباركود',
//                       hintStyle: CustomTextStyle.greyTextStyle,
//                       prefixIcon: Icon(
//                         Icons.qr_code,
//                         color: TColors.primary,
//                       ),
//                       filled: true,
//                       fillColor: TColors.bg,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.sp),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   )),
//                   CustomSizedBox.itemSpacingVertical(),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 7.h,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // أضف المنطق الذي يحدث عند الضغط على زر "التالي"
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: TColors.primary,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text(
//                         'التالي',
//                         style: CustomTextStyle.headlineTextStyle
//                             .apply(color: TColors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQrView(BuildContext context) {
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//         borderColor: TColors.primary,
//         borderRadius: 10,
//         borderLength: 30,
//         borderWidth: 10,
//         cutOutSize: 200.0,
//       ),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       barcodeController.updateBarcode(scanData.code ?? "");
//       controller.pauseCamera();
//     });
//   }
//
//   Widget _buildOrDivider() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: Divider(
//             color: TColors.grey,
//             height: 1.5,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Text(
//             'أو',
//             style: CustomTextStyle.greyTextStyle.apply(color: TColors.black),
//           ),
//         ),
//         Expanded(
//           child: Divider(
//             color: TColors.grey,
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }
// }
