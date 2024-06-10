import 'package:get/get.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:shipment_merchent_app/core/services/storage_service.dart';
import 'package:shipment_merchent_app/utils/constants/api_constants.dart';
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

  void fetchHomeData() async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      '${MerchantAPIKey}home.php',
      {'user_id': userId.toString()},
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to fetch home data');
      },
          (data) {
        HomeResponseModel responseModel = HomeResponseModel.fromJson(data);
        if (responseModel.status) {
          ads.value = responseModel.ads;
          shipments.value = responseModel.shipments;
          cityName.value = responseModel.cityName;
          addressDetails.value = responseModel.addressDetails;
          addressLat.value = responseModel.addressLat;
          addressLong.value = responseModel.addressLong;
        } else {
          Get.snackbar('Error', 'Failed to fetch home data');
        }
      },
    );
  }
}

