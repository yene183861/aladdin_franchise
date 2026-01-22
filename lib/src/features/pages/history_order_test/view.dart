import 'package:aladdin_franchise/src/models/order.dart';
import 'package:flutter/material.dart';

class HistoryOrderPage extends StatelessWidget {
  const HistoryOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OrderResponsiveView(
        orders: [
          OrderModel(id: 1),
        ],
      ),
    );
  }
}

class OrderResponsiveView extends StatelessWidget {
  final List<OrderModel> orders;

  const OrderResponsiveView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 900) {
      return OrderTableView(orders: orders);
    }

    return OrderCardListView(orders: orders);
  }
}

class OrderTableView extends StatelessWidget {
  final List<OrderModel> orders;

  const OrderTableView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowHeight: 48,
      dataRowHeight: 56,
      columns: const [
        DataColumn(label: Text('Mã đơn')),
        DataColumn(label: Text('Bàn')),
        DataColumn(label: Text('Trạng thái')),
        DataColumn(label: Text('Tổng tiền')),
        DataColumn(label: Text('Hình thức')),
        DataColumn(label: Text('Thời gian')),
      ],
      rows: orders.map((o) {
        return DataRow(
          cells: [
            DataCell(Text('code')),
            DataCell(Text('tableName')),
            DataCell(StatusBadge(OrderStatus.completed)),
            DataCell(Text('formatMoney(o.total)')),
            DataCell(Text('o.typeLabel')),
            DataCell(Text('formatTime(o.time)')),
          ],
        );
      }).toList(),
    );
  }
}

enum OrderStatus {
  processing, // Đang xử lý
  completed, // Hoàn tất
  cancelled, // Huỷ
}

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.processing:
        return 'Đang xử lý';
      case OrderStatus.completed:
        return 'Hoàn tất';
      case OrderStatus.cancelled:
        return 'Huỷ';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.grey;
    }
  }
}

class StatusBadge extends StatelessWidget {
  final OrderStatus status;

  const StatusBadge(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      OrderStatus.processing => Colors.blue,
      OrderStatus.completed => Colors.green,
      OrderStatus.cancelled => Colors.grey,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class OrderCardListView extends StatelessWidget {
  final List<OrderModel> orders;

  const OrderCardListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final o = orders[i];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('o.code',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    StatusBadge(OrderStatus.cancelled),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Bàn  • ${'11'}'),
                const SizedBox(height: 8),
                Text(
                  '11.000đ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '22-01-2026',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
