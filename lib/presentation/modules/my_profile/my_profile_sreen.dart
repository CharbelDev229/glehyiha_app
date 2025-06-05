import 'package:flutter/material.dart';
import 'package:glehiha/presentation/widgets/edit_personnal_info/edit_personal_info.dart';
import '../../../common/constants/colors.dart';
import '../../widgets/edit_personnal_info/edit_personnal_info_controller.dart';
import 'my_profile_controller.dart';
import 'widgets/my_profile_account_info_card.dart';
import '../../router/routes.dart';
import 'package:go_router/go_router.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => MyProfileScreenState();
}

class MyProfileScreenState extends State<MyProfileScreen> {
  final MyProfileController myProfileController = MyProfileController();

  final modifyController = ModifyController();

  @override
  void initState() {
    super.initState();
    myProfileController.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: MyProfileAccountInfoCard(
                  controller: myProfileController,
                ),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(AppRoutesNames.modify);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Information personnelles",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await myProfileController.onLogout();
                    myProfileController.profileService.clearCurrentUser();
                    context.pushNamed(AppRoutesNames.signIn);
                  },
                  icon: const Icon(Icons.logout, color: Colors.black54),
                  label: const Text(
                    "Déconnexion",
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
