// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../common/constants/colors.dart';
// import '../../../data/models/cart/cart_item_model.dart';
// import '../../modules/cart/cart_1_controller.dart';
// import '../../modules/product_detail/product_detail_1 controller.dart' show ProductDetailController;

// class CartItemWidget extends StatelessWidget {
//   final CartItemModel item;

//   final ProductDetailController productController = Get.put(ProductDetailController());
//   final Cart1Controller cartController = Get.find<Cart1Controller>();

//   CartItemWidget({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 211, 208, 208),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.white.withOpacity(0.3),
//             blurRadius: 6,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.asset(
//               item.image,
//               width: 140,
//               height: 140,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Titre + bouton supprimer
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         item.name,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.black),
//                       onPressed: () => cartController.removeFromCart(item),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 // Résumé
//                 Text(
//                   item.resume,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 // Boutons + prix
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         _qtyButton(Icons.remove, productController.decrement),
//                         const SizedBox(width: 8),
//                         Obx(() => Text(
//                           productController.quantity.value.toString(),
//                           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                         )),
//                         const SizedBox(width: 8),
//                         _qtyButton(Icons.add, productController.increment),
//                       ],
//                     ),
//                     Text(
//                       "${item.price} FCFA",
//                       style: const TextStyle(
//                         color: AppColors.primaryGreen,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _qtyButton(IconData icon, VoidCallback onPressed) {
//     return Container(
//       width: 24,
//       height: 24,
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         border: Border.all(color: Colors.black12),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: IconButton(
//         padding: EdgeInsets.zero,
//         onPressed: onPressed,
//         icon: Icon(icon, color: Colors.white, size: 18),
//       ),
//     );
//   }
// }
