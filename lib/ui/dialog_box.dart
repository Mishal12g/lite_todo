import 'package:flutter/material.dart';
import 'package:lite_todo/ui/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple.shade100,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //get user input
            TextField(
              controller: controller,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w400,
                ),
                hintText: "Создать новую задачу",
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
              ),
            ),

            //buttons save and cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //cancel
                Expanded(
                    child: MyButton(text: "Отменить", onPressed: onCancel)),

                const SizedBox(width: 10),

                //save
                Expanded(child: MyButton(text: "Сохранить", onPressed: onSave)),
              ],
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
