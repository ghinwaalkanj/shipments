
/* -- LIST OF Constants used in APIs -- */

const String MerchantAPIKey = "https://api.wasenahon.com/Kwickly/merchant/";
const String UploadIdImagesAPI = "https://api.wasenahon.com/Kwickly/upload/id_images/";

// Authentication Endpoints
const String LoginEndpoint = "${MerchantAPIKey}auth/login.php";
const String VerifyEndpoint = "${MerchantAPIKey}auth/verify.php";
const String PersonalInfoEndpoint = "${MerchantAPIKey}auth/personal_info.php";
const String IDUploadEndpoint = "${MerchantAPIKey}auth/id_upload.php";

// Shipment Endpoints
const String AddShipmentEndpoint = "${MerchantAPIKey}shipments/add.php";
const String ViewShipmentByIdEndpoint = "${MerchantAPIKey}shipments/viewById.php";
const String ViewShipmentEndpoint = "${MerchantAPIKey}shipments/view.php";
const String calculateShippingFeeEndpoint = "${MerchantAPIKey}shipments/calculateShippingFee.php";
const String SearchShipmenEndpoint = "${MerchantAPIKey}shipments/search.php";
const String CancelShipmenEndpoint = "${MerchantAPIKey}shipments/cancel_shipment.php";


// Profile Endpoints
const String ProfileEndpoint = "${MerchantAPIKey}profile.php";
const String EditProfileEndpoint = "${MerchantAPIKey}edit_profile.php";



// Notifications  Endpoints
const String NotificationsEndpoint = "${MerchantAPIKey}get_notifications.php";

// Home Endpoints
const String HomeEndpoint = "${MerchantAPIKey}home.php";

// Address  Endpoints

const String GetCitiesEndpoint = "${MerchantAPIKey}address/get_cities.php";
const String AddAddressEndpoint = "${MerchantAPIKey}address/add.php";
const String ViewAddressEndpoint = "${MerchantAPIKey}address/view.php";
const String SetDefaultAddressEndpoint = "${MerchantAPIKey}address/set_default_address.php";

