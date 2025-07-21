import 'package:flutter/material.dart';
import 'package:glehiha/data/models/expert/expert_model.dart';
import 'package:glehiha/presentation/widgets/header_widget/header_widget.dart';
import 'package:glehiha/common/constants/colors.dart';
import '../../../common/constants/assets/assets.dart';
import '../../../common/utils/utils.dart';
import '../../widgets/bottom_navigation_bar/bottom_navigation_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpertPageScreen extends StatelessWidget {
  final String name;
  final Expert expert;
  
  const ExpertPageScreen({super.key, required this.name, required this.expert});

  // Fonction pour lancer un appel téléphonique
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Impossible de lancer l\'appel vers $phoneNumber';
    }
  }

  // Fonction pour ouvrir WhatsApp
  Future<void> _openWhatsApp(String phoneNumber) async {
    // Formater le numéro de téléphone (supprimer les espaces et le +)
    String formattedNumber = phoneNumber.replaceAll(' ', '');
    if (formattedNumber.startsWith('+')) {
      formattedNumber = formattedNumber.substring(1);
    }
    
    // Créer l'URL WhatsApp
    final Uri whatsappUri = Uri.parse('https://wa.me/$formattedNumber');
    
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Impossible d\'ouvrir WhatsApp pour $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
             HeaderWidget(),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(Assets.expert, width: 109, height: 109),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            SizedBox(height: 20),
                            Text(
                              "${expert.firstName} ${expert.lastName}" ?? 'Nom non disponible',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              expert.specialization ?? 'Spécialité non disponible',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Icon(Icons.email, size: 30, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Text(
                        expert.email ?? 'Localisation non disponible',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [ 
                      Icon(Icons.work, size: 30, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Text(
                        "Expérience: ${expert.experience} ans" ?? 'Description non disponible',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (expert.phoneNumber != null && expert.phoneNumber!.isNotEmpty) {
                            _makePhoneCall(expert.phoneNumber!);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Numéro de téléphone non disponible'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 11,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.asset(Assets.phone, width: 24, height: 24),
                              const SizedBox(width: 8),
                              const Text(
                                'Appeler',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          if (expert.phoneNumber != null && expert.phoneNumber!.isNotEmpty) {
                            _openWhatsApp(expert.phoneNumber!);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Numéro de téléphone non disponible'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 11,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.asset(Assets.message, width: 24, height: 24),
                              const SizedBox(width: 8),
                              const Text(
                                'Message',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
