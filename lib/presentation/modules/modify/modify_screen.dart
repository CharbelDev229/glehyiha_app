import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/modify/modify_controller.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';

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
        //child: Container(
        // padding: MediaQuery.of(context).viewInsets,
        child: Container(
          child: Container(
            padding: const EdgeInsets.all(20),
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
                                    File(
                                      modifyController.pickedImage.value!.path,
                                    ),
                                  )
                                  : const AssetImage(
                                        'assets/images/account.png',
                                      )
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

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      children: [
                        Form(
                          key: modifyController.formKey,
                          autovalidateMode:
                              modifyController.autoValidate.value
                                  ? AutovalidateMode.always
                                  : AutovalidateMode.disabled,
                          child: Column(
                            children: [
                              buildField(
                                "Nom",
                                modifyController.nomController,
                                modifyController,
                              ),
                              buildField(
                                "Prénom",
                                modifyController.prenomController,
                                modifyController,
                              ),
                              buildField(
                                "Téléphone",
                                modifyController.numController,
                                modifyController,
                              ),

                              const SizedBox(height: 10),
                              ListTile(
                                title: const Text("Mot de passe"),
                                subtitle: const Text("********"),
                                trailing: const Icon(Icons.edit),
                                onTap: modifyController.togglePasswordForm,
                              ),

                              Obx(() {
                                if (!modifyController.showPasswordForm.value)
                                  return const SizedBox();
                                return Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    TextField(
                                      controller:
                                          modifyController
                                              .oldPasswordController,
                                      decoration: const InputDecoration(
                                        labelText: "Ancien mot de passe",
                                      ),
                                      obscureText: true,
                                    ),
                                    TextField(
                                      controller:
                                          modifyController
                                              .newPasswordController,
                                      decoration: const InputDecoration(
                                        labelText: "Nouveau mot de passe",
                                      ),
                                      obscureText: true,
                                    ),
                                    TextField(
                                      controller:
                                          modifyController
                                              .confirmPasswordController,
                                      decoration: const InputDecoration(
                                        labelText: "Confirmer le mot de passe",
                                      ),
                                      obscureText: true,
                                    ),
                                  ],
                                );
                              }),

                              const SizedBox(height: 30),

                              Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final success = await modifyController
                                        .submitEditPersonnalInfo(context);
                                    print("Succès : $success");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 12,
                                    ),
                                    elevation: 4,
                                  ),
                                  child: const Text(
                                    "Valider",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(
    String label,
    TextEditingController fieldController,
    ModifyController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => TextField(
                controller: fieldController,
                decoration: InputDecoration(labelText: label),
                enabled: controller.isEditing[label]?.value ?? false,
              ),
            ),
          ),
          Obx(
            () => IconButton(
              icon: Icon(
                controller.isEditing[label]?.value == true
                    ? Icons.check
                    : Icons.edit,
              ),
              onPressed: () {
                controller.toggleEdit(label);
              },
            ),
          ),
        ],
      ),
    );
  }
}
