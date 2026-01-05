enum AppLogAction {
  general,
  updateApp,

  /// login
  login,
  loginSuccess,

  /// user
  closeShift,

  /// menu
  getCategory,
  getProduct,
  // data bill
  getDataBill,

  /// printer
  getIpPrinterOrder,
  pingPrinter,
  print,

  /// order
  getOrders,
  createAndUpdateOrder,
  checkStatusLockOrder,
  getStatusLockOrder,
  lockOrder,

  /// gọi món
  processOrder,
  processOrderBill,
  cancelDishBill,
  cancelDish,

  /// get product checkout
  getProductCheckout,

  /// payment
  completeBill,
  payment,
  updateTax,
  getPaymentGateway,
  posCallback,

  /// customer
  findCustomer,
  createCustomer,
  resetCustomer,

  // restaurant
  getBanks,
  getPaymentMethod,
  getListAtmPos,
  historyOrder,
  getEmployeeSales,

  /// coupons
  addCoupon,
  deleteCoupon,
  addVoucher,
  deleteVoucher,
  // áp lại mã giảm giá
  applyPolicy,

  /// invoice
  getInfoByTaxCode,
  updateOrderInvoice,
  getOrderInvoice,

  /// ticket
  getTickets,
  createTicket,

  //
  localStorage,

  /// reservation
  syncReservation,
  updateReservation,
  getReservations,
  getReservationById,

  /// o2o
  getOrderToOnline,
  processO2oRequest,
  getChatMessages,
  getO2oCustomerInfo,

  ///
  webContentConverter,

  getQrBankDynamicPaymentGateway,
}

extension ExtAppLogAction on AppLogAction {
  String get title {
    switch (this) {
      case AppLogAction.general:
        return "General";
      case AppLogAction.updateApp:
        return "updateApp";

      /// login
      case AppLogAction.login:
        return "Login";
      case AppLogAction.loginSuccess:
        return "loginSuccess";

      /// user
      case AppLogAction.closeShift:
        return "closeShift";

      /// category + product
      case AppLogAction.getCategory:
        return "getCategory";
      case AppLogAction.getProduct:
        return "getProduct";

      /// data bill
      case AppLogAction.getDataBill:
        return "getDataBill";

      /// printer
      case AppLogAction.getIpPrinterOrder:
        return "getIpPrinterOrder";
      case AppLogAction.pingPrinter:
        return "pingPrinter";
      case AppLogAction.print:
        return "print";

      /// order
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
      case AppLogAction.updateOrderInvoice:
        return "updateOrderInvoice";
      case AppLogAction.getOrderInvoice:
        return "getOrderInvoice";

      /// gọi món
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

      /// payment
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

      /// customer
      case AppLogAction.findCustomer:
        return "findCustomer";
      case AppLogAction.createCustomer:
        return "createCustomer";
      case AppLogAction.resetCustomer:
        return "resetCustomer";

      /// áp lại mã giảm giá
      case AppLogAction.applyPolicy:
        return "applyPolicy";

      /// restaurant
      case AppLogAction.getBanks:
        return "getBanks";
      case AppLogAction.getPaymentMethod:
        return "getPaymentMethod";
      case AppLogAction.getListAtmPos:
        return "getListAtmPos";
      case AppLogAction.historyOrder:
        return "historyOrder";
      case AppLogAction.getInfoByTaxCode:
        return "getInfoByTaxCode";
      case AppLogAction.getEmployeeSales:
        return "getEmployeeSales";

      /// coupons
      case AppLogAction.addCoupon:
        return "addCoupon";
      case AppLogAction.deleteCoupon:
        return "deleteCoupon";
      case AppLogAction.addVoucher:
        return "addVoucher";
      case AppLogAction.deleteVoucher:
        return "deleteVoucher";

      /// ticket
      case AppLogAction.getTickets:
        return "getTickets";
      case AppLogAction.createTicket:
        return "createTicket";
      case AppLogAction.localStorage:
        return "localStorage";
      case AppLogAction.webContentConverter:
        return "webContentConverter";
      default:
        return toString();
    }
  }

  String get webhookDiscord {
    switch (this) {
      /// login
      case AppLogAction.loginSuccess:
        return "https://discord.com/api/webhooks/1423123122214797426/ljk0LmW7pO036HzWg2xaOwplSAyHNvufgcizTy4VpCsNRp8vOiJisXcQMfrRpIVUUCht";
      case AppLogAction.login:
        return "https://discord.com/api/webhooks/1423122896431087690/06_pACI8CCkELFE6I9AHD-FL8wau01K3h5XbW1ghGrGhrF8jrP5xSWYTy8f5XXAYcH-r";

      /// user
      case AppLogAction.closeShift:
        return "https://discord.com/api/webhooks/1423486364652929054/ay0y8vLjIqcoqpWNuhARUZIEfoPNHQfXAmLoiJsXZiqT7FmPm-CvwOY4UnieOIUSnNHV";

      /// menu
      case AppLogAction.getCategory:
        return "https://discord.com/api/webhooks/1423122150956466256/WdZ8_-BDh7eDAT1Tjw0kDOgJmUtRfSLNMepzWzUQBCSgHgsQdMBcWrlHiw2MEdYeuNC2";
      case AppLogAction.getProduct:
        return "https://discord.com/api/webhooks/1423122398781112370/JIVD0bHnnrxxgYe-pRWcNs44QBZecw3y-pX1D-NTgveU2qvwx074aZ0ZBXz6gRtTi29r";

      /// printer
      case AppLogAction.getIpPrinterOrder:
        return "https://discord.com/api/webhooks/1423486782074257418/hgS2eh22kogXjrqNAzGJMdsSxNQqhciX_ckiDHtE2fyC9j68l_7zV2Nb7p3CGbbLI_zG";
      case AppLogAction.pingPrinter:
        return "https://discord.com/api/webhooks/1423486784473661511/zzKFIcSHLzJHmWhRXUBW_1k3H89Y5UBUtgg-GCV0T6G1aPrhfGmPhqRq5LXfBoS_SBzW";
      case AppLogAction.print:
        return "https://discord.com/api/webhooks/1430442863199653921/l2ZSs9nURSI_9x8nUjLL5BGSg1qE86QLdlzOT8QRFWUYqjJrUVZQiFwa2nru2gklNuUg";

      /// order
      case AppLogAction.getOrders:
        return "https://discord.com/api/webhooks/1423126226188501166/Bk7CX2nadlkZ2P6Qeni8WQrWN0szhUNiciNvDoaGpbqVeqPSECefCO1INSIlq4tEWiPE";
      case AppLogAction.createAndUpdateOrder:
        return "https://discord.com/api/webhooks/1423126229183234130/_a3rgNIqmDQMiXNvHUtfWzGOR9dIG2mGv5XD5J9EGA6fiSACBlLAWQYSsCmNCXFl72lM";

      /// data bill
      case AppLogAction.getDataBill:
        return "https://discord.com/api/webhooks/1423126729136013333/094su3H1AMaTTRkRt6UwYgIOW4elb3O7EXBZixFd2ahoRZ5GbHY44yuIi0RbdbBx_H1P";
      case AppLogAction.checkStatusLockOrder:
      case AppLogAction.getStatusLockOrder:
        return "https://discord.com/api/webhooks/1423491844171632793/KSS4NgZ9duHXx1nyz_rjAbqf-6e4ofkBlYhA2t4w8RIZsqgzSc6zktGLR8ibv-ssLUD4";
      case AppLogAction.lockOrder:
        return "https://discord.com/api/webhooks/1423126566069731369/wny7y1U5r8FAgcYBgX2dn4a3bWnz27XVOcSsrjshfGwiDcdBiSYw1shi9RUIarf0bvlZ";

      /// process-order
      case AppLogAction.processOrder:
      case AppLogAction.processOrderBill:
        return "https://discord.com/api/webhooks/1423126233423548496/tjSKTZoGQ6r6lh1pPC8pR1k5XNCLFyLuF5qjcb6W4hK4ClcXUBD3-kRSq8HWJFscO8MU";
      case AppLogAction.cancelDishBill:
      case AppLogAction.cancelDish:
        return "https://discord.com/api/webhooks/1423134620236513370/tGAd1nVsMZWn9qXhsaPjC1AYDlgT5xBp_zFPz4AH0iKwok8lDR4t5d3jYgsQnr1v1mDq";

      /// get product checkout
      case AppLogAction.getProductCheckout:
        return "https://discord.com/api/webhooks/1423126227106922597/q1tD17Ywas1HRWmfujXcAJW6p1I6Zh60T4w78yHfUW1k-JacTu-Z4rFaXy9UFGbg-WDK";

      /// payment
      case AppLogAction.completeBill:
        return "https://discord.com/api/webhooks/1423126564702392430/w9TU_3QGFZFmYQf0zelew3KJhOikPOgG52Ojw1iVjCScpw25WDzgN6fa0qp5OXwBlwzg";
      case AppLogAction.payment:
        return "https://discord.com/api/webhooks/1423126731216388098/Gp2fltVULBgOD6tRHKWiHtARTklYS6bKva1v0r1hbUXwVNXuYrjRxZmZmVEcy6ox5wPC";
      case AppLogAction.updateTax:
        return "https://discord.com/api/webhooks/1423126555168735232/bC4bEoDz4QHeTSFiokvA-JHlyBjsc4YuTov-VFOiye1rn076_wHAeVO-h607ppl42gLh";
      case AppLogAction.getPaymentGateway:
        return "https://discord.com/api/webhooks/1423126053634834532/xCgd_bUW07SDt3GFC2X4ZJcvTjhfcf6uK9sLPQbrZ6Tg2p8C0c-aQjkuxHn6ErNW4uEC";
      case AppLogAction.posCallback:
        return "https://discord.com/api/webhooks/1423126225471148082/IE0bDo334I9dn1wmw3vtEEzU-pEv0gpDjc-O_IfV9uHtU2G0dZmpiyzxHpKyvDQXUSAY";

      /// customer
      case AppLogAction.findCustomer:
        return "https://discord.com/api/webhooks/1423124731443286016/u4ot5jc1flKz557idKbO1rbG4z2XzhEzFJ1x2Ic61Pl4vNshWRRwfjMrfWbaDQY-qrw0";
      case AppLogAction.createCustomer:
        return "https://discord.com/api/webhooks/1423124861433155730/KR7KIXt-5aji8gg3D4Wh510sN5Gpa4Fjpm8u1vRGjVf4W4nbTntwFj3BHshguHX0hlWw";
      case AppLogAction.resetCustomer:
        return "https://discord.com/api/webhooks/1423126564937269319/Zq4EO-W9b6A8qRQ8dARFUJcblsK28QoyhOaiOPaPFJqlUuE_ajeYjscSOrD_ks_cowEq";

      // restaurant
      case AppLogAction.getBanks:
        return "https://discord.com/api/webhooks/1423125284231577674/fGH108chohNQY4ho4nVq78OS_45GJiMSj42EysAP1H7rtPTmwcgRRB-5sO2wf2f3ReyS";
      case AppLogAction.getPaymentMethod:
        return "https://discord.com/api/webhooks/1423126052838047815/ZH6gdzzital6qkM4dZb9pJ9WcJzrXmxy9m-QY15aLgWIlzB5jupwT4VM9HqjvGmUlNgV";
      case AppLogAction.getListAtmPos:
        return "https://discord.com/api/webhooks/1423126053865390213/N7tDSAFLSAOfTssR5VPoVbR4JM2vv-XibxRAdsQ9uHjG1e7iW7q8O7YHNuG0OSYQ_Jtb";
      case AppLogAction.historyOrder:
        return "https://discord.com/api/webhooks/1423492091803205725/GzSOq9seHlCEO_0itJfrc9Jpri-5M3w8YCMZviIY0SuewJj8nDaRDn2H61Zfd0q8DOtq";
      case AppLogAction.getEmployeeSales:
        return "https://discord.com/api/webhooks/1423126054276435969/WjrpJynwg70Bb1uOPrVftb-QsCck3SnQDO5SdWN_UR_6TlzEfv9bZ5NtzGTfVfAWv0TU";

      /// invoice
      case AppLogAction.getInfoByTaxCode:
        return "https://discord.com/api/webhooks/1423125628731003002/ny_nzen96gORoqXx_bemfKEX_B1r0ZdsZv86S3ZeaHDJiwrj7cFEgdJq3BtfBPMVmSQp";
      case AppLogAction.updateOrderInvoice:
        return "https://discord.com/api/webhooks/1423126566296096941/ASPEySc_VuZ_jaZxuaMdFWLYpL8vj0imOjYVIU8cNUYtQkuRCZtFb8Hau4acqp-n2izH";
      case AppLogAction.getOrderInvoice:
        return "https://discord.com/api/webhooks/1423490890411933843/THf55BPXfHi3QRzWL6gNtJnks8hfnkG24pa-GsoCbYOjZCZN3NZJ1_w8oQg1zPv_2FFS";

      /// coupons
      case AppLogAction.addCoupon:
      case AppLogAction.addVoucher:
        return "https://discord.com/api/webhooks/1423124288935952394/B9smrxNw9b-mEaLudEOfcb1TktHkQq9GFhuWsZlCVixw9qdzEXs0uhn4cbmPMh_km0jF";
      case AppLogAction.deleteCoupon:
      case AppLogAction.deleteVoucher:
        return "https://discord.com/api/webhooks/1423124397266567211/PX80PaVmiuLsCxtNDpTgvMOEkt891mE5QPmQTCBJQAyhbOuNX6svcQVnR5rywHfBSG2I";
      // áp lại mã giảm giá
      case AppLogAction.applyPolicy:
        return "https://discord.com/api/webhooks/1423485683066077206/CXsGve47UsmZziZYObWD-tVqC6gz-Wuc8Xh3H177vDOGxEhQ5aYTRrRA0MQD2wmKaPzA";

      /// ticket
      case AppLogAction.getTickets:
        return "https://discord.com/api/webhooks/1423123770096357488/9q4MkLC1s67oscsdhW2gJWCk7VYjIOcK-1BpJytqTKaCyHX0kVw1a3lyNM4ZNeimS81h";
      case AppLogAction.createTicket:
        return "https://discord.com/api/webhooks/1423123832968974347/810yZ2Mt4_Pzr-uXGWDgQ7Khz9Ul-RwinyzgmuP2GjBgLgF-3yYfQ-9xUmUDCIFi4UYJ";

      /// rerservation
      case AppLogAction.syncReservation:
        return "https://discord.com/api/webhooks/1423125645268877333/XNp-_JabJNSL0zqDsc1YV2Y9M-ou9ZHqZYUYNMdSuC3d-jcf0BW4mz5LOptLPLYZ1axb";
      case AppLogAction.getReservations:
      case AppLogAction.getReservationById:
        return "https://discord.com/api/webhooks/1423126051990798456/4w2vwsiOBLeIwFsGn2ai1ItQ63yy4HRgbk0tE5kPovzUHjIQsLVdHRM6KpvFSKQCHXOY";
      case AppLogAction.updateReservation:
        return "https://discord.com/api/webhooks/1423125644086214788/qCa7YMHimy4Dmjk8udU1I80L5HJeqD4ipng-p6mjrkQyioVSRIclX98-UR251FduESKU";

      /// o2o
      case AppLogAction.getOrderToOnline:
        return "https://discord.com/api/webhooks/1423145780306382851/pAhBabNPZLcJyYauc_rvfTW1jEhAX-1if5hzgeL97DjIlJaoBdAkX0Ctob6tL_0zFFhg";
      case AppLogAction.processO2oRequest:
        return "https://discord.com/api/webhooks/1423145784102354994/dM9dYVbYKqJ-j07EGw5n-ZfWr-jNkALV5T-8-qw3hnzBQ3kP1fkKHlJhJjr584v40KdR";
      case AppLogAction.getChatMessages:
        return "https://discord.com/api/webhooks/1423145785998184469/URD8kYwdmwn-ncLUxTrvk1cJEgP1jyiZx9u6OJyWmVnz0IydiBtdkosnwNYoqu7URzcZ";
      case AppLogAction.getO2oCustomerInfo:
        return "https://discord.com/api/webhooks/1423492320371806309/YgVAtxJ2DniB1DcaswsDJbk5KXF_AnmYAuSF6AJ6Uo-GKJ2vAwoGfATPHhSsGIxlUsCL";

      ///
      case AppLogAction.localStorage:
        return "https://discord.com/api/webhooks/1430441912585683028/7NtlmkrYKX7Rm5yrhlQk8PufXv9iYAPKHQ1x4DdQaqKj9ej2zbNyZs0z8Vj_0pNUvZpG";
      case AppLogAction.webContentConverter:
        return "https://discord.com/api/webhooks/1430441054917754892/3yWBN09OSd4t3tib6rqwaetmtxTLGBc9wHjHKRS9TMgDPxIGyEiiRsGx683_otfhGzAF";

      default:
        return "https://discord.com/api/webhooks/1423122133457829979/444iMuTJBQJTQ7iIFeFC1j2XQVASkt2dp1-QbY7wx5kxEeSaHE7fWC9cr2815q7G7csI";
    }
  }

  int get telegramTopic {
    switch (this) {
      // login
      case AppLogAction.loginSuccess:
      case AppLogAction.login:

      // user
      case AppLogAction.closeShift:
      // category + product
      case AppLogAction.getCategory:
      case AppLogAction.getProduct:
      // data bill
      case AppLogAction.getDataBill:
      // printer
      case AppLogAction.getIpPrinterOrder:
      case AppLogAction.pingPrinter:
      // order
      case AppLogAction.getOrders:
      case AppLogAction.createAndUpdateOrder:
      case AppLogAction.checkStatusLockOrder:
      case AppLogAction.getStatusLockOrder:
      case AppLogAction.lockOrder:
      case AppLogAction.updateOrderInvoice:
      case AppLogAction.getOrderInvoice:
      // process-order
      case AppLogAction.processOrder:
      case AppLogAction.processOrderBill:
      case AppLogAction.cancelDishBill:
      case AppLogAction.cancelDish:
      // get product checkout
      case AppLogAction.getProductCheckout:
      // payment
      case AppLogAction.completeBill:
      case AppLogAction.payment:
      case AppLogAction.updateTax:
      case AppLogAction.getPaymentGateway:
      case AppLogAction.posCallback:
      // customer
      case AppLogAction.findCustomer:
      case AppLogAction.createCustomer:
      case AppLogAction.resetCustomer:
      // áp lại mã giảm giá
      case AppLogAction.applyPolicy:
      // restaurant
      case AppLogAction.getBanks:
      case AppLogAction.getPaymentMethod:
      case AppLogAction.getListAtmPos:
      case AppLogAction.historyOrder:
      case AppLogAction.getInfoByTaxCode:
      case AppLogAction.getEmployeeSales:

      // coupons
      case AppLogAction.addCoupon:
      case AppLogAction.deleteCoupon:
      // ticket
      case AppLogAction.getTickets:
      case AppLogAction.createTicket:
      case AppLogAction.localStorage:
      default:
        return 1;
    }
  }
}
