import 'package:flutter/material.dart';
import 'package:glehiha/data/models/product_detail/product_model.dart';


class ProductDetailListItem extends StatelessWidget {
  final ProductModel product;
  final Function()? onTap;

  const ProductDetailListItem({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
      
        // decoration: BoxDecoration(
        //   color: AppColors.white,
        //   borderRadius: BorderRadius.circular(12),
        //   boxShadow: [
        //     BoxShadow(
        //       color: const Color.fromARGB(255, 170, 168, 168).withOpacity(0.2),
        //       blurRadius: 5,
        //       offset: const Offset(2, 2),
        //     ),
         // ],
        //),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9, 
                child: Image.asset(
                  product.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Infos produit
            Padding(
              padding: const EdgeInsets.all(12),
              // child: Container(
              //   decoration: BoxDecoration(
              //     boxShadow: [
              //       BoxShadow(
              //         color: const Color.fromARGB(
              //           255,
              //           207,
              //           205,
              //           205,
              //         ).withOpacity(0.15),
              //         blurRadius: 3,
              //         offset: const Offset(0, 1),
              //       ),
              //     ],
              //   ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   
                    SizedBox(height: 10,),
                    Text(product.quantity,
                     style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    ),

                    SizedBox(height: 6,),
                    Text(
                      product.seller,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),

                     SizedBox(height: 6,),
                    Text(
                      product.category as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),

                  
                  ],
                ),
              ),
          ]  ),
          
        ),
      );
    
  }
}