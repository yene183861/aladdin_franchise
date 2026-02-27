// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static String m0(title) =>
      "Xác nhận đổi ngôn ngữ màn hình KH sang [${title}]?";

  static String m1(title) =>
      "Xác nhận đổi ngôn ngữ sang [${title}]?\nCHÚ Ý:Phần mềm sẽ khởi động lại sau khi thay đổi ngôn ngữ.";

  static String m2(fromTable, toTable) =>
      "Chuyển từ bàn ${fromTable} sang ${toTable}";

  static String m3(coupon_length, coupons, payment_method) =>
      "Có [${coupon_length}] mã giảm giá [${coupons}] không được phép dùng với PTTT ([${payment_method}]).\n Vui lòng xoá bỏ mã hoặc chọn phương thức thanh toán khác!";

  static String m4(coupon) =>
      "Hãy xoá và nhập lại mã giảm giá ([${coupon}]) rồi áp dụng!";

  static String m5(restaurant_name) =>
      "Cảm ơn đã lựa chọn ${restaurant_name}. Chúc quý khách ngon miệng!";

  static String m6(count) =>
      "Có ${count} lịch đặt bàn đã được lễ tân tiếp nhận ứng với các bàn bạn đã chọn.\nNếu là khách đã đặt bàn trước, vui lòng chọn lịch đặt bàn trước khi bấm xác nhận!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accPoints": MessageLookupByLibrary.simpleMessage("Điểm tích luỹ"),
        "accept": MessageLookupByLibrary.simpleMessage("Chấp nhận"),
        "accept_all_payment_method": MessageLookupByLibrary.simpleMessage(
            "Tất cả phương thức thanh toán đều được sử dụng"),
        "accepted": MessageLookupByLibrary.simpleMessage("Đã xác nhận"),
        "accepted_reser": MessageLookupByLibrary.simpleMessage("Đã tiếp nhận"),
        "accumulated_money":
            MessageLookupByLibrary.simpleMessage("Tiền tích luỹ"),
        "action": MessageLookupByLibrary.simpleMessage("Hành động"),
        "action_when_ping_printer_error": MessageLookupByLibrary.simpleMessage(
            "VUI LÒNG KIỂM TRA & ĐẢM BẢO\n- Tablet và máy tính đã kết nối mạng Order\n- Máy in đã bật và không bị kẹt giấy\n- Dây mạng kết nối với máy in đã sáng"),
        "active": MessageLookupByLibrary.simpleMessage("Hoạt động"),
        "add_attachment":
            MessageLookupByLibrary.simpleMessage("Thêm tệp đính kèm"),
        "add_customer_information":
            MessageLookupByLibrary.simpleMessage("Thêm thông tin khách hàng"),
        "add_invoice_information":
            MessageLookupByLibrary.simpleMessage("Thêm thông tin hoá đơn"),
        "add_item_to_order":
            MessageLookupByLibrary.simpleMessage("Thêm món vào đơn bàn"),
        "add_notes": MessageLookupByLibrary.simpleMessage("Thêm ghi chú"),
        "add_to_order": MessageLookupByLibrary.simpleMessage("Thêm vào đơn"),
        "address": MessageLookupByLibrary.simpleMessage("Địa chỉ"),
        "adjust_font_size":
            MessageLookupByLibrary.simpleMessage("Sử dụng tăng giảm cỡ chữ"),
        "agree": MessageLookupByLibrary.simpleMessage("Đồng ý"),
        "all": MessageLookupByLibrary.simpleMessage("Tất cả"),
        "allow": MessageLookupByLibrary.simpleMessage("Cho phép"),
        "amountPayment":
            MessageLookupByLibrary.simpleMessage("Tiền thanh toán"),
        "amount_received":
            MessageLookupByLibrary.simpleMessage("Số tiền đã nhận"),
        "an_error_has_occurred":
            MessageLookupByLibrary.simpleMessage("Đã có lỗi xảy ra."),
        "an_error_occurred": MessageLookupByLibrary.simpleMessage(
            "Có lỗi xảy ra, vui lòng thử lại"),
        "and": MessageLookupByLibrary.simpleMessage("và"),
        "another_time": MessageLookupByLibrary.simpleMessage("Lúc khác"),
        "app_language":
            MessageLookupByLibrary.simpleMessage("Ngôn ngữ ứng dụng"),
        "applied_policy":
            MessageLookupByLibrary.simpleMessage("Đang áp dụng mã giảm giá"),
        "apply": MessageLookupByLibrary.simpleMessage("Áp dụng"),
        "applyProducts":
            MessageLookupByLibrary.simpleMessage("Sản phẩm áp dụng"),
        "apply_all": MessageLookupByLibrary.simpleMessage("Áp dụng toàn bộ"),
        "apply_policy_after_change_adults":
            MessageLookupByLibrary.simpleMessage(
                "Khi thay đổi số khách, vui lòng áp dụng lại"),
        "apply_policy_again":
            MessageLookupByLibrary.simpleMessage("Áp dụng lại"),
        "apply_with_combo_item": MessageLookupByLibrary.simpleMessage(
            "áp dụng với món thành phần trong Set/Combo"),
        "ask_customer_pay_via_card_machine":
            MessageLookupByLibrary.simpleMessage(
                "Vui lòng yêu cầu khách hàng thanh toán qua máy cà thẻ."),
        "at_the_printer": MessageLookupByLibrary.simpleMessage("Tại máy in"),
        "attach_three_image":
            MessageLookupByLibrary.simpleMessage("Đính kèm (Tối đa 3 ảnh)"),
        "attached_image": MessageLookupByLibrary.simpleMessage("Ảnh đính kèm"),
        "attached_image_purpose": MessageLookupByLibrary.simpleMessage(
            "Voucher, CMT, Bill chuyển khoản,..."),
        "attention": MessageLookupByLibrary.simpleMessage("Chú ý"),
        "attention_canceled_print": MessageLookupByLibrary.simpleMessage(
            "Đã huỷ món, nhưng không thể in hoá đơn"),
        "attention_confirm_info_customer": MessageLookupByLibrary.simpleMessage(
            "Bạn chưa nhập thông tin khách hàng cho Bill thanh toán.\nBạn vẫn muốn thực hiện in bill để Hoàn tất thanh toán?"),
        "attention_endow_has_not_been_applied_successfully":
            MessageLookupByLibrary.simpleMessage(
                "CHÚ Ý: Ưu đãi áp dụng chưa thành công"),
        "attention_processed_print": MessageLookupByLibrary.simpleMessage(
            "Đã gọi món, nhưng không thể in hoá đơn"),
        "attention_unknown_sale": MessageLookupByLibrary.simpleMessage(
            "Lưu ý*: Không có nhân viên sale, vui lòng chọn không xác định"),
        "attention_unknown_sale_1": MessageLookupByLibrary.simpleMessage(
            "Không có nhân viên sale, vui lòng chọn \"Không xác định\""),
        "authentication_unlocked":
            MessageLookupByLibrary.simpleMessage("Đã mở khoá xác thực"),
        "available_online":
            MessageLookupByLibrary.simpleMessage("CÓ bán online"),
        "bOD": MessageLookupByLibrary.simpleMessage("Sinh nhật"),
        "backup_server":
            MessageLookupByLibrary.simpleMessage("Máy chủ dự phòng"),
        "bank": MessageLookupByLibrary.simpleMessage("Ngân hàng"),
        "bank_account":
            MessageLookupByLibrary.simpleMessage("Tài khoản ngân hàng"),
        "bank_account_not_setup": MessageLookupByLibrary.simpleMessage(
            "Tài khoản ngân hàng chưa được thiết lập"),
        "bank_not_select": MessageLookupByLibrary.simpleMessage(
            "Chưa chọn tài khoản ngân hàng"),
        "bank_number": MessageLookupByLibrary.simpleMessage("Số tài khoản"),
        "bill": MessageLookupByLibrary.simpleMessage("Phiếu thanh toán"),
        "billTotal": MessageLookupByLibrary.simpleMessage("Tổng bill"),
        "bill_type": MessageLookupByLibrary.simpleMessage("Loại bill"),
        "bod": MessageLookupByLibrary.simpleMessage("Ngày sinh"),
        "bring_up": MessageLookupByLibrary.simpleMessage("Mang lên"),
        "btav": MessageLookupByLibrary.simpleMessage("Bánh tráng An Vũ"),
        "btav_slogan": MessageLookupByLibrary.simpleMessage(
            "Đặc sản bánh tráng heo quay Hà Nội"),
        "btqm": MessageLookupByLibrary.simpleMessage("Bò Tơ Quán Mộc"),
        "btqmSlogan":
            MessageLookupByLibrary.simpleMessage("Vẻ đẹp phố xưa Hà Nội"),
        "budget_relationship_unit_code":
            MessageLookupByLibrary.simpleMessage("Mã đơn vị quan hệ ngân sách"),
        "callMore": MessageLookupByLibrary.simpleMessage("Gọi thêm"),
        "call_staff": MessageLookupByLibrary.simpleMessage("Gọi nhân viên"),
        "called": MessageLookupByLibrary.simpleMessage("Đã gọi"),
        "calledProducts":
            MessageLookupByLibrary.simpleMessage("Sản phẩm đã gọi"),
        "callingProducts":
            MessageLookupByLibrary.simpleMessage("Sản phẩm đang gọi"),
        "canNotLoadOrder":
            MessageLookupByLibrary.simpleMessage("Không thể tải đon bàn"),
        "canNotLoadTables":
            MessageLookupByLibrary.simpleMessage("Không thể tải danh sách bàn"),
        "can_not_check_payment_method": MessageLookupByLibrary.simpleMessage(
            "Không thể kiểm tra phương thức thanh toán!"),
        "can_not_read_info": MessageLookupByLibrary.simpleMessage(
            "Không thể đọc được thông tin"),
        "cancel": MessageLookupByLibrary.simpleMessage("Huỷ"),
        "cancelDish": MessageLookupByLibrary.simpleMessage("Huỷ món"),
        "cancelOrder": MessageLookupByLibrary.simpleMessage("Huỷ đơn bàn"),
        "cancelOrderCurrent":
            MessageLookupByLibrary.simpleMessage("Huỷ đơn bàn"),
        "cancelOrderSuccess":
            MessageLookupByLibrary.simpleMessage("Huỷ đơn bàn thành công!"),
        "cancelRequest": MessageLookupByLibrary.simpleMessage("Yêu cầu huỷ"),
        "cancel_dish": MessageLookupByLibrary.simpleMessage("Huỷ món"),
        "cancel_dish_and_not_print": MessageLookupByLibrary.simpleMessage(
            "Bạn có muốn huỷ món mà không in bill xuống bếp, bar?"),
        "cancel_order":
            MessageLookupByLibrary.simpleMessage("Đang huỷ đơn bàn"),
        "cancel_payment_method_if_customer_not_paid":
            MessageLookupByLibrary.simpleMessage(
                "Nếu khách hàng chưa thanh toán, Phương thức thanh toán sẽ bị huỷ bỏ sau khi đóng cổng."),
        "canceled": MessageLookupByLibrary.simpleMessage("Đã huỷ"),
        "canceled_reser": MessageLookupByLibrary.simpleMessage("Khách báo huỷ"),
        "canceling": MessageLookupByLibrary.simpleMessage("Đang huỷ"),
        "canceling_request":
            MessageLookupByLibrary.simpleMessage("Đang huỷ yêu cầu"),
        "cancellation_reason":
            MessageLookupByLibrary.simpleMessage("Lý do huỷ"),
        "cancellation_request_is_pending":
            MessageLookupByLibrary.simpleMessage("Yêu cầu huỷ đang chờ xử lý"),
        "cancelling_item":
            MessageLookupByLibrary.simpleMessage("Đang hủy món..."),
        "cart": MessageLookupByLibrary.simpleMessage("Giỏ hàng"),
        "change_returned":
            MessageLookupByLibrary.simpleMessage("Tiền thừa trả lại"),
        "changing_form_of_sell_mode": MessageLookupByLibrary.simpleMessage(
            "Đang chuyển đổi hình thức bán"),
        "chat_with_customers":
            MessageLookupByLibrary.simpleMessage("Chat với khách hàng"),
        "check": MessageLookupByLibrary.simpleMessage("Kiểm tra"),
        "checkForUpdate":
            MessageLookupByLibrary.simpleMessage("Kiểm tra cập nhật"),
        "check_items": MessageLookupByLibrary.simpleMessage("Kiểm đồ"),
        "check_other_device_locked_order": MessageLookupByLibrary.simpleMessage(
            "Vui lòng kiểm tra các thiết bị khác sử dụng cùng đơn bàn!"),
        "check_printer_status":
            MessageLookupByLibrary.simpleMessage("Kiểm tra trạng thái máy in"),
        "check_the_order_status_again": MessageLookupByLibrary.simpleMessage(
            "Kiểm tra lại trạng thái đơn bàn"),
        "checking": MessageLookupByLibrary.simpleMessage("Đang kiểm tra"),
        "checking_connection":
            MessageLookupByLibrary.simpleMessage("Kiểm tra kết nối"),
        "checking_payment_method": MessageLookupByLibrary.simpleMessage(
            "Đang kiểm tra phương thức thanh toán"),
        "checking_printer_status": MessageLookupByLibrary.simpleMessage(
            "Đang kiểm tra trạng thái máy in"),
        "chinese": MessageLookupByLibrary.simpleMessage("Tiếng Trung"),
        "choose_card_machine":
            MessageLookupByLibrary.simpleMessage("Chọn máy cà thẻ"),
        "choose_printer_o2o": MessageLookupByLibrary.simpleMessage(
            "Chọn máy in QR gọi món tại bàn"),
        "choose_reservation":
            MessageLookupByLibrary.simpleMessage("Chọn bàn đặt"),
        "chose": MessageLookupByLibrary.simpleMessage("Chọn"),
        "citizen_id_card":
            MessageLookupByLibrary.simpleMessage("Căn cước công dân"),
        "close": MessageLookupByLibrary.simpleMessage("Đóng"),
        "close_payment_slip_reapply_coupons": MessageLookupByLibrary.simpleMessage(
            "Vui lòng đóng phiếu thanh toán, kiểm tra & áp dụng lại để tiếp tục"),
        "closing_order_payment":
            MessageLookupByLibrary.simpleMessage("Đang đóng thanh toán"),
        "closing_shift_success":
            MessageLookupByLibrary.simpleMessage("Chốt ca thành công"),
        "code": MessageLookupByLibrary.simpleMessage("Mã"),
        "code_limit_payment_method": MessageLookupByLibrary.simpleMessage(
            "Mã có giới hạn Phương thức thanh toán"),
        "code_validation_enabled":
            MessageLookupByLibrary.simpleMessage("Đã bật xác thực mã"),
        "come_back": MessageLookupByLibrary.simpleMessage("Quay lại"),
        "company_name": MessageLookupByLibrary.simpleMessage("Tên công ty"),
        "complete": MessageLookupByLibrary.simpleMessage("Hoàn thành"),
        "complete_order":
            MessageLookupByLibrary.simpleMessage("Hoàn thành đơn bàn"),
        "complete_payment":
            MessageLookupByLibrary.simpleMessage("Hoàn tất thanh toán"),
        "completed": MessageLookupByLibrary.simpleMessage("Hoàn tất"),
        "completed_reser": MessageLookupByLibrary.simpleMessage("Hoàn thành"),
        "completing_order":
            MessageLookupByLibrary.simpleMessage("Đang hoàn thành đơn..."),
        "completing_payment_verification": MessageLookupByLibrary.simpleMessage(
            "Đang hoàn tất xác nhận thanh toán..."),
        "complimentary_gift":
            MessageLookupByLibrary.simpleMessage("Món tặng không thu tiền"),
        "complimentary_item":
            MessageLookupByLibrary.simpleMessage("Hàng tặng không thu tiền"),
        "conditions_and_products_apply": MessageLookupByLibrary.simpleMessage(
            "Điều kiện & sản phẩm áp dụng"),
        "config": MessageLookupByLibrary.simpleMessage("Thiết lập"),
        "confirm": MessageLookupByLibrary.simpleMessage("Xác nhận"),
        "confirmCancelDish":
            MessageLookupByLibrary.simpleMessage("Xác nhận huỷ món"),
        "confirm_before_complete_order": MessageLookupByLibrary.simpleMessage(
            "Vui lòng kiểm tra và xác minh xem khách hàng đã thanh toán hay chưa.\nNếu có, hãy đính kèm hình ảnh biên lai để đối chiếu trước khi bấm xác nhận."),
        "confirm_cancel_dish":
            MessageLookupByLibrary.simpleMessage("Xác nhận huỷ món đã chọn"),
        "confirm_cancel_order_has_reservation":
            MessageLookupByLibrary.simpleMessage(
                "Đơn bàn hiện đang được gán với lịch đặt bàn.Việc huỷ đơn bàn sẽ đồng thời chuyển lịch đặt sang trạng thái \"Huỷ lịch\".\nNếu không muốn huỷ lịch, vui lòng cập nhật lịch đặt bàn trước khi huỷ bàn."),
        "confirm_change_customer_language": m0,
        "confirm_change_language": m1,
        "confirm_close_shift": MessageLookupByLibrary.simpleMessage(
            "Bạn có muốn thực hiện chốt ca?"),
        "confirm_complete_order_with_sale":
            MessageLookupByLibrary.simpleMessage(
                "Bạn có chắc chắn muốn hoàn thành đơn với nhân viên sale này?"),
        "confirm_creation_of_bill_payment":
            MessageLookupByLibrary.simpleMessage(
                "Xác nhận tạo Phiếu thanh toán"),
        "confirm_delete_code_and_continue":
            MessageLookupByLibrary.simpleMessage("Xác nhận xoá mã & tiếp tục"),
        "confirm_delete_invoice":
            MessageLookupByLibrary.simpleMessage("Bạn có muốn xóa hóa đơn?"),
        "confirm_delete_notification": MessageLookupByLibrary.simpleMessage(
            "Bạn có muốn xoá tất cả thông báo?"),
        "confirm_payment_done": MessageLookupByLibrary.simpleMessage(
            "Bạn đã hoàn tất thanh toán cho khách hàng?"),
        "confirm_payment_tmp": MessageLookupByLibrary.simpleMessage(
            "Bạn có muốn hoàn thành và in bill hay không?"),
        "confirm_rating_to_payment_post": MessageLookupByLibrary.simpleMessage(
            "trước khi Tạo phiếu thanh toán"),
        "confirm_rating_to_payment_pre":
            MessageLookupByLibrary.simpleMessage("Bạn vui lòng kiểm tra lại"),
        "confirm_reload_payment_gateway": MessageLookupByLibrary.simpleMessage(
            "Bạn muốn tải lại cổng thanh toán?"),
        "confirm_transfer_table": m2,
        "confirmation_content":
            MessageLookupByLibrary.simpleMessage("Ghi chú món"),
        "confirmation_from_waiter":
            MessageLookupByLibrary.simpleMessage("Xác nhận của phục vụ"),
        "congratulations":
            MessageLookupByLibrary.simpleMessage("Xin chúc mừng!"),
        "connecting_payment_verification_server":
            MessageLookupByLibrary.simpleMessage(
                "Đang kết nối máy chủ xác minh thanh toán..."),
        "connection_lost": MessageLookupByLibrary.simpleMessage("Mất kết nối"),
        "content": MessageLookupByLibrary.simpleMessage("Nội dung"),
        "content_help_move_table": MessageLookupByLibrary.simpleMessage(
            "- Chuyển bàn hiện tại sang bàn khác -> Bỏ chọn bàn hiện tại và chọn bàn cần chuyển\n- Thêm bàn chưa sử dụng vào đơn bàn hiện tại -> Chỉ cần chọn bàn\n- Loại bỏ bàn trong đơn bàn hiện tại -> Bỏ chọn bàn cần loại bỏ trong danh sách"),
        "content_help_select_waiter": MessageLookupByLibrary.simpleMessage(
            "Chuyển đơn bàn hiện tại cho phục vụ khác -> Chỉ cần chọn phục vụ"),
        "continue_payment":
            MessageLookupByLibrary.simpleMessage("Tiếp tục thanh toán"),
        "continue_text": MessageLookupByLibrary.simpleMessage("Tiếp tục"),
        "coupon_condition_apply":
            MessageLookupByLibrary.simpleMessage("Điều kiện áp dụng"),
        "createNewCustomers":
            MessageLookupByLibrary.simpleMessage("Tạo khách hàng mới"),
        "createNewOrder":
            MessageLookupByLibrary.simpleMessage("Tạo đơn bàn mới"),
        "create_bill_payment":
            MessageLookupByLibrary.simpleMessage("Tạo phiếu thanh toán"),
        "create_invoices": MessageLookupByLibrary.simpleMessage("Tạo hoá đơn"),
        "create_new_customers_via_Zalo_OA":
            MessageLookupByLibrary.simpleMessage(
                "Tạo khách hàng mới qua Zalo-OA"),
        "create_print_bill_failed":
            MessageLookupByLibrary.simpleMessage("Tạo phiếu in thất bại!"),
        "create_ticket_apos_lite_sys": MessageLookupByLibrary.simpleMessage(
            "Tạo ticket (Hệ thống APOS Lite)"),
        "createdNewOrder":
            MessageLookupByLibrary.simpleMessage("Đã tạo đơn mới"),
        "creating": MessageLookupByLibrary.simpleMessage("Đang tạo"),
        "creating_a_new_order":
            MessageLookupByLibrary.simpleMessage("Đang tạo đơn mới"),
        "creating_customer":
            MessageLookupByLibrary.simpleMessage("Đang tạo khách hàng"),
        "current_account":
            MessageLookupByLibrary.simpleMessage("Tài khoản hiện tại"),
        "current_font_size":
            MessageLookupByLibrary.simpleMessage("Cỡ chữ hiện tại"),
        "current_language_use":
            MessageLookupByLibrary.simpleMessage("Phần mềm đang sử dụng"),
        "current_order":
            MessageLookupByLibrary.simpleMessage("Đơn bàn hiện tại"),
        "customerPolicy":
            MessageLookupByLibrary.simpleMessage("Chính sách khách hàng"),
        "customer_gets_invoice":
            MessageLookupByLibrary.simpleMessage("Khách lấy hoá đơn"),
        "customer_information":
            MessageLookupByLibrary.simpleMessage("Thông tin khách hàng"),
        "customer_not_paid":
            MessageLookupByLibrary.simpleMessage("Khách hàng chưa thanh toán"),
        "customer_paid":
            MessageLookupByLibrary.simpleMessage("Khách hàng đã thanh toán"),
        "customer_portrait":
            MessageLookupByLibrary.simpleMessage("Nhóm chân dung"),
        "customer_portrait_has_not_been_selected":
            MessageLookupByLibrary.simpleMessage("Chưa chọn nhóm chân dung"),
        "customer_portrait_not_setup": MessageLookupByLibrary.simpleMessage(
            "Nhóm chân dung chưa được thiết lập, vui lòng đăng nhập lại!"),
        "customer_portrait_select_portrait_group":
            MessageLookupByLibrary.simpleMessage("Chọn nhóm chân dung"),
        "customer_rating_not_setup": MessageLookupByLibrary.simpleMessage(
            "Câu hỏi đánh giá chưa được thiết lập"),
        "customer_request_cancel":
            MessageLookupByLibrary.simpleMessage("Khách báo huỷ"),
        "customer_reviews":
            MessageLookupByLibrary.simpleMessage("Đánh giá của khách hàng"),
        "customer_reviews_hint": MessageLookupByLibrary.simpleMessage(
            "Chúng tôi luôn lắng nghe mọi góp ý của bạn"),
        "customer_reviews_note":
            MessageLookupByLibrary.simpleMessage("Ý kiến khách hàng"),
        "customer_screen": MessageLookupByLibrary.simpleMessage("Màn hình KH"),
        "customer_screen_language": MessageLookupByLibrary.simpleMessage(
            "Ngôn ngữ màn hình khách hàng"),
        "customer_select_mistake":
            MessageLookupByLibrary.simpleMessage("Khách chọn nhầm"),
        "customer_survey":
            MessageLookupByLibrary.simpleMessage("Khảo sát ý kiến khách hàng"),
        "customers": MessageLookupByLibrary.simpleMessage("Khách hàng"),
        "data_updated":
            MessageLookupByLibrary.simpleMessage("Dữ liệu đã được cập nhật!"),
        "days": MessageLookupByLibrary.simpleMessage("ngày"),
        "default_1": MessageLookupByLibrary.simpleMessage("Mặc định"),
        "deleteCache": MessageLookupByLibrary.simpleMessage("Xoá bộ nhớ đệm"),
        "deleteCacheInfo": MessageLookupByLibrary.simpleMessage(
            "Xoá dữ liệu các món ăn đang chọn và các thông tin thanh toán đã lưu trên thiết bị hiện tại"),
        "deleteDiscountCode":
            MessageLookupByLibrary.simpleMessage("Xoá mã giảm giá"),
        "delete_desired_completion_date": MessageLookupByLibrary.simpleMessage(
            "Xoá bỏ ngày mong muốn hoàn tất"),
        "delete_info": MessageLookupByLibrary.simpleMessage("Xoá thông tin"),
        "deny": MessageLookupByLibrary.simpleMessage("Từ chối"),
        "description": MessageLookupByLibrary.simpleMessage("Mô tả"),
        "desired_completion_date":
            MessageLookupByLibrary.simpleMessage("Ngày mong muốn hoàn tất"),
        "detail": MessageLookupByLibrary.simpleMessage("Chi tiết"),
        "deviceCode": MessageLookupByLibrary.simpleMessage("Mã thiết bị"),
        "deviceIP": MessageLookupByLibrary.simpleMessage("Địa chỉ IP"),
        "dialog_auto_close_after": MessageLookupByLibrary.simpleMessage(
            "Hộp thoại sẽ tự động đóng sau"),
        "disableOnline":
            MessageLookupByLibrary.simpleMessage("Đang TẮT đơn bàn online"),
        "discount": MessageLookupByLibrary.simpleMessage("Giảm giá"),
        "discountCode": MessageLookupByLibrary.simpleMessage("Mã giảm giá"),
        "discount_apply_failed":
            MessageLookupByLibrary.simpleMessage("Áp dụng giảm giá thất bại"),
        "discount_code_already_exists":
            MessageLookupByLibrary.simpleMessage("Mã giảm giá đã tồn tại"),
        "discount_code_applied_item_in_canceled_list":
            MessageLookupByLibrary.simpleMessage(
                "Mã giảm giá đã được áp dụng cho món trong danh sách huỷ."),
        "discount_code_cannot_be_deleted":
            MessageLookupByLibrary.simpleMessage("Không thể xoá mã giảm giá"),
        "discount_code_is_not_valid": MessageLookupByLibrary.simpleMessage(
            "Mã giảm giá không có hiệu lực"),
        "discount_money": MessageLookupByLibrary.simpleMessage("Tiền giảm giá"),
        "discount_title":
            MessageLookupByLibrary.simpleMessage("Giảm giá (VND/%)"),
        "dish_served_late": MessageLookupByLibrary.simpleMessage("Món ra trễ"),
        "dob_not_format": MessageLookupByLibrary.simpleMessage(
            "Ngày sinh không đúng định dạng"),
        "download_manually":
            MessageLookupByLibrary.simpleMessage("Tải về thủ công"),
        "download_via_browser":
            MessageLookupByLibrary.simpleMessage("Tải về bằng trình duyệt"),
        "downloading_update": MessageLookupByLibrary.simpleMessage(
            "Đang tải xuống, vui lòng đợi mở trình cài đặt"),
        "downloading_update_1": MessageLookupByLibrary.simpleMessage(
            "Đang tải bản cập nhật, vui lòng đợi"),
        "driver_not_initialized": MessageLookupByLibrary.simpleMessage(
            "Trình điều khiển chưa được khởi tạo"),
        "edit_tax_information":
            MessageLookupByLibrary.simpleMessage("Chỉnh sửa thông tin thuế"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "email_invalid":
            MessageLookupByLibrary.simpleMessage("Địa chỉ Email không hợp lệ"),
        "empty_orders":
            MessageLookupByLibrary.simpleMessage("Danh sách đơn bàn trống"),
        "enableOnline":
            MessageLookupByLibrary.simpleMessage("Đang BẬT đơn bàn online"),
        "endow": MessageLookupByLibrary.simpleMessage("Ưu đãi"),
        "enterAuthCode":
            MessageLookupByLibrary.simpleMessage("Nhập mã xác thực"),
        "enter_note_content":
            MessageLookupByLibrary.simpleMessage("Nhập nội dung ghi chú"),
        "enter_note_kitchen_or_bar": MessageLookupByLibrary.simpleMessage(
            "Nhập ghi chú cho bếp, bar..."),
        "enter_quantity": MessageLookupByLibrary.simpleMessage("Nhập số lượng"),
        "error": MessageLookupByLibrary.simpleMessage("Lỗi"),
        "errorAndPressAgain":
            MessageLookupByLibrary.simpleMessage("Có lỗi!\nNhấn để thử lại"),
        "error_category_not_set": MessageLookupByLibrary.simpleMessage(
            "Thể loại chưa được thiết lập"),
        "error_change_order": MessageLookupByLibrary.simpleMessage(
            "Tự động chuyển/cập nhật đơn bàn thao tác thất bại.\nVui lòng chọn lại đơn bàn thao tác!"),
        "error_delete_coupon_code":
            MessageLookupByLibrary.simpleMessage("Có lỗi khi xoá mã giảm giá"),
        "error_edit_tax": MessageLookupByLibrary.simpleMessage(
            "Vui lòng nhập thuế khác 0 cho tất cả món trước khi hoàn tất đơn hàng."),
        "error_get_invoice_info": MessageLookupByLibrary.simpleMessage(
            "Không thể lấy thông tin hóa đơn"),
        "error_get_reservations": MessageLookupByLibrary.simpleMessage(
            "Không tải được danh sách bàn đặt! Vui lòng thử lại."),
        "error_loading_bill_image":
            MessageLookupByLibrary.simpleMessage("Lỗi tải ảnh bill"),
        "error_loading_invoice_data":
            MessageLookupByLibrary.simpleMessage("Lỗi tải dữ liệu hoá đơn"),
        "error_loading_order_invoice": MessageLookupByLibrary.simpleMessage(
            "Lỗi khi lấy thông tin hoá đơn"),
        "error_loading_payment_QR_code":
            MessageLookupByLibrary.simpleMessage("Lỗi tải mã QR thanh toán"),
        "error_loading_qr_code":
            MessageLookupByLibrary.simpleMessage("Không thể tải mã QR"),
        "error_min_number_of_adults": MessageLookupByLibrary.simpleMessage(
            "Số lượng người lớn tối thiểu là 1"),
        "error_payment_method": MessageLookupByLibrary.simpleMessage(
            "Lỗi tải phương thức thanh toán"),
        "error_payment_recognition_server_not_configure":
            MessageLookupByLibrary.simpleMessage(
                "Máy chủ nhận dạng thanh toán chưa được thiết lập"),
        "error_percentage_exceed_limit": MessageLookupByLibrary.simpleMessage(
            "Phần trăm không được vượt quá 100%"),
        "error_ping_printer": MessageLookupByLibrary.simpleMessage(
            "Không nhận diện được thông tin máy in đơn bàn\nKIỂM TRA CÁC NGUYÊN NHÂN:\n- Đơn bàn đã được thanh toán\n- Đơn bàn đã bị thay đổi (Chuyển bàn, cập nhật đơn bàn)\nVui lòng kiểm tra và chọn lại đơn bàn thao tác!"),
        "error_price_because_tax_reallocated":
            MessageLookupByLibrary.simpleMessage(
                "Thông tin hóa đơn sai do chưa được phân bổ lại thuế"),
        "error_print_bill_order":
            MessageLookupByLibrary.simpleMessage("Không thể in bill"),
        "error_print_kitechen_bill": MessageLookupByLibrary.simpleMessage(
            "Không in được bill xuống bếp"),
        "error_products_not_set": MessageLookupByLibrary.simpleMessage(
            "Danh sách sản phẩm chưa được thiết lập"),
        "error_reload_menu_check_product_selecting":
            MessageLookupByLibrary.simpleMessage(
                "Lỗi cập nhật món đang chọn.\nNếu tải lại không được, vào menu cá nhân > Xoá bộ nhớ đệm và thử lại."),
        "error_remove_customer_order": MessageLookupByLibrary.simpleMessage(
            "Không thể xóa khách hàng khỏi đơn bàn hiện tại."),
        "error_retrieving_printer_info": MessageLookupByLibrary.simpleMessage(
            "Lỗi truy xuất thông tin máy in"),
        "error_transfer_account":
            MessageLookupByLibrary.simpleMessage("Chuyển tài khoản thất bại."),
        "error_update_order_item": MessageLookupByLibrary.simpleMessage(
            "Danh sách món chưa được cập nhật vào hệ thống!"),
        "ex_problem": MessageLookupByLibrary.simpleMessage("Sự cố"),
        "exclude_tax_discount": MessageLookupByLibrary.simpleMessage(
            "(chưa bao gồm thuế, giảm giá)"),
        "failed_apply_coupons": MessageLookupByLibrary.simpleMessage(
            "Các mã giảm giá chưa được áp dụng thành công."),
        "failed_apply_discount_code": MessageLookupByLibrary.simpleMessage(
            "Áp dụng mã giảm giá không thành công"),
        "failed_connect_payment_verification_server":
            MessageLookupByLibrary.simpleMessage(
                "Kết nối máy chủ xác minh thanh toán thất bại"),
        "failed_initialize_file":
            MessageLookupByLibrary.simpleMessage("Khởi tạo file thất bại"),
        "failed_load_gateway_url": MessageLookupByLibrary.simpleMessage(
            "Tải URL cổng thanh toán thất bại"),
        "failed_payment_closing":
            MessageLookupByLibrary.simpleMessage("Đóng thanh toán thất bại!"),
        "female": MessageLookupByLibrary.simpleMessage("Nữ"),
        "filter_by_brand":
            MessageLookupByLibrary.simpleMessage("Lọc theo thương hiệu"),
        "findCustomer":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm khách hàng"),
        "find_customer_not_found": MessageLookupByLibrary.simpleMessage(
            "Không tìm thấy thông tin khách hàng"),
        "finding_by_tax_code": MessageLookupByLibrary.simpleMessage(
            "Đang tìm thông tin theo mã số thuế"),
        "firstName": MessageLookupByLibrary.simpleMessage("Họ"),
        "food_information":
            MessageLookupByLibrary.simpleMessage("Thông tin món"),
        "food_item": MessageLookupByLibrary.simpleMessage("Món"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Quên mật khẩu?"),
        "forgotPasswordMessage": MessageLookupByLibrary.simpleMessage(
            "Vui lòng liên hệ bộ phận kỹ thuật để được hỗ trợ"),
        "gender": MessageLookupByLibrary.simpleMessage("Giới tính"),
        "generating_code": MessageLookupByLibrary.simpleMessage("Đang tạo mã"),
        "getInfoProcessing":
            MessageLookupByLibrary.simpleMessage("Đang lấy thông tin"),
        "go_to_endow":
            MessageLookupByLibrary.simpleMessage("Chuyển đến mục Ưu đãi"),
        "go_to_the_endow_tab":
            MessageLookupByLibrary.simpleMessage("Chuyển đến tab Ưu đãi"),
        "got_it": MessageLookupByLibrary.simpleMessage("Đã hiểu"),
        "hai_su_pot_rice":
            MessageLookupByLibrary.simpleMessage("Cơm niêu Hải Sư"),
        "has_a_new_order_request":
            MessageLookupByLibrary.simpleMessage("có yêu cầu gọi món mới"),
        "has_been_transferred_to":
            MessageLookupByLibrary.simpleMessage("được chuyển thành"),
        "has_removed_table": MessageLookupByLibrary.simpleMessage("bỏ bàn"),
        "haven_t_chosen_a_table_to_manipulate":
            MessageLookupByLibrary.simpleMessage(
                "Chưa chọn đơn bàn để thao tác"),
        "help": MessageLookupByLibrary.simpleMessage("Trợ giúp"),
        "hours": MessageLookupByLibrary.simpleMessage("giờ"),
        "ignore_reservation_notification": MessageLookupByLibrary.simpleMessage(
            "Bỏ qua thông báo này và các thông báo nhắc nhở tương tự"),
        "image_error_delete":
            MessageLookupByLibrary.simpleMessage("Ảnh lỗi, hãy xoá bỏ!"),
        "inaccurateData":
            MessageLookupByLibrary.simpleMessage("Dữ liệu chưa chính xác"),
        "included_in_the_ordered_combo":
            MessageLookupByLibrary.simpleMessage("Thuộc combo đã gọi"),
        "infoConfig":
            MessageLookupByLibrary.simpleMessage("Thông tin cấu hình"),
        "infoDevice":
            MessageLookupByLibrary.simpleMessage("Thông tin thiết bị"),
        "infoVAT":
            MessageLookupByLibrary.simpleMessage("Giá chưa bao gồm thuế VAT"),
        "input": MessageLookupByLibrary.simpleMessage("Nhập"),
        "inputCode": MessageLookupByLibrary.simpleMessage("Nhập mã"),
        "invalid_date":
            MessageLookupByLibrary.simpleMessage("Ngày không hợp lệ"),
        "invalid_image_please_take_again": MessageLookupByLibrary.simpleMessage(
            "Hình ảnh không hợp lệ, vui lòng chọn lại"),
        "invalid_photo_select_again": MessageLookupByLibrary.simpleMessage(
            "Hình ảnh không hợp lệ, vui lòng chọn lại"),
        "invalid_restaurant_info": MessageLookupByLibrary.simpleMessage(
            "Thông tin nhà hàng không hợp lệ"),
        "invoice": MessageLookupByLibrary.simpleMessage("Hoá đơn"),
        "invoiceDetail":
            MessageLookupByLibrary.simpleMessage("Chi tiết hoá đơn"),
        "invoice_support":
            MessageLookupByLibrary.simpleMessage("hỗ trợ xuất hoá đơn"),
        "is_merged_with_table":
            MessageLookupByLibrary.simpleMessage("gộp thêm bàn"),
        "item": MessageLookupByLibrary.simpleMessage("Sản phẩm"),
        "just_done": MessageLookupByLibrary.simpleMessage("vừa xong"),
        "language": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
        "lastName": MessageLookupByLibrary.simpleMessage("Tên"),
        "last_login":
            MessageLookupByLibrary.simpleMessage("Đăng nhập gần nhất"),
        "latest": MessageLookupByLibrary.simpleMessage("Mới nhất"),
        "letsOrderFood": MessageLookupByLibrary.simpleMessage("Hãy Gọi Món"),
        "list_dish": MessageLookupByLibrary.simpleMessage("Danh sách món ăn"),
        "list_ordered_item_empty": MessageLookupByLibrary.simpleMessage(
            "Danh sách món đã gọi đang trống"),
        "list_request_o2o":
            MessageLookupByLibrary.simpleMessage("Danh sách yêu cầu"),
        "list_sales":
            MessageLookupByLibrary.simpleMessage("Danh sách nhân viên sale"),
        "list_sales_empty": MessageLookupByLibrary.simpleMessage(
            "Danh sách nhân viên sale đang trống"),
        "list_voucher":
            MessageLookupByLibrary.simpleMessage("Danh sách voucher"),
        "load_code_error": MessageLookupByLibrary.simpleMessage("Tải mã lỗi"),
        "loading_data":
            MessageLookupByLibrary.simpleMessage("Đang tải dữ liệu"),
        "loading_list":
            MessageLookupByLibrary.simpleMessage("Đang tải danh sách"),
        "loading_order_invoice":
            MessageLookupByLibrary.simpleMessage("Đang lấy thông tin hoá đơn"),
        "loading_payment_gateway_url": MessageLookupByLibrary.simpleMessage(
            "Đang tải URL cổng thanh toán"),
        "loading_payment_method": MessageLookupByLibrary.simpleMessage(
            "Đang tải phương thức thanh toán"),
        "loading_payment_method_list": MessageLookupByLibrary.simpleMessage(
            "Đang tải phương thức thanh toán..."),
        "loading_payment_qr_code":
            MessageLookupByLibrary.simpleMessage("Đang tải mã QR thanh toán"),
        "loading_pos_list": MessageLookupByLibrary.simpleMessage(
            "Đang lấy danh sách máy cà thẻ..."),
        "loading_printer_list":
            MessageLookupByLibrary.simpleMessage("Đang tải danh sách máy in"),
        "loading_qr_code":
            MessageLookupByLibrary.simpleMessage("Đang tải mã QR"),
        "loading_request_list":
            MessageLookupByLibrary.simpleMessage("Đang tải danh sách yêu cầu"),
        "loading_reservations": MessageLookupByLibrary.simpleMessage(
            "Đang tải danh sách bàn đặt..."),
        "locking_order_action":
            MessageLookupByLibrary.simpleMessage("Đang khóa thao tác đơn bàn"),
        "login": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "login_accounts_have_been_saved": MessageLookupByLibrary.simpleMessage(
            "Các tài khoản đăng nhập đã được lưu"),
        "login_unauthorized_message": MessageLookupByLibrary.simpleMessage(
            "Lỗi xác thực\nTài khoản hoặc mật khẩu không chính xác"),
        "logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
        "logoutConfirm": MessageLookupByLibrary.simpleMessage(
            "Xác nhận rằng bạn muốn đăng xuất?"),
        "longWang": MessageLookupByLibrary.simpleMessage("Long Wang"),
        "longWangSlogan": MessageLookupByLibrary.simpleMessage(
            "Lẩu hấp thuỷ nhiệt Hồng Kông"),
        "machine_type": MessageLookupByLibrary.simpleMessage("Loại máy"),
        "main_server": MessageLookupByLibrary.simpleMessage("Máy chủ chính"),
        "male": MessageLookupByLibrary.simpleMessage("Nam"),
        "manage_accounts_on_devices": MessageLookupByLibrary.simpleMessage(
            "Quản lý tài khoản trên thiết bị"),
        "mandatory_update": MessageLookupByLibrary.simpleMessage(
            "Phiên bản cập nhật bắt buộc, vui lòng cập nhật để tiếp tục sử dụng!"),
        "manipulate_with_the_current_table":
            MessageLookupByLibrary.simpleMessage(
                "Thao tác với đơn bàn hiện tại:"),
        "mark_all_as_read": MessageLookupByLibrary.simpleMessage(
            "Bạn có muốn đánh dấu tất cả là đã đọc?"),
        "messageAddCouponNoProducts": MessageLookupByLibrary.simpleMessage(
            "Không có sản phẩm đã gọi nào nằm trong danh sách được giảm giá"),
        "messageApplyDiscount": MessageLookupByLibrary.simpleMessage(
            "Áp dụng các chính sách và mã giảm giá đã chọn?"),
        "messageApplyDiscountResult": MessageLookupByLibrary.simpleMessage(
            "Áp dụng chính sách & mã giảm giá thành công!\nXem giá được giảm trong hoá đơn"),
        "messageCallWaiterPayment": MessageLookupByLibrary.simpleMessage(
            "Vui lòng gọi phục vụ để thực hiện thanh toán"),
        "messageCancelOrder": MessageLookupByLibrary.simpleMessage(
            "Sau khi huỷ sẽ không thể khôi phục lại được\nChỉ thực hiện khi tạo nhầm đơn hoặc khách huỷ đơn không dùng nữa"),
        "messageSelectTypeOrder": MessageLookupByLibrary.simpleMessage(
            "Có thể thay đổi hình thức hoạt động trong menu tuỳ chọn của nhà hàng."),
        "method": MessageLookupByLibrary.simpleMessage("Hình thức"),
        "minutes": MessageLookupByLibrary.simpleMessage("phút"),
        "miss_information":
            MessageLookupByLibrary.simpleMessage("Thiếu thông tin"),
        "money_return":
            MessageLookupByLibrary.simpleMessage("Tiền trả lại khách"),
        "months": MessageLookupByLibrary.simpleMessage("tháng"),
        "msg_add_item_success_print_failed": MessageLookupByLibrary.simpleMessage(
            "Món đã được thêm vào đơn.\n\nTuy nhiên, hệ thống chưa nhận được yêu cầu in.\nBạn có muốn gửi lệnh trực tiếp tới máy in không?"),
        "msg_auto_close_payment_gateway": MessageLookupByLibrary.simpleMessage(
            "Cổng thanh toán sẽ tự động đóng sau khi hệ thống nhận được tiền thanh toán"),
        "msg_cancel_item_success_print_failed":
            MessageLookupByLibrary.simpleMessage(
                "Đã huỷ món thành công!\n\nHệ thống chưa nhận được yêu cầu in.\nBạn có muốn gửi lệnh trực tiếp tới máy in không?"),
        "msg_check_other_devices_using_the_same_order":
            MessageLookupByLibrary.simpleMessage(
                "Vui lòng kiểm tra các thiết bị khác sử dụng cùng đơn bàn!"),
        "msg_close_payment_gateway_manually": MessageLookupByLibrary.simpleMessage(
            "Tự đóng cổng thanh toán, hãy đảm bảo về việc khách hàng đã thanh toán hay chưa?"),
        "msg_completing_order": MessageLookupByLibrary.simpleMessage(
            "Đang xử lý hoàn tất đơn bàn..."),
        "msg_coupons_invalid_with_payment_method": m3,
        "msg_delete_coupon_and_apply_again": m4,
        "msg_error_print_receipt": MessageLookupByLibrary.simpleMessage(
            "Không thể thực hiện việc in hóa đơn cho khách hàng."),
        "msg_id_device_to_unlock_order": MessageLookupByLibrary.simpleMessage(
            "Vui lòng xác định thiết bị đã mở phiếu thanh toán để có thể mở lại đơn bàn."),
        "msg_locked_order": MessageLookupByLibrary.simpleMessage(
            "Đơn bàn tạm khóa thao tác do đang mở phiếu thanh toán"),
        "msg_remind_apply_coupon_again": MessageLookupByLibrary.simpleMessage(
            "Nếu huỷ món, mã giảm giá sẽ bị huỷ theo.\nBạn cần nhập lại mã giảm giá để áp dụng cho món khác (nếu có)."),
        "msg_reprint_payment_receipt": MessageLookupByLibrary.simpleMessage(
            "Hóa đơn thanh toán đang được in lại..."),
        "msg_reprinting_kitchen_order": MessageLookupByLibrary.simpleMessage(
            "Đang xử lý việc in lại bill bếp..."),
        "msg_select_order_before_complete":
            MessageLookupByLibrary.simpleMessage(
                "Vui lòng chọn đơn bàn trước khi tiếp tục hoàn thành."),
        "msg_select_order_before_print_receipt":
            MessageLookupByLibrary.simpleMessage(
                "Vui lòng chọn đơn bàn trước khi in hóa đơn thanh toán"),
        "msg_send_ticket_success": MessageLookupByLibrary.simpleMessage(
            "Ticket của bạn đã được ghi nhận!\nXem và kiểm  tra trạng thái ở dưới Thu Ngân."),
        "msg_thanks_customer": m5,
        "msg_unable_retrieve_latest_order_data":
            MessageLookupByLibrary.simpleMessage(
                "Không thể truy xuất dữ liệu mới nhất của đơn"),
        "msg_unable_retrieve_payment_info":
            MessageLookupByLibrary.simpleMessage(
                "Không lấy được thông tin thanh toán của đơn bàn."),
        "name_of_dish_cut": MessageLookupByLibrary.simpleMessage("T.Món"),
        "networkConnect": MessageLookupByLibrary.simpleMessage("Mạng kết nối"),
        "new_order_request":
            MessageLookupByLibrary.simpleMessage("Có yêu cầu gọi món mới"),
        "new_version": MessageLookupByLibrary.simpleMessage(
            "Đã có phiên bản mới, hãy cập nhật ngay"),
        "new_version_available":
            MessageLookupByLibrary.simpleMessage("Có phiên bản mới"),
        "new_version_info":
            MessageLookupByLibrary.simpleMessage("Thông tin phiên bản mới"),
        "no": MessageLookupByLibrary.simpleMessage("Không"),
        "noBOD": MessageLookupByLibrary.simpleMessage("Chưa có ngày sinh"),
        "noInfo": MessageLookupByLibrary.simpleMessage("Không có thông tin"),
        "noOrderSelect":
            MessageLookupByLibrary.simpleMessage("Chưa chọn đơn bàn"),
        "noOrderYet":
            MessageLookupByLibrary.simpleMessage("Chưa có đơn bàn nào"),
        "noProducts":
            MessageLookupByLibrary.simpleMessage("Không có sản phẩm nào"),
        "noRequest":
            MessageLookupByLibrary.simpleMessage("Chưa có yêu cầu nào"),
        "no_attached_photos":
            MessageLookupByLibrary.simpleMessage("Không có ảnh đính kèm"),
        "no_bank_select": MessageLookupByLibrary.simpleMessage(
            "Chưa chọn ngân hàng thanh toán"),
        "no_card_machine_select":
            MessageLookupByLibrary.simpleMessage("Chưa chọn loại máy cà thẻ"),
        "no_conditions":
            MessageLookupByLibrary.simpleMessage("Không có điều kiện nào"),
        "no_data": MessageLookupByLibrary.simpleMessage("Không có dữ liệu"),
        "no_date_selected":
            MessageLookupByLibrary.simpleMessage("Chưa chọn ngày"),
        "no_dish_order":
            MessageLookupByLibrary.simpleMessage("Không có món nào đã gọi"),
        "no_identified_bod":
            MessageLookupByLibrary.simpleMessage("Không rõ ngày sinh"),
        "no_messages":
            MessageLookupByLibrary.simpleMessage("Không có tin nhắn nào"),
        "no_note": MessageLookupByLibrary.simpleMessage("Không có ghi chú"),
        "no_o2o_request": MessageLookupByLibrary.simpleMessage(
            "Không có yêu cầu gọi nhân viên/ thanh toán"),
        "no_orders": MessageLookupByLibrary.simpleMessage(
            "Hiện tại không có đơn bàn nào"),
        "no_orders_have_been_cancelled": MessageLookupByLibrary.simpleMessage(
            "Không có yêu cầu gọi món đã bị huỷ"),
        "no_orders_to_confirm": MessageLookupByLibrary.simpleMessage(
            "Hiện tại không có yêu cầu gọi món nào cần xác nhận!"),
        "no_pos_info": MessageLookupByLibrary.simpleMessage(
            "Không có thông tin máy cà thẻ"),
        "no_previously_confirmed_order_requests":
            MessageLookupByLibrary.simpleMessage(
                "Không có yêu cầu gọi món được xác nhận trước đó"),
        "no_printers":
            MessageLookupByLibrary.simpleMessage("Không có máy in nào"),
        "no_product":
            MessageLookupByLibrary.simpleMessage("Danh sách món hiện trống"),
        "no_qr_code": MessageLookupByLibrary.simpleMessage("Không có mã QR"),
        "no_reservations":
            MessageLookupByLibrary.simpleMessage("Không tìm thấy bàn đặt nào!"),
        "no_sale_selected":
            MessageLookupByLibrary.simpleMessage("Chưa chọn nhân viên sale"),
        "no_sale_staff_set_up": MessageLookupByLibrary.simpleMessage(
            "Chưa thiết lập nhân viên Sale"),
        "no_select_pos_machine": MessageLookupByLibrary.simpleMessage(
            "Chưa chọn máy POS để thanh toán."),
        "not": MessageLookupByLibrary.simpleMessage("Không"),
        "notAvailableYet": MessageLookupByLibrary.simpleMessage("Chưa có"),
        "notDiscountApply": MessageLookupByLibrary.simpleMessage(
            "Không có mã giảm giá được áp dụng"),
        "notTableSelected":
            MessageLookupByLibrary.simpleMessage("Không có bàn nào được chọn"),
        "notWaiterSelected": MessageLookupByLibrary.simpleMessage(
            "Không có phục vụ bàn nào được chọn"),
        "not_available_feature": MessageLookupByLibrary.simpleMessage(
            "Tính năng chỉ khả dụng trên Tab Order"),
        "not_available_online":
            MessageLookupByLibrary.simpleMessage("KHÔNG bán online"),
        "not_be_empty":
            MessageLookupByLibrary.simpleMessage("Không được bỏ trống"),
        "not_correct_format":
            MessageLookupByLibrary.simpleMessage("Chưa đúng định dạng"),
        "not_sale_select_before_complete_order":
            MessageLookupByLibrary.simpleMessage(
                "Vui lòng chọn nhân viên sale trước khi bấm hoàn thành đơn."),
        "not_select": MessageLookupByLibrary.simpleMessage("Chưa chọn"),
        "not_set_up":
            MessageLookupByLibrary.simpleMessage("chưa được thiết lập"),
        "not_used_promotion": MessageLookupByLibrary.simpleMessage(
            "không được sử dụng chương trình khuyến mãi"),
        "note": MessageLookupByLibrary.simpleMessage("Ghi chú"),
        "note_after_rating": MessageLookupByLibrary.simpleMessage(
            "Chú ý: Khi bạn chọn Tạo phiếu thanh toán sẽ không quay lại được!"),
        "note_show_qr_register_zalo_oa": MessageLookupByLibrary.simpleMessage(
            "Lưu ý: Khi Đóng thì mã QR trên màn hình khách hàng cũng sẽ đóng lại"),
        "note_the_dish": MessageLookupByLibrary.simpleMessage("Ghi chú TN"),
        "note_update_process_note_work": MessageLookupByLibrary.simpleMessage(
            "Nếu quá trình cập nhật không hoạt động, vui lòng sử dụng Google Chrome để tải và cài đặt tại website"),
        "notes": MessageLookupByLibrary.simpleMessage("Ghi chú"),
        "noti_delete_code_and_choose_payment_method_again":
            MessageLookupByLibrary.simpleMessage(
                "Vui lòng thực hiện xoá mã, rồi chọn lại phương thức thanh toán!"),
        "noti_enter_customer_info": MessageLookupByLibrary.simpleMessage(
            "Thông tin khách hàng chưa được điền. Bạn có muốn tiếp tục thanh toán?"),
        "noti_has_reservation": m6,
        "noticeRequestCancel": MessageLookupByLibrary.simpleMessage(
            "Có yêu cầu huỷ chưa được xử lý, vui lòng đợi và tải lại danh sách để kiểm tra!"),
        "notification": MessageLookupByLibrary.simpleMessage("Thông báo"),
        "number_of_adults":
            MessageLookupByLibrary.simpleMessage("SL người lớn"),
        "number_of_children": MessageLookupByLibrary.simpleMessage("SL trẻ em"),
        "number_of_guest": MessageLookupByLibrary.simpleMessage("Số khách"),
        "number_of_people":
            MessageLookupByLibrary.simpleMessage("Số lượng người"),
        "oldest": MessageLookupByLibrary.simpleMessage("Cũ nhất"),
        "only_available_on_the_Order_Tab": MessageLookupByLibrary.simpleMessage(
            "Tính năng chỉ khả dụng trên Tab Order"),
        "opening_installer": MessageLookupByLibrary.simpleMessage(
            "Đang mở trình cài đặt, vui lòng đợi"),
        "opening_payment_gateway": MessageLookupByLibrary.simpleMessage(
            "Đang mở cổng thanh toán, vui lòng chờ..."),
        "order": MessageLookupByLibrary.simpleMessage("Đơn bàn"),
        "orderConfirm":
            MessageLookupByLibrary.simpleMessage("Xác nhận gọi món?"),
        "orderNotExist":
            MessageLookupByLibrary.simpleMessage("Đơn hàng không tồn tại"),
        "orderOffline": MessageLookupByLibrary.simpleMessage("Tại nhà hàng"),
        "orderOnline": MessageLookupByLibrary.simpleMessage("Mang về"),
        "orderSellType":
            MessageLookupByLibrary.simpleMessage("Hình thức hoạt động"),
        "orderSellTypeInfo": MessageLookupByLibrary.simpleMessage(
            "Nhấn để chuyển đổi hình thức hoạt động"),
        "order_before_payment": MessageLookupByLibrary.simpleMessage(
            "Hãy gọi món trước khi tiến hành thanh toán"),
        "order_code": MessageLookupByLibrary.simpleMessage("Mã đơn"),
        "order_detail":
            MessageLookupByLibrary.simpleMessage("Chi tiết đơn bàn"),
        "order_history":
            MessageLookupByLibrary.simpleMessage("Lịch sử gọi - huỷ"),
        "order_info": MessageLookupByLibrary.simpleMessage("Thông tin đơn bàn"),
        "order_not_found":
            MessageLookupByLibrary.simpleMessage("Không tìm thấy đơn bàn"),
        "order_of_the_day":
            MessageLookupByLibrary.simpleMessage("Đơn bàn trong ngày"),
        "order_to_online":
            MessageLookupByLibrary.simpleMessage("Yêu cầu tại bàn"),
        "ordered_item_empty": MessageLookupByLibrary.simpleMessage(
            "Danh sách món đã gọi đang trống"),
        "orders_are_being_delivered":
            MessageLookupByLibrary.simpleMessage("Đang chuyển giao đơn bàn"),
        "other": MessageLookupByLibrary.simpleMessage("Khác"),
        "out_of_dish": MessageLookupByLibrary.simpleMessage("Hết món"),
        "out_of_stock": MessageLookupByLibrary.simpleMessage("Hết món"),
        "paid_order": MessageLookupByLibrary.simpleMessage(
            "Đơn bàn đã được khách hàng thanh toán!"),
        "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "pay_bills": MessageLookupByLibrary.simpleMessage("Thanh toán hoá đơn"),
        "payment": MessageLookupByLibrary.simpleMessage("Thanh toán"),
        "paymentNow": MessageLookupByLibrary.simpleMessage("Thanh toán ngay"),
        "payment_amount":
            MessageLookupByLibrary.simpleMessage("Số tiền thanh toán"),
        "payment_available_after_apply_discount_success":
            MessageLookupByLibrary.simpleMessage(
                "Thanh toán chỉ khả dụng sau khi ưu đãi được áp dụng thành công"),
        "payment_confirmation":
            MessageLookupByLibrary.simpleMessage("Xác nhận thanh toán"),
        "payment_done_but_not_complete_order": MessageLookupByLibrary.simpleMessage(
            "Khách hàng đã thanh toán thành công nhưng không thể hoàn thành bill"),
        "payment_gateway":
            MessageLookupByLibrary.simpleMessage("Cổng thanh toán"),
        "payment_info":
            MessageLookupByLibrary.simpleMessage("Thông tin thanh toán"),
        "payment_method":
            MessageLookupByLibrary.simpleMessage("Phương thức thanh toán"),
        "payment_method_does_not_apply": MessageLookupByLibrary.simpleMessage(
            "Không được áp dụng với phương thức thanh toán"),
        "payment_method_is_empty": MessageLookupByLibrary.simpleMessage(
            "Không có phương thức thanh toán nào"),
        "payment_method_not_select": MessageLookupByLibrary.simpleMessage(
            "Chưa chọn phương thức thanh toán"),
        "payment_method_open_gateway": MessageLookupByLibrary.simpleMessage(
            "Phương thức được chọn sẽ mở cổng thanh toán"),
        "payment_notes":
            MessageLookupByLibrary.simpleMessage("Ghi chú thanh toán"),
        "payment_received":
            MessageLookupByLibrary.simpleMessage("Khách thanh toán"),
        "payment_success":
            MessageLookupByLibrary.simpleMessage("Thanh toán thành công!"),
        "payment_successful":
            MessageLookupByLibrary.simpleMessage("Thanh toán thành công!"),
        "pending_order_requried_complete_order":
            MessageLookupByLibrary.simpleMessage(
                "Đơn hàng đang ở trạng thái tạm tính. Vui lòng hoàn tất đơn để tiếp tục."),
        "pending_reser": MessageLookupByLibrary.simpleMessage("Chờ phê duyệt"),
        "personal": MessageLookupByLibrary.simpleMessage("Cá nhân"),
        "phone": MessageLookupByLibrary.simpleMessage("Số điện thoại"),
        "phone_invalid":
            MessageLookupByLibrary.simpleMessage("Số điện thoại không hợp lệ"),
        "please": MessageLookupByLibrary.simpleMessage("Vui lòng"),
        "pleaseSelectOrderFirst": MessageLookupByLibrary.simpleMessage(
            "Vui lòng chọn đơn bàn trước!"),
        "please_enter_info":
            MessageLookupByLibrary.simpleMessage("Vui lòng nhập thông tin"),
        "please_select_a_sale": MessageLookupByLibrary.simpleMessage(
            "Vui lòng lựa chọn nhân viên sale trước khi thực hiện bước tiếp theo."),
        "please_select_printer_to_check": MessageLookupByLibrary.simpleMessage(
            "Vui lòng chọn máy in cần kiểm tra"),
        "please_select_reason_cancel_item":
            MessageLookupByLibrary.simpleMessage(
                "Vui lòng chọn lí do hủy món!"),
        "please_try_again":
            MessageLookupByLibrary.simpleMessage("Vui lòng thử lại"),
        "point": MessageLookupByLibrary.simpleMessage("Điểm"),
        "pointToMoney": MessageLookupByLibrary.simpleMessage("Ứng với số tiền"),
        "price": MessageLookupByLibrary.simpleMessage("Giá"),
        "price_of_dish_cut": MessageLookupByLibrary.simpleMessage("Đ.Giá"),
        "print": MessageLookupByLibrary.simpleMessage("In"),
        "print_QR": MessageLookupByLibrary.simpleMessage("In QR"),
        "print_QR_code_o2o_success": MessageLookupByLibrary.simpleMessage(
            "In mã QR gọi món tại bàn thành công"),
        "print_bill": MessageLookupByLibrary.simpleMessage("In bill"),
        "print_bill_success":
            MessageLookupByLibrary.simpleMessage("In bill thành công"),
        "print_directly": MessageLookupByLibrary.simpleMessage("In trực tiếp"),
        "print_failed":
            MessageLookupByLibrary.simpleMessage("In phiếu thất bại!"),
        "print_now": MessageLookupByLibrary.simpleMessage("In ngay"),
        "print_number_of_people": MessageLookupByLibrary.simpleMessage(
            "Có in số người khi hoàn thành đơn?"),
        "print_setting": MessageLookupByLibrary.simpleMessage("Cài đặt in"),
        "printer_list":
            MessageLookupByLibrary.simpleMessage("Danh sách máy in"),
        "printer_list_empty":
            MessageLookupByLibrary.simpleMessage("Danh sách máy in trống"),
        "printer_not_config":
            MessageLookupByLibrary.simpleMessage("Máy in chưa được thiếp lập"),
        "printer_not_connect": MessageLookupByLibrary.simpleMessage(
            "Không kết nối được máy in\nVui lòng kiểm tra lại!"),
        "printer_options":
            MessageLookupByLibrary.simpleMessage("Tuỳ chọn máy in"),
        "printer_work_stably":
            MessageLookupByLibrary.simpleMessage("Máy in hoạt động ổn định"),
        "printing_QR_code":
            MessageLookupByLibrary.simpleMessage("Đang in mã QR"),
        "problem": MessageLookupByLibrary.simpleMessage("Vấn đề"),
        "processOrder": MessageLookupByLibrary.simpleMessage("Gọi món"),
        "processOrderSuccess":
            MessageLookupByLibrary.simpleMessage("Gọi món thành công!"),
        "process_order_and_not_print": MessageLookupByLibrary.simpleMessage(
            "Bạn có muốn gọi món mà không in bill xuống bếp, bar?"),
        "processing": MessageLookupByLibrary.simpleMessage("Đang xử lý"),
        "processing_payment":
            MessageLookupByLibrary.simpleMessage("Đang thanh toán"),
        "processing_reser":
            MessageLookupByLibrary.simpleMessage("Khách đang sử dụng dịch vụ"),
        "product": MessageLookupByLibrary.simpleMessage("Sản phẩm"),
        "qr_code_loading_error":
            MessageLookupByLibrary.simpleMessage("Lỗi tải QR Code"),
        "qr_order_to_online":
            MessageLookupByLibrary.simpleMessage("Mã QR gọi món tại bàn"),
        "qr_reg_zalo_oa":
            MessageLookupByLibrary.simpleMessage("QR đăng ký KH Zalo-OA"),
        "quantity": MessageLookupByLibrary.simpleMessage("Số lượng"),
        "quantityCut": MessageLookupByLibrary.simpleMessage("SL"),
        "quantity_not_selected_yet":
            MessageLookupByLibrary.simpleMessage("Chưa chọn số lượng"),
        "rank": MessageLookupByLibrary.simpleMessage("Hạng"),
        "reasonForCancellation":
            MessageLookupByLibrary.simpleMessage("Lý do huỷ món"),
        "recall": MessageLookupByLibrary.simpleMessage("Thu hồi"),
        "reconnect": MessageLookupByLibrary.simpleMessage("Kết nối lại"),
        "reduce": MessageLookupByLibrary.simpleMessage("Giảm"),
        "reenter_coupon": MessageLookupByLibrary.simpleMessage("Nhập lại mã"),
        "register_customers_via_zalo_oa": MessageLookupByLibrary.simpleMessage(
            "Đăng ký khách hàng qua Zalo-OA"),
        "rejected_reser": MessageLookupByLibrary.simpleMessage("Từ chối"),
        "release_date": MessageLookupByLibrary.simpleMessage("Ngày phát hành"),
        "reload": MessageLookupByLibrary.simpleMessage("Tải lại"),
        "reload_list":
            MessageLookupByLibrary.simpleMessage("Tải lại danh sách"),
        "reload_printer_list":
            MessageLookupByLibrary.simpleMessage("Tải lại danh sách máy in"),
        "remaining_time":
            MessageLookupByLibrary.simpleMessage("Thời gian còn lại"),
        "removeCustomer": MessageLookupByLibrary.simpleMessage(
            "Xoá bỏ khách hàng trong hoá đơn?"),
        "remove_coupon_and_reenter":
            MessageLookupByLibrary.simpleMessage("Xóa mã và nhập lại mã"),
        "remove_coupon_or_select_other_payment_method":
            MessageLookupByLibrary.simpleMessage(
                "Vui lòng xoá mã giảm giá để sử dụng phương thức đã chọn hoặc quay lại chọn phương thức thanh toán khác"),
        "removing_customer":
            MessageLookupByLibrary.simpleMessage("Đang xóa khách hàng"),
        "requestHistory":
            MessageLookupByLibrary.simpleMessage("Lịch sử yêu cầu"),
        "request_is_being_revoked":
            MessageLookupByLibrary.simpleMessage("Đang thu hồi yêu cầu"),
        "request_payment":
            MessageLookupByLibrary.simpleMessage("Gọi thanh toán"),
        "request_payment_1":
            MessageLookupByLibrary.simpleMessage("Gọi thanh toán"),
        "request_service":
            MessageLookupByLibrary.simpleMessage("Yêu cầu phục vụ"),
        "require_enter_info": MessageLookupByLibrary.simpleMessage(
            "Vui lòng nhập đủ thông tin bắt buộc"),
        "reselect_payment_method": MessageLookupByLibrary.simpleMessage(
            "Chọn lại phương thức thanh toán"),
        "reservation": MessageLookupByLibrary.simpleMessage("Lịch đặt bàn"),
        "reservation_assigned_order": MessageLookupByLibrary.simpleMessage(
            "Lịch đang được gán với đơn bàn hiện tại"),
        "restaurant": MessageLookupByLibrary.simpleMessage("Nhà hàng"),
        "restaurantEmpty":
            MessageLookupByLibrary.simpleMessage("Không có nhà hàng nào"),
        "restaurant_slogan": MessageLookupByLibrary.simpleMessage(
            "Chuỗi nhà hàng thuộc Aladdin.,JSC"),
        "restore": MessageLookupByLibrary.simpleMessage("Khôi phục lại"),
        "retrieving_printer_list":
            MessageLookupByLibrary.simpleMessage("Đang lấy danh sách máy in"),
        "review_is_empty":
            MessageLookupByLibrary.simpleMessage("Đánh giá đang trống"),
        "revoke_the_order_cancellation_request":
            MessageLookupByLibrary.simpleMessage("Thu hồi yêu cầu huỷ món"),
        "sale_staff": MessageLookupByLibrary.simpleMessage("Nhân viên sale"),
        "save": MessageLookupByLibrary.simpleMessage("Lưu"),
        "saveSuccess": MessageLookupByLibrary.simpleMessage("Đã lưu!"),
        "save_and_continue_payment":
            MessageLookupByLibrary.simpleMessage("Lưu và tiếp tục thanh toán"),
        "saving_config":
            MessageLookupByLibrary.simpleMessage("Đang lưu cấu hình"),
        "scan_code_zalo":
            MessageLookupByLibrary.simpleMessage("Quét mã (KH Zalo)"),
        "scan_info_from_id":
            MessageLookupByLibrary.simpleMessage("Quét thông tin từ CCCD"),
        "scan_qr_code":
            MessageLookupByLibrary.simpleMessage("Quét mã (QR Code)"),
        "scrollToEnd":
            MessageLookupByLibrary.simpleMessage("Đã tới cuối trang"),
        "search": MessageLookupByLibrary.simpleMessage("Tìm kiếm"),
        "searchDish": MessageLookupByLibrary.simpleMessage("Tìm kiếm món ăn"),
        "search_by_name":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm theo tên"),
        "search_by_phone_number":
            MessageLookupByLibrary.simpleMessage("Tìm theo SĐT"),
        "search_order_history": MessageLookupByLibrary.simpleMessage(
            "Tìm theo mã đơn, tên khách hàng, số điện thoại, hoặc mã giảm giá..."),
        "search_reservation":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm lịch đặt bàn"),
        "search_restaurant":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm nhà hàng"),
        "search_waiter":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm phục vụ viên"),
        "selectOrder": MessageLookupByLibrary.simpleMessage("Chọn đơn bàn"),
        "selectTable": MessageLookupByLibrary.simpleMessage("Chọn bàn"),
        "select_a_bank": MessageLookupByLibrary.simpleMessage("Chọn ngân hàng"),
        "select_a_payment_method":
            MessageLookupByLibrary.simpleMessage("Chọn phương thức thanh toán"),
        "select_all": MessageLookupByLibrary.simpleMessage("Chọn tất cả"),
        "select_another_printer":
            MessageLookupByLibrary.simpleMessage("Chọn máy in khác"),
        "select_completion_date":
            MessageLookupByLibrary.simpleMessage("Chọn ngày hoàn tất"),
        "select_dish_cancel":
            MessageLookupByLibrary.simpleMessage("Chọn món muốn huỷ"),
        "select_photo_from_galley":
            MessageLookupByLibrary.simpleMessage("Chọn ảnh trong máy"),
        "select_pos_to_continue": MessageLookupByLibrary.simpleMessage(
            "Vui lòng chọn máy cà thẻ để tiếp tục"),
        "select_restaurant":
            MessageLookupByLibrary.simpleMessage("Chọn nhà hàng"),
        "select_sales_staff":
            MessageLookupByLibrary.simpleMessage("Chọn nhân viên sale"),
        "select_table_to_transfer":
            MessageLookupByLibrary.simpleMessage("Chọn bàn cần chuyển"),
        "select_up_to": MessageLookupByLibrary.simpleMessage("Chọn tối đa"),
        "selected": MessageLookupByLibrary.simpleMessage("Đã chọn"),
        "selectedDish": MessageLookupByLibrary.simpleMessage("Món đã gọi"),
        "selected_dish": MessageLookupByLibrary.simpleMessage("Đã gọi"),
        "selectingDish": MessageLookupByLibrary.simpleMessage("Món đang chọn"),
        "selecting_dish": MessageLookupByLibrary.simpleMessage("Đang chọn"),
        "send_cmd_print_directly": MessageLookupByLibrary.simpleMessage(
            "Gửi lệnh trực tiếp tới máy in"),
        "send_ticket": MessageLookupByLibrary.simpleMessage("Gửi ticket"),
        "send_to_the_kitchen": MessageLookupByLibrary.simpleMessage("Gửi bếp"),
        "sending_bill_kitchen":
            MessageLookupByLibrary.simpleMessage("Đang gửi bill xuống bếp..."),
        "sending_command_pos": MessageLookupByLibrary.simpleMessage(
            "Đang gửi lệnh tới máy cà thẻ...."),
        "sending_request_to_cancel_order":
            MessageLookupByLibrary.simpleMessage("Đang gửi yêu cầu huỷ món"),
        "sending_ticket":
            MessageLookupByLibrary.simpleMessage("Đang gửi ticket..."),
        "sending_ticket_failed":
            MessageLookupByLibrary.simpleMessage("Gửi ticket thất bại"),
        "separate_bill": MessageLookupByLibrary.simpleMessage("Bill lẻ"),
        "server": MessageLookupByLibrary.simpleMessage("Máy chủ"),
        "server_status":
            MessageLookupByLibrary.simpleMessage("Trạng thái máy chủ"),
        "set_default_printer":
            MessageLookupByLibrary.simpleMessage("Thiết lập máy in chính"),
        "settings_saved":
            MessageLookupByLibrary.simpleMessage("Thiết lập đã được lưu!"),
        "shift_closing": MessageLookupByLibrary.simpleMessage("Chốt ca"),
        "skip_review": MessageLookupByLibrary.simpleMessage("Bỏ qua đánh giá"),
        "skip_review_confirm": MessageLookupByLibrary.simpleMessage(
            "Bạn có chắc muốn bỏ qua đánh giá?"),
        "software": MessageLookupByLibrary.simpleMessage("Phần mềm"),
        "software_update":
            MessageLookupByLibrary.simpleMessage("Cập nhật phần mềm"),
        "status": MessageLookupByLibrary.simpleMessage("Trạng thái"),
        "submit_a_review":
            MessageLookupByLibrary.simpleMessage("Gửi phiếu đánh giá"),
        "submit_error_ticket":
            MessageLookupByLibrary.simpleMessage("Gửi ticket báo lỗi"),
        "submit_support_request":
            MessageLookupByLibrary.simpleMessage("Gửi yêu cầu hỗ trợ"),
        "submitting_your_review":
            MessageLookupByLibrary.simpleMessage("Đang gửi đánh giá của bạn"),
        "success": MessageLookupByLibrary.simpleMessage("Thành công!"),
        "sure_connected_network": MessageLookupByLibrary.simpleMessage(
            "Hãy đảm bảo thiết bị đã được kết nối mạng"),
        "switched_accounts":
            MessageLookupByLibrary.simpleMessage("Đã chuyển sang tài khoản"),
        "switching_accounts":
            MessageLookupByLibrary.simpleMessage("Đang chuyển đổi tài khoản"),
        "system_closing_shift": MessageLookupByLibrary.simpleMessage(
            "Hệ thống đang thực hiện chốt ca..."),
        "table": MessageLookupByLibrary.simpleMessage("Bàn"),
        "tableOff": MessageLookupByLibrary.simpleMessage("Hết bàn"),
        "table_order_history":
            MessageLookupByLibrary.simpleMessage("Lịch sử đơn bàn"),
        "table_served":
            MessageLookupByLibrary.simpleMessage("Bàn đang phục vụ"),
        "table_waiting_for_payment":
            MessageLookupByLibrary.simpleMessage("Bàn đang chờ thanh toán"),
        "take_photo_use_camera":
            MessageLookupByLibrary.simpleMessage("Chụp ảnh Camera"),
        "tap_to_try_again":
            MessageLookupByLibrary.simpleMessage("Nhấn để thử lại"),
        "tax": MessageLookupByLibrary.simpleMessage("Thuế"),
        "tax_code": MessageLookupByLibrary.simpleMessage("Mã số thuế"),
        "tax_money": MessageLookupByLibrary.simpleMessage("Tiền thuế"),
        "tax_of_dish_cut": MessageLookupByLibrary.simpleMessage("T.Suất"),
        "temporarily_locked_order": MessageLookupByLibrary.simpleMessage(
            "Đơn bàn tạm khoá thao tác, do đang mở phiếu thanh toán."),
        "thank_for_rating":
            MessageLookupByLibrary.simpleMessage("Cảm ơn bạn đã đánh giá!"),
        "there_are_no_accounts":
            MessageLookupByLibrary.simpleMessage("Không có tài khoản nào"),
        "tianLong": MessageLookupByLibrary.simpleMessage("Tian Long"),
        "tianLongSlogan":
            MessageLookupByLibrary.simpleMessage("Lẩu bò tươi Triều Châu"),
        "ticket_submission_history":
            MessageLookupByLibrary.simpleMessage("Lịch sử gửi ticket"),
        "tiengAnh": MessageLookupByLibrary.simpleMessage("Tiếng Anh"),
        "tiengViet": MessageLookupByLibrary.simpleMessage("Tiếng Việt"),
        "time": MessageLookupByLibrary.simpleMessage("Thời gian"),
        "time_before": MessageLookupByLibrary.simpleMessage("trước"),
        "total": MessageLookupByLibrary.simpleMessage("Tổng"),
        "totalAmountPayment":
            MessageLookupByLibrary.simpleMessage("Tổng tiền thanh toán"),
        "totalAmountSelected":
            MessageLookupByLibrary.simpleMessage("Tổng tiền đã gọi"),
        "totalAmountSelecting":
            MessageLookupByLibrary.simpleMessage("Tổng tiền món đang chọn"),
        "totalAmoutOrder": MessageLookupByLibrary.simpleMessage("Tổng hoá đơn"),
        "total_amount": MessageLookupByLibrary.simpleMessage("Thành tiền"),
        "total_amount_after_cancel":
            MessageLookupByLibrary.simpleMessage("Tổng tiền sau huỷ"),
        "total_amount_dish_selected":
            MessageLookupByLibrary.simpleMessage("Tổng tiền món đã gọi"),
        "total_bill": MessageLookupByLibrary.simpleMessage("Bill tổng"),
        "total_note": MessageLookupByLibrary.simpleMessage("Ghi chú tổng"),
        "total_price_of_dish_cut":
            MessageLookupByLibrary.simpleMessage("T.Tiền"),
        "transferOrder": MessageLookupByLibrary.simpleMessage("Chuyển đơn"),
        "transferOrderCurrent":
            MessageLookupByLibrary.simpleMessage("Chuyển giao đơn bàn"),
        "transferOrderSuccess": MessageLookupByLibrary.simpleMessage(
            "Chuyển giao đơn bàn thành công!"),
        "transferSuccess":
            MessageLookupByLibrary.simpleMessage("Chuyển giao thành công!"),
        "transferUpdateOrder":
            MessageLookupByLibrary.simpleMessage("Chuyển giao đơn bàn"),
        "transfer_content":
            MessageLookupByLibrary.simpleMessage("Nội dung chuyển khoản"),
        "tryAgain": MessageLookupByLibrary.simpleMessage("Thử lại"),
        "try_printing_again":
            MessageLookupByLibrary.simpleMessage("Thử in lại"),
        "turn": MessageLookupByLibrary.simpleMessage("Lượt"),
        "unable_add_customer": MessageLookupByLibrary.simpleMessage(
            "Không thể thêm khách hàng vào hệ thống."),
        "unable_connect_printer":
            MessageLookupByLibrary.simpleMessage("Không kết nối được máy in"),
        "unable_load_order_list": MessageLookupByLibrary.simpleMessage(
            "Không tải được danh sách đơn bàn"),
        "unable_load_printer_list": MessageLookupByLibrary.simpleMessage(
            "Không thể tải danh sách máy in"),
        "unable_load_sales_list": MessageLookupByLibrary.simpleMessage(
            "Không thể tải danh sách nhân viên sale"),
        "unable_open_installer_please_download_browser":
            MessageLookupByLibrary.simpleMessage(
                "Không thể mở trình cài đặt, vui lòng tải về và cài đặt bằng trình duyệt"),
        "unable_open_link":
            MessageLookupByLibrary.simpleMessage("Không thể mở liên kết"),
        "unable_send_bill_kitchen": MessageLookupByLibrary.simpleMessage(
            "Không thể gửi bill xuống bếp."),
        "unable_to_load_chat_content": MessageLookupByLibrary.simpleMessage(
            "Không thể tải nội dung đoạn chat"),
        "unit_price_shortcut": MessageLookupByLibrary.simpleMessage("Đ.Giá"),
        "unknown": MessageLookupByLibrary.simpleMessage("Không xác định"),
        "unlock": MessageLookupByLibrary.simpleMessage("Mở lại"),
        "unlocking_order":
            MessageLookupByLibrary.simpleMessage("Đang mở khóa đơn bàn"),
        "unpaid_order_select_payment_method_again":
            MessageLookupByLibrary.simpleMessage(
                "Đơn bàn chưa thanh toán, vui lòng chọn lại Phương thức thanh toán và tiếp tục!"),
        "unselect": MessageLookupByLibrary.simpleMessage("Bỏ chọn"),
        "unvailable_link_registration_zalo_oa":
            MessageLookupByLibrary.simpleMessage(
                "Link đăng ký hiện không khả dụng"),
        "update": MessageLookupByLibrary.simpleMessage("Cập nhật"),
        "updateAndChoseTable":
            MessageLookupByLibrary.simpleMessage("Cập nhật - Chọn bàn"),
        "updateData": MessageLookupByLibrary.simpleMessage("Cập nhật dữ liệu"),
        "updateDataInfo": MessageLookupByLibrary.simpleMessage(
            "Các dữ liệu về thể loại, món ăn, đơn hàng,..."),
        "updateOrderCurrent":
            MessageLookupByLibrary.simpleMessage("Cập nhật đơn bàn"),
        "updateSuccess":
            MessageLookupByLibrary.simpleMessage("Cập nhật thành công!"),
        "update_app": MessageLookupByLibrary.simpleMessage("Cập nhật ứng dụng"),
        "update_app_failed_try_again": MessageLookupByLibrary.simpleMessage(
            "Cập nhật lỗi, vui lòng thử lại"),
        "update_invoice_information":
            MessageLookupByLibrary.simpleMessage("Cập nhật thông tin hoá đơn"),
        "update_now": MessageLookupByLibrary.simpleMessage("Cập nhật ngay"),
        "update_reservation":
            MessageLookupByLibrary.simpleMessage("Cập nhật lịch đặt bàn"),
        "updated_success":
            MessageLookupByLibrary.simpleMessage("Đã được cập nhật"),
        "updating": MessageLookupByLibrary.simpleMessage("Đang cập nhật"),
        "updating_order":
            MessageLookupByLibrary.simpleMessage("Đang cập nhật đơn bàn"),
        "updating_order_panel": MessageLookupByLibrary.simpleMessage(
            "Đang cập nhật đơn bàn thao tác"),
        "updating_order_reser": MessageLookupByLibrary.simpleMessage(
            "Đang thay đổi lịch đặt bàn của đơn"),
        "updating_payment_info": MessageLookupByLibrary.simpleMessage(
            "Đang cập nhật thông tin thanh toán"),
        "updating_reservation_info":
            MessageLookupByLibrary.simpleMessage("Đang cập nhật lịch đặt bàn"),
        "updating_tax":
            MessageLookupByLibrary.simpleMessage("Đang cập nhật lại thuế..."),
        "use": MessageLookupByLibrary.simpleMessage("Sử dụng"),
        "use_camera_zalo_to_scan_the_code":
            MessageLookupByLibrary.simpleMessage(
                "Sử dụng Máy ảnh/Zalo để quét mã"),
        "use_default_printer": MessageLookupByLibrary.simpleMessage(
            "Sử dụng máy in mặc định theo món"),
        "username":
            MessageLookupByLibrary.simpleMessage("Email hoặc tên người dùng"),
        "using_lastest_version": MessageLookupByLibrary.simpleMessage(
            "Thiết bị đang sử dụng phiên bản mới nhất"),
        "using_other_payment_method_if_failed":
            MessageLookupByLibrary.simpleMessage(
                "Nếu không thể kết nối, vui lòng sử dụng hình thức thanh toán khác!"),
        "value_invalid":
            MessageLookupByLibrary.simpleMessage("Giá trị không hợp lệ"),
        "verification": MessageLookupByLibrary.simpleMessage("Xác minh"),
        "verificationCodeIsIncorrect":
            MessageLookupByLibrary.simpleMessage("Mã xác thực không chính xác"),
        "verificationCodes":
            MessageLookupByLibrary.simpleMessage("Mã xác thực"),
        "verifying": MessageLookupByLibrary.simpleMessage("Đang xác thực"),
        "version": MessageLookupByLibrary.simpleMessage("Phiên bản"),
        "version_code": MessageLookupByLibrary.simpleMessage("Mã phiên bản"),
        "version_on_device":
            MessageLookupByLibrary.simpleMessage("Phiên bản trên thiết bị"),
        "via_pos_machine": MessageLookupByLibrary.simpleMessage("qua máy POS"),
        "view_and_update":
            MessageLookupByLibrary.simpleMessage("Xem & cập nhật"),
        "view_detail_item_print_failed": MessageLookupByLibrary.simpleMessage(
            "Xem chi tiết món in không thành công"),
        "view_order_and_cancel_history":
            MessageLookupByLibrary.simpleMessage("Xem lịch sử gọi - huỷ món"),
        "view_order_qr":
            MessageLookupByLibrary.simpleMessage("Xem mã QR order"),
        "voucher": MessageLookupByLibrary.simpleMessage("Mã giảm"),
        "voucher_discount":
            MessageLookupByLibrary.simpleMessage("Voucher giảm giá"),
        "wait_a_moment_and_try_again": MessageLookupByLibrary.simpleMessage(
            "Xin chờ một chút rồi thử lại."),
        "wait_for_handling": MessageLookupByLibrary.simpleMessage("Chờ xử lý"),
        "wait_updating_complete": MessageLookupByLibrary.simpleMessage(
            "Vui lòng chờ cho tới khi quá trình cập nhật kết thúc"),
        "waiter": MessageLookupByLibrary.simpleMessage("Phục vụ"),
        "waiter_service":
            MessageLookupByLibrary.simpleMessage("Phục vụ tiếp nhận"),
        "waiting_payment":
            MessageLookupByLibrary.simpleMessage("Chờ thanh toán"),
        "warning_delete_item_with_complimentary_gift":
            MessageLookupByLibrary.simpleMessage(
                "Có mã tặng không thu tiền áp dụng với món này.\nNếu hủy, vui lòng chọn lại món mà mã sẽ áp dụng trong mục Ưu đãi"),
        "webview_permission_request": MessageLookupByLibrary.simpleMessage(
            "Yêu cầu quyền truy cập Webview"),
        "webview_permission_request_1":
            MessageLookupByLibrary.simpleMessage("WebView yêu cầu quyền"),
        "years": MessageLookupByLibrary.simpleMessage("năm"),
        "yes": MessageLookupByLibrary.simpleMessage("Có")
      };
}
