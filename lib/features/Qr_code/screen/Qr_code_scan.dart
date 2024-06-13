import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../controller/barcode_scan_controller.dart';

class BarcodeScanScreen extends StatefulWidget {
  const BarcodeScanScreen({super.key});

  @override
  _BarcodeScanScreenState createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  final BarcodeScanController barcodeController = Get.put(BarcodeScanController());

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: const TAppBar(
        title: 'استلام راجع',
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              GestureDetector(
                onTap: () {
                  if (controller != null) {
                    controller!.resumeCamera();
                  }
                },
                child: Center(
                  child: Container(
                    height: 25.h,
                    width: 60.w,
                    decoration: BoxDecoration(

                    ),
                    child: Center(
                      child: _buildQrView(context),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Center(
                child: Text(
                  'امسح الرمز لاسترجاع الشحنة!',
                  textDirection: TextDirection.rtl,
                  style: CustomTextStyle.headlineTextStyle
                      .apply(color: TColors.primary, fontSizeFactor: 1.1),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 1.h),
              Center(
                child: Text(
                  'يرجى مسح الرمز لاسترجاع الشحنة من المندوب، وذلك لاستكمال عملية الاسترجاع.',
                  textDirection: TextDirection.rtl,
                  style: CustomTextStyle.greyTextStyle.apply(fontSizeFactor: 0.8),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 4.h),

              Container(
                height: 40.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: TColors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(20.sp)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 3.h, horizontal: 5.w),
                  child: SingleChildScrollView(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'قم بتوجيه الكاميرا إلى الباركود',
                            style: CustomTextStyle.headlineTextStyle
                                .apply(color: TColors.black, fontSizeFactor: 1.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        CustomSizedBox.textSpacingVertical(),
                        _buildOrDivider(),
                        SizedBox(height: 2.h,),
                        Obx(() => Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            initialValue: barcodeController.barcode.value,
                            decoration: InputDecoration(
                              hintText: 'رقم الشحنة',
                              hintStyle: CustomTextStyle.greyTextStyle,
                              prefixIcon: const Icon(
                                Icons.qr_code,
                                color: TColors.primary,
                              ),
                              filled: true,
                              fillColor: TColors.bg,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.sp),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        )),
                        SizedBox(height: 7.h,),
                        SizedBox(
                          width: double.infinity,
                          height: 7.h,
                          child: ElevatedButton(
                            onPressed: () {
                              // أضف المنطق الذي يحدث عند الضغط على زر "التالي"
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'التالي',
                              style: CustomTextStyle.headlineTextStyle
                                  .apply(color: TColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: TColors.primary,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 200.0,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      barcodeController.updateBarcode(scanData.code ?? "");
      controller.pauseCamera();
    });
  }

  Widget _buildOrDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            color: TColors.grey,
            height: 1.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'أو',
            style: CustomTextStyle.greyTextStyle.apply(color: TColors.black),
          ),
        ),
        const Expanded(
          child: Divider(
            color: TColors.grey,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
