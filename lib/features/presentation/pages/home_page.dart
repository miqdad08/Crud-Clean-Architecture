import 'package:crud_clean_architecture/features/presentation/bloc/users/users_bloc.dart';
import 'package:crud_clean_architecture/features/presentation/widgets/user_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'User Management',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (_, state) {
        if (state is UsersLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is UsersFailed) {
          return Center(
            child: Text(state.error.toString()),
          );
        }
        if (state is UsersSuccess) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.users!.length,
            itemBuilder: (context, index) {
              return UserItem(
                user: state.users![index],
                // onUserTapped: ,
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  // void _onArticlePressed(BuildContext context, UserEntity user) {
  //   Navigator.pushNamed(context, ArticleDetail.routeName, arguments: user);
  // }
}
