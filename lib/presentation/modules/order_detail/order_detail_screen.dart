// import 'package:flutter/material.dart';

//  import '../../../common/constants/colors.dart';
//  import '../../widgets/doted_line/doted_line.dart';


//  class OrderDetailScreen extends StatelessWidget {
//    const OrderDetailScreen({super.key});

//    @override
//   Widget build(BuildContext context) {
//      return Scaffold(
//       appBar: AppBar(
//          title: Text('RÉcapitulatif de la commande',
//          style: TextStyle(
//          color: Colors.white,
//            fontSize: 20,
//           fontWeight: FontWeight.w600,)),
//       backgroundColor: AppColors.primaryGreen,),

//       body: Padding(
//    padding: const EdgeInsets.all(16.0),
//    child: Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//        const DottedLine(),
//       const SizedBox(height: 16),
//        Text(
//          fullName,
//         style: const TextStyle(
//            fontSize: 18,
//            fontWeight: FontWeight.w600,
//          ),
//        ),
//       const SizedBox(height: 20),
//        SizedBox(
//          height: 120,
//          child: ListView.builder(
//            scrollDirection: Axis.horizontal,
//           //  itemCount: cartItems.length,
//           //  itemBuilder: (context, index) {
//           //   final item = cartItems[index];
//             return Container(
//               margin: const EdgeInsets.only(right: 12),
//               width: 100,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                  children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                    child: Image.network(
//                       item.imageUrl,
//                       height: 70,
//                       width: 70,
//                        fit: BoxFit.cover,                     ),
//                    ),
//                   const SizedBox(height: 8),
//                    Text(
//                     item.name,
//                      maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                    ),
//                    Text('x${item.quantity}'),
//                  ],
//                ),
//              );
//            }         ),
//       )  ,     const SizedBox(height: 20),
//        Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: [
//           const Text(
//              'Total',
//              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//            ),
//           Text('',
//          //    '${totalAmount.toStringAsFixed(2)} F',
//              style: const TextStyle(
//                fontSize: 18,
//               fontWeight: FontWeight.bold,
//                color: Colors.green,             ),
//          ),
//          ],      ),
//        const SizedBox(height: 30),
//        SizedBox(
//          width: double.infinity,         child: ElevatedButton(
//            onPressed: () {
//              ScaffoldMessenger.of(context).showSnackBar(               const SnackBar(content: Text('Commande validée !')),
//              );
//            },
//            child: const Text(
//              'Commander',
//              style: TextStyle(fontSize: 18),
//            ),
//         ),
//       ),
//     ],
//   ),),

//          );
//   }
// }
