import 'package:crud_clean_architecture/features/domain/entities/user.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

class UserItemWidget extends StatelessWidget {
  final UserEntity? user;
  final void Function(UserEntity user)? onRemove;
  final void Function(UserEntity user)? onUpdate;

  const UserItemWidget({Key? key, this.user, this.onRemove, this.onUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user!.id.toString(),
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              Text(
                user!.name.toString(),
                overflow: TextOverflow.ellipsis,
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
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              _buildEditableArea(),
              _buildRemovableArea(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditableArea() {
    return GestureDetector(
      onTap: _onUpdate,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Icon(Icons.edit, color: Colors.blue),
      ),
    );
  }

  Widget _buildRemovableArea() {
    return GestureDetector(
      onTap: _onRemove,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Icon(Icons.delete, color: Colors.red),
      ),
    );
  }

  void _onUpdate() {
    if (onUpdate != null) {
      onUpdate!(user!);
    }
  }

  void _onRemove() {
    if (onRemove != null) {
      onRemove!(user!);
    }
  }

}
