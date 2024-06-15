
/* -- LIST OF Constants used in APIs -- */

const String MerchantAPIKey = "https://api.wasenahon.com/Kwickly/merchant/";

// Authentication Endpoints
const String LoginEndpoint = "${MerchantAPIKey}auth/login.php";
const String VerifyEndpoint = "${MerchantAPIKey}auth/verify.php";
const String PersonalInfoEndpoint = "${MerchantAPIKey}auth/personal_info.php";
const String IDUploadEndpoint = "${MerchantAPIKey}auth/id_upload.php";

// Shipment Endpoints
const String AddShipmentEndpoint = "${MerchantAPIKey}shipments/add.php";
const String ViewShipmentByIdEndpoint = "${MerchantAPIKey}shipments/viewById.php";

// Add other endpoints here as needed
const String ProfileEndpoint = "${MerchantAPIKey}profile.php";
const String EditProfileEndpoint = "${MerchantAPIKey}edit_profile.php";
const String GetNotificationsEndpoint = "${MerchantAPIKey}merchant/get_notifications.php";
const String HomeEndpoint = "${MerchantAPIKey}home.php";
