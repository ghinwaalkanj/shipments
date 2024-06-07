import 'package:get/get.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:shipment_merchent_app/core/integration/statusrequest.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profile = MerchantInfo(
    id: 0,
    phone: '',
    verificationCode: '',
    name: '',
    nationalId: '',
    businessName: '',
    gender: '',
    idFrontImage: null,
    idBackImage: null,
    role: '',
    online: 0,
    createdAt: '',
    updatedAt: '',
  ).obs;

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  void fetchProfile() async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      '${MerchantAPIKey}profile.php',
      {'user_id': userId.toString()},
      {}
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to load profile');

      },
          (data) {
        ProfileResponseModel responseModel = ProfileResponseModel.fromJson(data);
        if (responseModel.status) {
          profile.value = responseModel.merchantInfo;
          print(responseModel.status);
          print(responseModel.merchantInfo.name);
          print(responseModel.merchantInfo.phone);
          print(responseModel.merchantInfo.name);
        } else {
          Get.snackbar('Error', 'Failed to load profile');
        }
      },
    );
  }
}
