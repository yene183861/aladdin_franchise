// import 'package:flutter/material.dart';

// class BistroScreen extends StatelessWidget {
//   const BistroScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6F8),
//       body: Row(
//         children: [
//           _buildSidebar(),
//           Expanded(child: _buildMenu()),
//           _buildCartPanel(),
//         ],
//       ),
//     );
//   }

//   Widget _buildSidebar() {
//     return Container(
//       width: 220,
//       color: Colors.white,
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Bistro Elite", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//           const SizedBox(height: 20),
//           _sideItem(Icons.map, "Floor Plan"),
//           _sideItem(Icons.restaurant_menu, "Menu", active: true),
//           _sideItem(Icons.receipt, "Orders"),
//           _sideItem(Icons.people, "Staff"),
//           _sideItem(Icons.settings, "Settings"),
//           const Spacer(),
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Text("Server #12"),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _sideItem(IconData icon, String title, {bool active = false}) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: active ? Colors.orange.withOpacity(0.1) : Colors.transparent,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: active ? Colors.orange : Colors.grey),
//           const SizedBox(width: 10),
//           Text(title, style: TextStyle(color: active ? Colors.orange : Colors.black)),
//         ],
//       ),
//     );
//   }

//   Widget _buildMenu() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildTopBar(),
//           const SizedBox(height: 16),
//           _buildCategoryTabs(),
//           const SizedBox(height: 16),
//           Expanded(
//             child: GridView.count(
//               crossAxisCount: 3,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//               childAspectRatio: 0.8,
//               children: List.generate(6, (index) => _buildFoodCard()),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildTopBar() {
//     return Row(
//       children: [
//         const Text("BÀN 19", style: TextStyle(fontWeight: FontWeight.bold)),
//         const Spacer(),
//         Container(
//           width: 250,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: const TextField(
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: "Tìm kiếm món...",
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildCategoryTabs() {
//     final tabs = ["Tất cả", "Dimsum", "Món Cơm", "Mỳ & Miến", "Khai vị"];
//     return Row(
//       children: tabs.map((e) {
//         final active = e == "Tất cả";
//         return Container(
//           margin: const EdgeInsets.only(right: 10),
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//           decoration: BoxDecoration(
//             color: active ? Colors.orange : Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Text(
//             e,
//             style: TextStyle(color: active ? Colors.white : Colors.black),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildFoodCard() {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 'https://images.unsplash.com/photo-1604908176997-431a1e4d6c8d',
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           const Text("Há cảo tôm tươi", style: TextStyle(fontWeight: FontWeight.bold)),
//           const SizedBox(height: 4),
//           const Text("58.000đ", style: TextStyle(color: Colors.orange)),
//           const Spacer(),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Container(
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: Colors.orange,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: const Icon(Icons.add, color: Colors.white, size: 16),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildCartPanel() {
//     return Container(
//       width: 320,
//       color: Colors.white,
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             child: const Text("ĐANG CHỌN", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           const Divider(height: 1),
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(16),
//               children: List.generate(3, (index) => _cartItem()),
//             ),
//           ),
//           _cartSummary()
//         ],
//       ),
//     );
//   }

//   Widget _cartItem() {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: const [
//           CircleAvatar(radius: 20),
//           SizedBox(width: 10),
//           Expanded(child: Text("Há cảo tôm tươi")),
//           Text("116.000đ"),
//         ],
//       ),
//     );
//   }

//   Widget _cartSummary() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Text("Tổng"),
//               Text("354.000đ", style: TextStyle(fontWeight: FontWeight.bold)),
//             ],
//           ),
//           const SizedBox(height: 12),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.orange,
//               minimumSize: const Size.fromHeight(45),
//             ),
//             onPressed: () {},
//             child: const Text("GỌI MÓN"),
//           ),
//           const SizedBox(height: 8),
//           OutlinedButton(
//             onPressed: () {},
//             child: const Text("THANH TOÁN"),
//           )
//         ],
//       ),
//     );
//   }
// }
