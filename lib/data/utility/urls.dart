class Urls {
  static const String _baseUrl = 'http://ecom-api.teamrabbil.com/api';

  static String sentEmailOtp(String email) => '$_baseUrl/UserLogin/$email';
  static String verifyOtp(String email, String otp) =>
      '$_baseUrl/VerifyLogin/$email/$otp';
  static String readProfile = '$_baseUrl/ReadProfile';
  static String createProfile = '$_baseUrl/CreateProfile';
  static String homeBanner = '$_baseUrl/ListProductSlider';
  static String categoryList = '$_baseUrl/CategoryList';
  static String popularProduct = '$_baseUrl/ListProductByRemark/popular';
  static String newProduct = '$_baseUrl/ListProductByRemark/new';
  static String specialProduct = '$_baseUrl/ListProductByRemark/special';
  static String productByCategory(int categoryId) =>
      '$_baseUrl/ListProductByCategory/$categoryId';
  static String productByRemark(String remark) =>
      '$_baseUrl/ListProductByRemark/$remark';
  static String productDetails(int productId) =>
      '$_baseUrl/ProductDetailsById/$productId';
  static String addToCart = '$_baseUrl/CreateCartList';
  static String cartList = '$_baseUrl/CartList';
  static String deleteCartList(int productId) =>
      '$_baseUrl/DeleteCartList/$productId';
  static String createInvoice = '$_baseUrl/InvoiceCreate';
  static String productWishList = '$_baseUrl/ProductWishList';
  static String createWishList(int productId) =>
      '$_baseUrl/CreateWishList/$productId';
  static String removeWishList(int productId) =>
      '$_baseUrl/RemoveWishList/$productId';
}
