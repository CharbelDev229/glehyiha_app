import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/constants/colors.dart';
// adapte selon ton chemin

class CustomButtomW extends StatelessWidget {
  final String? previousRoute;
  final String? nextRoute;
  final String label;

  const CustomButtomW({
    super.key,
    this.previousRoute,
    this.nextRoute,
    this.label = 'Suivant',
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 45,
          vertical: 15,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (previousRoute != null)
            GestureDetector(
              onTap: () => context.pushNamed(previousRoute!),
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 26, 119, 80),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 26, 119, 80),
            ),
          ),
          const SizedBox(width: 8),
          if (nextRoute != null)
            GestureDetector(
              onTap: () => context.pushNamed(nextRoute!),
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryGreen,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
