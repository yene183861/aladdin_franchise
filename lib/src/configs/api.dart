final apiConfig = ApiConfig();

class ApiConfig {
  // http://192.168.1.136/api/v1
  static String apiUrl = '';
  static String login = '';
  static String getOrders = "";
  static String getCategories = "";
  static String getProductByCategory = "";
  static String checkCode = "";
  static String createAndUpdateOrder = "";
  static String processOrder = "";
  static String productCheckout = "";
  static String getInfoCustomer = "";
  static String getCouponByCode = "";
  static String unlockCouponCode = "";
  static String createCustomer = "";
  static String applyPolicy = "";
  static String paymentAndPrinter = "";
  static String processOrderAndPrinter = "";
  static String getDataBillOrder = "";
  static String confirmCancelLineItem = '';
  static String inLocal = "http://192.168.1.136/print/in-cook.php";
  static String getLinkZaloOA = "";
  static String getBankPayment = "";
  static String getInfoByTaxCode = "";
  static String getInvoiceByOrder = "";
  static String updateInvoiceForOrder = "";
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
  static String getCashiers = "";
  static String closingShift = "";
  static String updateTax = "";

  /// danh sách nhân viên sale
  static String getEmployeeSales = "";
  // ticket
  static String createTicket = "";

  // o2o
  static String getOrderToOnline = "";
  static String updateStatusRequestOrderO2O = "";
  static String getChatMessages = "";

  // sync reservation
  static String checkReservationSync = "";
  static String getReservations = "";
  static String updateReservation = "";
  static String createOrderWithReservation = "";
  static String getO2oCustomerInfo = "";

  void changeApi(String newApiUrl) {
    // v1
    apiUrl = newApiUrl;
    login = "$apiUrl/v1/login";
    getCategories = "$apiUrl/v1/make-waiter-restaurant-category";
    getProductByCategory = "$apiUrl/v1/make-menu-search";
    checkCode = "$apiUrl/v1/qr-code";
    createAndUpdateOrder = "$apiUrl/v1/make-dine-in-orders";
    processOrder = "$apiUrl/v1/confirm-orders";
    productCheckout = "$apiUrl/v1/orders-for-table";
    getInfoCustomer = "$apiUrl/v1/mock-api-promotion";
    getCouponByCode = "$apiUrl/v1/mock-api-coupon";
    unlockCouponCode = "$apiUrl/v1/mock-api-block-coupon";
    createCustomer = "$apiUrl/v1/mock-api-customer";
    applyPolicy = "$apiUrl/v1/mock-api-policy";
    paymentAndPrinter = "$apiUrl/v1/in-bill-tmp";
    getDataBillOrder = "$apiUrl/v1/get-data-bill-order";
    confirmCancelLineItem = '$apiUrl/v1/confirm-cancel-line-item';
    getLinkZaloOA = '$apiUrl/v1/get-link-zalo-oa';
    getBankPayment = '$apiUrl/v1/get-bank-information';
    getInfoByTaxCode = '$apiUrl/v1/get-information-tax';
    getInvoiceByOrder = '$apiUrl/v1/get-invoice-information';
    updateInvoiceForOrder = '$apiUrl/v1/save-invoice';
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
    getCashiers = '$apiUrl/v2/list-cashier';
    closingShift = '$apiUrl/v2/close-shift-waiter';
    updateTax = '$apiUrl/v2/update-tax-waiter';

    getEmployeeSales = '$apiUrl/v2/get-employee-sale';

    // ticket
    createTicket = "$apiUrl/v2/create-ticket";

    // o2o
    getOrderToOnline = "$apiUrl/v1/user-order-line-item";
    updateStatusRequestOrderO2O = "$apiUrl/v1/update-status-user-order";

    /// Chuyển sang config login
    getChatMessages = "http://o2o.aladdin-jsc.com/api/chat";

    // sync reservation
    checkReservationSync = "$apiUrl/v1/reservation/sync";
    getReservations = "$apiUrl/v1/reservation";
    updateReservation = "$apiUrl/v1/reservation/status";
    createOrderWithReservation = "$apiUrl/v1/make-dine-in-orders";
    getO2oCustomerInfo = "$apiUrl/v1/get-customer-info";
  }
}
