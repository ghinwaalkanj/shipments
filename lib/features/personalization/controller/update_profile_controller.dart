// import 'package:get/get.dart';
// import 'package:shipment_merchent_app/core/integration/crud.dart';
// import 'package:shipment_merchent_app/features/personalization/controller/profile_controller.dart';
// import '../../../core/services/storage_service.dart';
// import '../../../utils/constants/api_constants.dart';
// import '../model/profile_model.dart';
// import '../model/update_profile_model.dart';
//
// class UpdateProfileController extends GetxController {
//   var isLoading = false.obs;
//   var profile = MerchantInfo.empty().obs;
//   final ProfileController controller = Get.put(ProfileController());
//
//   final Crud crud = Get.find<Crud>();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchProfile();
//   }
//
//   void fetchProfile() async {
//     isLoading.value = true;
//     var userId = await SharedPreferencesHelper.getInt('user_id');
//     var response = await crud.getData(
//       '${MerchantAPIKey}profile.php',
//       {'user_id': userId.toString()},
//     );
//     isLoading.value = false;
//
//     response.fold(
//           (failure) {
//         Get.snackbar('Error', 'Failed to load profile');
//       },
//           (data) {
//         if (data is Map) {
//           ProfileResponseModel responseModel = ProfileResponseModel.fromJson(data);
//           if (responseModel.status) {
//             profile.value = responseModel.merchantInfo;
//           } else {
//             Get.snackbar('Error', 'Failed to load profile');
//           }
//         } else {
//           Get.snackbar('Error', 'Invalid data received');
//         }
//       },
//     );
//   }
//
//   void editProfile(String name, String phone, String businessName) async {
//     isLoading.value = true;
//     var userId = await SharedPreferencesHelper.getInt('user_id');
//     var response = await crud.postData(
//       '${MerchantAPIKey}edit_profile.php',
//       {
//         'user_id': userId.toString(),
//         'name':  controller.profile.value.name,
//         'phone': controller.profile.value.phone,
//         'business_name':  controller.profile.value.businessName,
//       },
//       {},
//     );
//     isLoading.value = false;
//
//     response.fold(
//           (failure) {
//         Get.snackbar('Error', 'Failed to update profile');
// print(profile.value.name);
// print(controller.profile.value.name);
//
//       },
//           (data) {
//         EditProfileResponseModel responseModel = EditProfileResponseModel.fromJson(data);
//         if (responseModel.status) {
//           Get.snackbar('Success', responseModel.message);
//           controller.fetchProfile();
//         } else {
//           Get.snackbar('Error', responseModel.message);
//         }
//       },
//     );
//   }
// }
