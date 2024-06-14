import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:shipment_merchent_app/core/services/storage_service.dart';
import 'package:shipment_merchent_app/utils/constants/api_constants.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import '../../../common/styles/custom_textstyle.dart';
import '../model/home_model.dart';

class HomeController extends GetxController {
  var ads = <Ad>[].obs;
  var shipments = <Shipment>[].obs;
  var cityName = ''.obs;
  var addressDetails = ''.obs;
  var addressLat = ''.obs;
  var addressLong = ''.obs;
  var isLoading = false.obs;

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<bool> onWillPop(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(
            'هل تود الخروج من التطبيق؟',
            style: CustomTextStyle.headlineTextStyle.apply(
              color: TColors.primary,
              fontSizeFactor: 1.1,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'نعم',
                style: CustomTextStyle.headlineTextStyle.apply(
                  color: TColors.primary,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'لا',
                style: CustomTextStyle.headlineTextStyle.apply(
                  color:TColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    )) ?? false;
  }


  String getShipmentStatusText(int status) {
    switch (status) {
      case 0:
        return 'بانتظار مندوب';
      case 1:
        return 'قبلها مندوب';
      case 2:
        return 'في الطريق إليك';
      case 3:
        return 'المندوب بالقرب منك';
      case 4:
        return 'سلم الشحنة';
      case 5:
        return 'في الطريق للعميل';
      case 6:
        return 'وصل للعميل';
      case 7:
        return 'مكتملة';
      default:
        return 'حالة غير معروفة';
    }
  }

  IconData getShipmentStatusIcon(int status) {
    switch (status) {
      case 0:
        return Icons.hourglass_top_rounded; // بانتظار الموافقة
      case 2:
        return Icons.local_shipping_rounded; // في الطريق إليك
      case 3:
        return Icons.qr_code; // المندوب بالقرب منك
      case 4:
        return Icons.assignment_turned_in_rounded; // سلم الشحنة للمندوب
      case 5:
        return Icons.directions_bike_rounded; // في الطريق للزبون
      case 6:
        return Icons.home_rounded; // وصل للزبون
      case 7:
        return Icons.check_circle_rounded; // مكتملة وتم تسليم الشحنة
      default:
        return Icons.help_outline_rounded; // حالة غير معروفة
    }
  }


  Color getShipmentStatusColor(int status) {
    switch (status) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        return TColors.bg;
      default:
        return TColors.bg;
    }
  }


   fetchHomeData() async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      '${MerchantAPIKey}home.php',
      {'user_id': userId.toString()},
      {},
    );

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to fetch home data');
      },
          (data) async {
        HomeResponseModel responseModel = HomeResponseModel.fromJson(data);
        var address = await SharedPreferencesHelper.setString(
            'address', responseModel.addressDetails);

        if (responseModel.status) {
          ads.value = responseModel.ads;
          shipments.value = responseModel.shipments;
          cityName.value = responseModel.cityName;
          addressDetails.value = responseModel.addressDetails;
          addressLat.value = responseModel.addressLat;
          addressLong.value = responseModel.addressLong;

          isLoading.value = false;
        } else {
          Get.snackbar('Error', 'Failed to fetch home data');
        }
      },
    );
  }
}