enum AppLogAction {
  general,
  updateApp,
  // login
  login,
  loginSuccess,
  // user
  checkCodeWaiter,
  // chốt ca
  closingShift,

  // category + product
  getCategory,
  getProductByCategory,
  // data bill
  getDataBill,
  // printer
  getIpPrinterOrder,
  pingPrinter,
  // order
  getOrders,
  createAndUpdateOrder,
  checkStatusLockOrder,
  getStatusLockOrder,
  lockOrder,
  sendPaymentRating,
  updateInvoiceForOrder,
  getInvoiceByOrder,
  // gọi món
  processOrder,
  processOrderBill,
  cancelDishBill,
  cancelDish,
  // get product checkout
  getProductCheckout,
  // payment
  completeBill,
  payment,
  updateTax,
  getPaymentGateway,
  posCallback,
  // customer
  findCustomer,
  createCustomer,
  getLinkZaloOA,
  // áp lại mã giảm giá
  applyPolicy,
  // restaurant
  getBankPayment,
  getPaymentMethod,
  getListPos,
  getCashiers,
  historyOrder,
  getInfoByTaxCode,
  getEmployeeSales,
  // coupons
  getCouponByCode,
  unblockCouponCode,
  // ticket
  getTickets,
  createTicket,

  //
  localStorage,
}

extension ExtAppLogAction on AppLogAction {
  String get name {
    switch (this) {
      case AppLogAction.general:
        return "General";
      case AppLogAction.updateApp:
        return "updateApp";
      // login
      case AppLogAction.login:
        return "Login";
      case AppLogAction.loginSuccess:
        return "loginSuccess";
      // user
      case AppLogAction.checkCodeWaiter:
        return "checkCodeWaiter";
      case AppLogAction.closingShift:
        return "closingShift";
      // category + product
      case AppLogAction.getCategory:
        return "getCategory";
      case AppLogAction.getProductByCategory:
        return "getProductByCategory";
      // data bill
      case AppLogAction.getDataBill:
        return "getDataBill";
      // printer
      case AppLogAction.getIpPrinterOrder:
        return "getIpPrinterOrder";
      case AppLogAction.pingPrinter:
        return "pingPrinter";
      // order
      case AppLogAction.getOrders:
        return "getOrders";
      case AppLogAction.createAndUpdateOrder:
        return "createAndUpdateOrder";
      case AppLogAction.checkStatusLockOrder:
        return "checkStatusLockOrder";
      case AppLogAction.getStatusLockOrder:
        return "getStatusLockOrder";
      case AppLogAction.lockOrder:
        return "lockOrder";
      case AppLogAction.sendPaymentRating:
        return "sendPaymentRating";
      case AppLogAction.updateInvoiceForOrder:
        return "updateInvoiceForOrder";
      case AppLogAction.getInvoiceByOrder:
        return "getInvoiceByOrder";
      // gọi món
      case AppLogAction.processOrder:
        return "processOrder";
      case AppLogAction.processOrderBill:
        return "processOrderBill";
      case AppLogAction.cancelDishBill:
        return "cancelDishBill";
      case AppLogAction.cancelDish:
        return "cancelDish";
      // get product checkout
      case AppLogAction.getProductCheckout:
        return "getProductCheckout";
      // payment
      case AppLogAction.completeBill:
        return "completeBill";
      case AppLogAction.payment:
        return "payment";
      case AppLogAction.updateTax:
        return "updateTax";
      case AppLogAction.getPaymentGateway:
        return "getPaymentGateway";
      case AppLogAction.posCallback:
        return "posCallback";
      // customer
      case AppLogAction.findCustomer:
        return "findCustomer";
      case AppLogAction.createCustomer:
        return "createCustomer";
      case AppLogAction.getLinkZaloOA:
        return "getLinkZaloOA";
      // áp lại mã giảm giá
      case AppLogAction.applyPolicy:
        return "applyPolicy";
      // restaurant
      case AppLogAction.getBankPayment:
        return "getBankPayment";
      case AppLogAction.getPaymentMethod:
        return "getPaymentMethod";
      case AppLogAction.getListPos:
        return "getListPos";
      case AppLogAction.getCashiers:
        return "getCashiers";
      case AppLogAction.historyOrder:
        return "historyOrder";
      case AppLogAction.getInfoByTaxCode:
        return "getInfoByTaxCode";
      case AppLogAction.getEmployeeSales:
        return "getEmployeeSales";
      // coupons
      case AppLogAction.getCouponByCode:
        return "getCouponByCode";
      case AppLogAction.unblockCouponCode:
        return "unblockCouponCode";
      // ticket
      case AppLogAction.getTickets:
        return "getTickets";
      case AppLogAction.createTicket:
        return "createTicket";
      case AppLogAction.localStorage:
        return "localStorage";
      default:
        return toString();
    }
  }

  String get webhookDiscord {
    switch (this) {
      // login
      case AppLogAction.loginSuccess:
      case AppLogAction.login:
        return 'https://discord.com/api/webhooks/1389152439759802499/HvFIt-Qa4n2jDSNuywsH4XNSzhAUqqpOEAcY2XRFhAFHq9mix-oW8pQ0nwk9LrhO8Iiv';

      // user
      case AppLogAction.checkCodeWaiter:
      case AppLogAction.closingShift:
        return 'https://discord.com/api/webhooks/1389152569510727833/WHjTU6g0ZS9knucHI_ABBeOE4-hl2yl4QJT9PSpy8qOlEc5eyw1d4X-OkVZxFi_c0bXl';
      // category + product
      case AppLogAction.getCategory:
      case AppLogAction.getProductByCategory:
        return 'https://discord.com/api/webhooks/1389152786125426728/IdQTTlMDvCyRiyTkFpch_ux6KI1SjlUccZ9hN5hHVFjZTOb_MNk6zbSH1P9MMg-ubgX9';
      // data bill
      case AppLogAction.getDataBill:
        return 'https://discord.com/api/webhooks/1389152983815684199/xJLSmgF3scyL9fNNcUJkNS1yPUFPpYQwkxsjpJDgZDQs67x4pJoqNaZabtxkzOeCtDVC';
      // printer
      case AppLogAction.getIpPrinterOrder:
      case AppLogAction.pingPrinter:
        return 'https://discord.com/api/webhooks/1389153145971540018/JUn7NjZKUJiBAb2Jf-AxzWmzCbVbe5oucULrnKG8ejTIkXp2brezI5UlkwIOk0s9dhSH';
      // order
      case AppLogAction.getOrders:
      case AppLogAction.createAndUpdateOrder:
      case AppLogAction.checkStatusLockOrder:
      case AppLogAction.getStatusLockOrder:
      case AppLogAction.lockOrder:
      case AppLogAction.sendPaymentRating:
      case AppLogAction.updateInvoiceForOrder:
      case AppLogAction.getInvoiceByOrder:
        return 'https://discord.com/api/webhooks/1389153297197301820/4hPUiW2BMKAUOIVYxj_75LhrSeSWXn7BDqpmeJkGMvI4arR1BL--w4F30VdtKHL01vGt';
      // process-order
      case AppLogAction.processOrder:
      case AppLogAction.processOrderBill:
      case AppLogAction.cancelDishBill:
      case AppLogAction.cancelDish:
        return 'https://discord.com/api/webhooks/1389153446875238491/g-OOjm1hgNRrWIGvlqyOkMc1N3nfaP06_zEysgwvOktXjUa_gObReJg2a1H71xelWGJZ';
      // get product checkout
      case AppLogAction.getProductCheckout:
        return 'https://discord.com/api/webhooks/1389153628626882610/EKO-81HK03dQkCE35Dcqa2Jfs6kAqt68cZwvtgc7Z4H0JSBUAlGg2YEAdp1iUAyVizHz';
      // payment
      case AppLogAction.completeBill:
      case AppLogAction.payment:
      case AppLogAction.updateTax:
      case AppLogAction.getPaymentGateway:
      case AppLogAction.posCallback:
        return 'https://discord.com/api/webhooks/1389153750504964127/vyf64oqDkEVU8LDeLp3QvNSYoZYEiCIRIRhj9BPWYUvJ7kdd9yJJR8n02wcppW2hzEkx';
      // customer
      case AppLogAction.findCustomer:
      case AppLogAction.createCustomer:
      case AppLogAction.getLinkZaloOA:
        return 'https://discord.com/api/webhooks/1389153865160589426/VfBz_OGMZ7I_BFYPaz-IfMNwfW65ikR0sPRp6h82A8RvPha3koXO6pvDNAbVqKWQJRno';
      // áp lại mã giảm giá
      case AppLogAction.applyPolicy:
        return 'https://discord.com/api/webhooks/1389153993850093618/2JigvV3cEvFqrCWfOOueRhcgEph3hf0uv11WTDWKGS4J_i9Nx9bcIvuYTKX-3TNfQlJi';
      // restaurant
      case AppLogAction.getBankPayment:
      case AppLogAction.getPaymentMethod:
      case AppLogAction.getListPos:
      case AppLogAction.getCashiers:
      case AppLogAction.historyOrder:
      case AppLogAction.getInfoByTaxCode:
      case AppLogAction.getEmployeeSales:
        return 'https://discord.com/api/webhooks/1389154110997266442/dSX30uEWWdT0F5laCvEq5_AYfYhcp5oPSd8Zogsdt9Hy-mwXiqeFiwhzj9EzdOWyIZHv';

      // coupons
      case AppLogAction.getCouponByCode:
      case AppLogAction.unblockCouponCode:
        return 'https://discord.com/api/webhooks/1389154255142654012/BOSWsj5d2vXs96LU4R64k4s123deNLbrVIKZWl-yJ7pQoQFXVYQCpPDFqNDcW3wlKvuY';
      // ticket
      case AppLogAction.getTickets:
      case AppLogAction.createTicket:
        return 'https://discord.com/api/webhooks/1389156534935883796/_40_w6OCUPZj8SlvoWesgeR3OIU5lNvvbNynivo-AeGob4Gj7q1qc2Bt-hTvMpgN1pCf';
      case AppLogAction.localStorage:
        return 'https://discord.com/api/webhooks/1414865450679926874/u_ihG3gumX2YNAIIXBLcKip-QRaxy8BvRd7lcpZhLtTTqkNuvNQQlfR84TeZJEhv4UlD';

      default:
        return 'https://discord.com/api/webhooks/1385803549342175262/v-rMF-GBliTKHuYXs4mvB6G7UgUzsu5yt_Twz72OlPQajg7NNYL56KN4f_mM93TBcNyI';
    }
  }

  int get telegramTopic {
    switch (this) {
      // login
      case AppLogAction.loginSuccess:
      case AppLogAction.login:
        return 4;

      // user
      case AppLogAction.checkCodeWaiter:
      case AppLogAction.closingShift:
        return 2;
      // category + product
      case AppLogAction.getCategory:
      case AppLogAction.getProductByCategory:
        return 8;
      // data bill
      case AppLogAction.getDataBill:
        return 6;
      // printer
      case AppLogAction.getIpPrinterOrder:
      case AppLogAction.pingPrinter:
        return 10;
      // order
      case AppLogAction.getOrders:
      case AppLogAction.createAndUpdateOrder:
      case AppLogAction.checkStatusLockOrder:
      case AppLogAction.getStatusLockOrder:
      case AppLogAction.lockOrder:
      case AppLogAction.sendPaymentRating:
      case AppLogAction.updateInvoiceForOrder:
      case AppLogAction.getInvoiceByOrder:
        return 12;
      // process-order
      case AppLogAction.processOrder:
      case AppLogAction.processOrderBill:
      case AppLogAction.cancelDishBill:
      case AppLogAction.cancelDish:
        return 14;
      // get product checkout
      case AppLogAction.getProductCheckout:
        return 16;
      // payment
      case AppLogAction.completeBill:
      case AppLogAction.payment:
      case AppLogAction.updateTax:
      case AppLogAction.getPaymentGateway:
      case AppLogAction.posCallback:
        return 18;
      // customer
      case AppLogAction.findCustomer:
      case AppLogAction.createCustomer:
      case AppLogAction.getLinkZaloOA:
        return 20;
      // áp lại mã giảm giá
      case AppLogAction.applyPolicy:
        return 28;
      // restaurant
      case AppLogAction.getBankPayment:
      case AppLogAction.getPaymentMethod:
      case AppLogAction.getListPos:
      case AppLogAction.getCashiers:
      case AppLogAction.historyOrder:
      case AppLogAction.getInfoByTaxCode:
      case AppLogAction.getEmployeeSales:
        return 22;

      // coupons
      case AppLogAction.getCouponByCode:
      case AppLogAction.unblockCouponCode:
        return 24;
      // ticket
      case AppLogAction.getTickets:
      case AppLogAction.createTicket:
      case AppLogAction.localStorage:
        return 26;

      default:
        return 1;
    }
  }
}
