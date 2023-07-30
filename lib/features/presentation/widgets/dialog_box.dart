import 'package:crud_clean_architecture/features/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController nameController;
  final bool isEdit;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    Key? key,
    required this.emailController,
    required this.onSave,
    required this.onCancel,
    this.isEdit = false,
    required this.nameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SizedBox(
        height: 190,
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Input Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Input Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButtonWidget(
                  onPressed: onSave,
                  textButton: isEdit ? 'Save' :'Add',
                ),
                const SizedBox(
                  width: 10,
                ),
                MyButtonWidget(
                  onPressed: onCancel,
                  textButton: 'Cancel',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
