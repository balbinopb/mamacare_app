import 'package:flutter/material.dart';
import 'package:mamacare/app/constants/app_colors.dart';
import 'package:mamacare/app/data/models/user_model/user_model.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback onDelete;
  final VoidCallback routeUserDetatis;

  const UserTile({
    super.key,
    required this.user,
    required this.onDelete,
    required this.routeUserDetatis,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: SizedBox(
        height: 101,
        child: ListTile(
          leading: GestureDetector(
            onTap: routeUserDetatis,
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
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
