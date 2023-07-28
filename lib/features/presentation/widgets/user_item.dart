import 'package:crud_clean_architecture/features/domain/entities/user.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

class UserItem extends StatelessWidget {
  final UserEntity? user;
  final void Function(UserEntity article)? onRemove;
  final void Function(UserEntity article)? onUserTapped;

  const UserItem({Key? key, this.user, this.onRemove, this.onUserTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 18,
        ),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user!.name.toString(),
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  user!.email.toString(),
                  style: greyTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                _buildRemovableArea(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemovableArea() {
    return GestureDetector(
      onTap: _onRemove,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Icon(Icons.remove_circle_outline, color: Colors.red),
      ),
    );
  }

  void _onTap() {
    if (onUserTapped != null) {
      onUserTapped!(user!);
    }
  }

  void _onRemove() {
    if (onRemove != null) {
      onRemove!(user!);
    }
  }
}
