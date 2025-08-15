import 'package:flutter/material.dart';
import 'package:mamacare/models/admin/user_model.dart';

class UserTile extends StatelessWidget {
  final VoidCallback  routeUserDetatis;
  final UserModel user;
  final VoidCallback onDelete;

  const UserTile({super.key, required this.user, required this.onDelete, required this.routeUserDetatis});

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.symmetric(vertical: 4),
      color: Colors.white,
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
              Text(user.email, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
