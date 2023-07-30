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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.users!.length,
              itemBuilder: (context, index) {
                return UserItem(
                  user: state.users![index],
                  onRemove: (user) => _onRemoveUser(context, user),
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
      onPressed: () => addUserDialog(
        context,
        false,
        UserEntity(
          email: _emailController.text,
          name: _nameController.text,
        ),
      ),
      child: const Icon(Icons.add),
    );
  }

  void addUserDialog(BuildContext context, bool isEdit, UserEntity user) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          emailController: _emailController,
          nameController: _nameController,
          onSave: () =>
              isEdit ? _onUpdateUser(context, user) : _onAddUser(context, user),
          onCancel: () => _onCancel(context),
        );
      },
    );
  }

  void _onAddUser(BuildContext context, UserEntity user) {
    BlocProvider.of<UsersBloc>(context).add(AddUser(user));
  }

  void _onUpdateUser(BuildContext context, UserEntity user) {
    BlocProvider.of<UsersBloc>(context).add(UpdateUser(user));
  }

  void _onCancel(BuildContext context) {
    Navigator.pop(context);
  }

  void _onRemoveUser(BuildContext context, UserEntity user) {
    BlocProvider.of<UsersBloc>(context).add(RemoveUser(user));
  }
}
