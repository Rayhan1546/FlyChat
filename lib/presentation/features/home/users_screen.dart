import 'package:flutter/material.dart';
import 'package:flychat/presentation/features/home/home_screen_viewmodel.dart';
import 'package:flychat/presentation/features/home/widgets/drawer.dart';
import 'package:flychat/util/values/dimens.dart';
import 'package:intl/intl.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  HomeScreenViewmodel viewmodel = HomeScreenViewmodel();

  ValueNotifier<bool> isVisibleNotifier = ValueNotifier(false);

  void onTapSearchIcon() {
    isVisibleNotifier.value = !isVisibleNotifier.value;
  }

  @override
  void initState() {
    viewmodel.fetchUserData();
    viewmodel.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: Dimens.getDimen(20),
            right: Dimens.getDimen(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _topButtons(context),
              ValueListenableBuilder(
                valueListenable: isVisibleNotifier,
                builder: (context, isVisible, _) => isVisible
                    ? _searchbar(context)
                    : const SizedBox(height: 10),
              ),
              _usersList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topButtons(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isVisibleNotifier,
      builder: (context, isVisible, _) => Row(
        children: [
          Transform.translate(
            offset: Offset(-Dimens.getDimen(10), 0),
            child: IconButton(
              onPressed: onTapSearchIcon,
              icon: Icon(
                size: Dimens.getDimen(30),
                isVisible ? Icons.close : Icons.search,
              ),
            ),
          ),
          const Spacer(),
          Text(
            'Message',
            style: TextStyle(
              fontSize: Dimens.getDimen(25),
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          ValueListenableBuilder(
            valueListenable: viewmodel.userData,
            builder: (context, user, _) => IconButton(
              onPressed: () => bottomSheetUi(context),
              icon: user?.profilePictureUrl != null
                  ? ClipOval(
                      child: Image.network(
                        user!.profilePictureUrl,
                        width: Dimens.getDimen(40),
                        height: Dimens.getDimen(40),
                        fit: BoxFit.cover,
                      ),
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchbar(BuildContext context) {
    return SizedBox(
      height: Dimens.getDimen(60),
      child: const TextField(
        style: TextStyle(),
        decoration: InputDecoration(
          hintText: 'Search people...',
          suffixIcon: Icon(
            Icons.search,
          ),
          fillColor: Colors.black12,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _usersList(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewmodel.username,
      builder: (context, name, _) => ValueListenableBuilder(
        valueListenable: viewmodel.usersData,
        builder: (context, users, _) => Expanded(
          child: ListView.builder(
            itemCount: users?.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () =>
                  viewmodel.onClickUser(users![index].receiverId, context),
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: Dimens.getDimen(35),
                height: Dimens.getDimen(35),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(name[index].profilePictureUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(name[index].username ?? ''),
              subtitle: Text(users?[index].content ?? ''),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(DateFormat.jm()
                      .format(users?[index].createdAt ?? DateTime.now())),
                  const Text(
                    '1',
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
