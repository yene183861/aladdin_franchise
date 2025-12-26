final apiConfig = ApiConfig();

class ApiConfig {
  // http://192.168.1.136/api/v1
  static String apiUrl = '';
  static String login = '';
  static String checkCode = "";
  static String createAndUpdateOrder = "";
  static String processOrder = "";
  static String getInfoCustomer = "";
  static String addCoupon = "";
  static String deleteCoupon = "";
  static String createCustomer = "";
  static String applyPolicy = "";
  static String paymentAndPrinter = "";
  static String processOrderAndPrinter = "";
  static String getDataBillOrder = "";
  static String confirmCancelLineItem = '';
  static String getBankPayment = "";
  static String getInfoByTaxCode = "";
  static String updateOrderInvoice = "";
  static String sendPaymentRating = "";
  static String getPaymentMethod = "";
  static String lockOrder = "";
  static String statusLockOrder = "";
  static String getPaymentGateway = "";

  static String completeBill = "";
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
  static String getO2oCustomerInfo = "";

  // voucher
  static String addVoucher = "";
  static String deleteVoucher = "";

  void changeApi(String newApiUrl) {
    // v1
    apiUrl = '$newApiUrl';
    login = "$apiUrl/v1/login";
    //
    checkCode = "$apiUrl/v1/qr-code";
    processOrder = "$apiUrl/v1/confirm-orders";
    addCoupon = "$apiUrl/v1/mock-api-coupon";
    deleteCoupon = "$apiUrl/v1/mock-api-block-coupon";
    createCustomer = "$apiUrl/v1/mock-api-customer";
    applyPolicy = "$apiUrl/v1/mock-api-policy";
    paymentAndPrinter = "$apiUrl/v1/in-bill-tmp";
    confirmCancelLineItem = '$apiUrl/v1/confirm-cancel-line-item';
    getBankPayment = '$apiUrl/v1/get-bank-information';
    sendPaymentRating = '$apiUrl/v1/customer-rating-store';
    getPaymentMethod = '$apiUrl/v1/get-payment-method';
    lockOrder = '$apiUrl/v1/lock-order';
    statusLockOrder = '$apiUrl/v1/status-lock-order';
    getPaymentGateway = '$apiUrl/v2/get-payment-gateway';
    // v2
    processOrderAndPrinter = "$apiUrl/v2/print-in-bill-order";

    completeBill = "$apiUrl/v2/in-bill-completed";
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
    getO2oCustomerInfo = "$apiUrl/v1/get-customer-info";

    /// voucher
    addVoucher = '$apiUrl/v1/calculate-discount-code';
    deleteVoucher = '$apiUrl/v1/delete-voucher';
  }
}
