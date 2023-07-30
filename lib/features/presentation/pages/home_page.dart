import 'package:crud_clean_architecture/features/domain/entities/user.dart';
import 'package:crud_clean_architecture/features/presentation/bloc/users/users_bloc.dart';
import 'package:crud_clean_architecture/features/presentation/widgets/dialog_box.dart';
import 'package:crud_clean_architecture/features/presentation/widgets/user_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'List User',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (_, state) {
        if (state is UsersLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is UsersFailed) {
          return Center(
            child: Text(state.error!.message.toString()),
          );
        }
        if (state is UserUpdated) {
          BlocProvider.of<UsersBloc>(context).add(const GetUsers());
        }
        if (state is UsersSuccess) {
          if(state.users!.isEmpty) {
            return const Center(
              child: Text('No data'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.users!.length,
              itemBuilder: (context, index) {
                return UserItemWidget(
                  user: state.users![index],
                  onRemove: (user) => _onRemoveUser(context, user),
                  onUpdate: (user) {
                    _nameController.text = user.name!;
                    _emailController.text = user.email!;
                    _updateUserDialog(context, user);
                  },
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: purpleColor,
      onPressed: () => _addUserDialog(
        context,
        false,
      ),
      child: const Icon(Icons.add),
    );
  }

  void _updateUserDialog(BuildContext context, UserEntity user) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          emailController: _emailController,
          nameController: _nameController,
          onSave: () => _onUpdateUser(context, user),
          onCancel: () => _onBack(context),
        );
      },
    );
  }

  void _addUserDialog(BuildContext context, bool isEdit) {
    _clearTextController();
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          emailController: _emailController,
          nameController: _nameController,
          onSave: () => _onAddUser(context),
          onCancel: () => _onBack(context),
        );
      },
    );
  }

  void _onAddUser(BuildContext context) {
    final user = UserEntity(
      name: _nameController.text,
      email: _emailController.text,
    );
    BlocProvider.of<UsersBloc>(context).add(AddUser(user));
    _clearTextController();
    _onBack(context);
  }

  void _onUpdateUser(BuildContext context, UserEntity user) {
    final userItem = UserEntity(
      name: _nameController.text,
      email: _emailController.text,
      id: user.id,
    );
    BlocProvider.of<UsersBloc>(context).add(UpdateUser(userItem));
    _clearTextController();
    _onBack(context);
  }

  void _clearTextController() {
    _nameController.clear();
    _emailController.clear();
  }

  void _onBack(BuildContext context) {
    Navigator.pop(context);
  }

  void _onRemoveUser(BuildContext context, UserEntity user) {
    BlocProvider.of<UsersBloc>(context).add(RemoveUser(user));
  }
}
