final apiConfig = ApiConfig();

class ApiConfig {
  // http://192.168.1.136/api/v1
  static String apiUrl = '';
  static String login = '';
  static String getOrders = "";
  static String getCategory = "";
  static String getProduct = "";
  static String checkCode = "";
  static String createAndUpdateOrder = "";
  static String processOrder = "";
  static String productCheckout = "";
  static String getInfoCustomer = "";
  static String addCoupon = "";
  static String deleteCoupon = "";
  static String createCustomer = "";
  static String applyPolicy = "";
  static String paymentAndPrinter = "";
  static String processOrderAndPrinter = "";
  static String getDataBillOrder = "";
  static String confirmCancelLineItem = '';
  static String inLocal = "http://192.168.1.136/print/in-cook.php";
  static String getBankPayment = "";
  static String getInfoByTaxCode = "";
  static String getOrderInvoice = "";
  static String updateOrderInvoice = "";
  static String sendPaymentRating = "";
  static String getPaymentMethod = "";
  static String lockOrder = "";
  static String statusLockOrder = "";
  static String getPaymentGateway = "";

  static String completeBill = "";
  static String historyOrder = "";
  static String getTickets = "";
  // pos - máy cà thẻ
  static String getListAtmPos = "";
  static String atmPosCallback = "";

  // chốt ca
  static String closeShift = "";
  static String updateTax = "";

  /// danh sách nhân viên sale
  static String getEmployeeSales = "";
  // ticket
  static String createTicket = "";

  // o2o
  static String getOrderToOnline = "";
  static String processO2oRequest = "";

  // sync reservation
  static String syncReservation = "";
  static String getReservations = "";
  static String updateReservation = "";
  static String getO2oCustomerInfo = "";

  // voucher
   static String addVoucher = "";
   static String deleteVoucher = "";

  void changeApi(String newApiUrl) {
    // v1
    apiUrl = '$newApiUrl/api';
    login = "$apiUrl/v1/login";
    // menu
    getCategory = "$apiUrl/v1/make-waiter-restaurant-category";
    getProduct = "$apiUrl/v1/make-menu-search";
    //
    checkCode = "$apiUrl/v1/qr-code";
    createAndUpdateOrder = "$apiUrl/v1/make-dine-in-orders";
    processOrder = "$apiUrl/v1/confirm-orders";
    productCheckout = "$apiUrl/v1/orders-for-table";
    getInfoCustomer = "$apiUrl/v1/mock-api-promotion";
    addCoupon = "$apiUrl/v1/mock-api-coupon";
    deleteCoupon = "$apiUrl/v1/mock-api-block-coupon";
    createCustomer = "$apiUrl/v1/mock-api-customer";
    applyPolicy = "$apiUrl/v1/mock-api-policy";
    paymentAndPrinter = "$apiUrl/v1/in-bill-tmp";
    getDataBillOrder = "$apiUrl/v1/get-data-bill-order";
    confirmCancelLineItem = '$apiUrl/v1/confirm-cancel-line-item';
    getBankPayment = '$apiUrl/v1/get-bank-information';
    getInfoByTaxCode = '$apiUrl/v1/get-information-tax';
    getOrderInvoice = '$apiUrl/v1/get-invoice-information';
    updateOrderInvoice = '$apiUrl/v1/save-invoice';
    sendPaymentRating = '$apiUrl/v1/customer-rating-store';
    getPaymentMethod = '$apiUrl/v1/get-payment-method';
    lockOrder = '$apiUrl/v1/lock-order';
    statusLockOrder = '$apiUrl/v1/status-lock-order';
    getPaymentGateway = '$apiUrl/v2/get-payment-gateway';
    // v2
    getOrders = "$apiUrl/v2/list-table-using";
    processOrderAndPrinter = "$apiUrl/v2/print-in-bill-order";

    completeBill = "$apiUrl/v2/in-bill-completed";
    historyOrder = "$apiUrl/v2/order-history";
    getTickets = "$apiUrl/v1/get-ticket";

    getListAtmPos = '$apiUrl/v2/list-pos';
    atmPosCallback = '$apiUrl/v2/pos-callback';
    // chốt ca
    closeShift = '$apiUrl/v2/get-close-shift-waiter';
    updateTax = '$apiUrl/v2/update-tax-waiter';

    getEmployeeSales = '$apiUrl/v2/get-employee-sale';

    // ticket
    createTicket = "$apiUrl/v2/create-ticket";

    // o2o
    getOrderToOnline = "$apiUrl/v1/user-order-line-item";
    processO2oRequest = "$apiUrl/v1/update-status-user-order";

    // reservation
    syncReservation = "$apiUrl/v1/reservation/sync";
    getReservations = "$apiUrl/v1/reservation";
    updateReservation = "$apiUrl/v1/reservation/status";
    getO2oCustomerInfo = "$apiUrl/v1/get-customer-info";

    /// voucher
    addVoucher = '$apiUrl/v1/calculate-discount-code';
    deleteVoucher = '$apiUrl/v1/delete-voucher';
  }
}
