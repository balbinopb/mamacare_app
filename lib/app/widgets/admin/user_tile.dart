import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/data/models/user_model.dart';
import 'package:mamacare/app/widgets/general/confirm_dialog.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback onDeleteUser;
  final VoidCallback onNavigateToUserDetails;

  const UserTile({
    super.key,
    required this.user,
    required this.onDeleteUser,
    required this.onNavigateToUserDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: SizedBox(
        height: 101,
        child: ListTile(
          leading: GestureDetector(
            onTap: onNavigateToUserDetails,
            child: Icon(Icons.person, color: Colors.yellow.shade800, size: 32),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name),
              Text(user.phone, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              Get.dialog(
                ConfirmDialog(
                  title: "Delete Item?",
                  message:"Are you sure you want to delete this User? This action cannot be undone.",
                  onConfirm: () => onDeleteUser,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
