import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/modify/modify_controller.dart';

class ModifyScreen extends StatefulWidget {
  const ModifyScreen({Key? key}) : super(key: key);

  @override
  State<ModifyScreen> createState() => ModifyScreenState();
}

class ModifyScreenState extends State<ModifyScreen> {
  final modifyController = Get.put(ModifyController());

  @override
  void initState() {
    super.initState();
    modifyController.loadUserInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Obx(
                              () => CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    modifyController.pickedImage.value != null
                                        ? FileImage(
                                            File(modifyController
                                                .pickedImage.value!.path),
                                          )
                                        : const AssetImage('assets/avatar.png')
                                            as ImageProvider,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.camera_alt),
                              onPressed: modifyController.pickImage,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildField("Nom", modifyController.nomController, modifyController),
                      buildField("Prénom", modifyController.prenomController, modifyController),
                      buildField("Téléphone", modifyController.numController, modifyController),
                      const SizedBox(height: 10),
                      ListTile(
                        title: const Text("Mot de passe"),
                        subtitle: const Text("********"),
                        trailing: const Icon(Icons.edit),
                        onTap: modifyController.togglePasswordForm,
                      ),
                      Obx(() {
                        if (!modifyController.showPasswordForm.value) return const SizedBox();
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            TextField(
                              controller: modifyController.oldPasswordController,
                              decoration: const InputDecoration(
                                labelText: "Ancien mot de passe",
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: modifyController.newPasswordController,
                              decoration: const InputDecoration(
                                labelText: "Nouveau mot de passe",
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: modifyController.confirmPasswordController,
                              decoration: const InputDecoration(
                                labelText: "Confirmer le mot de passe",
                              ),
                              obscureText: true,
                            ),
                          ],
                        );
                      }),
                      const Spacer(),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                            elevation: 4,
                          ),
                          child: const Text(
                            "Valider",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildField(String label, TextEditingController controller, ModifyController modifyController) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => TextField(
              controller: controller,
              decoration: InputDecoration(labelText: label),
              enabled: modifyController.isEditing[label]?.value ?? false,
            )),
          ),
          Obx(() => IconButton(
            icon: Icon(
              modifyController.isEditing[label]?.value == true ? Icons.check : Icons.edit,
            ),
            onPressed: () => modifyController.toggleEdit(label),
          )),
        ],
      ),
    );
  }
}
