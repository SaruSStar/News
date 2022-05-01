import 'package:flutter/Material.dart';
import 'package:news_application/modules/app/root.dart';
import 'package:news_application/modules/user/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool init = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (init) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.user == null) {
        userProvider.fetchAndSetCurrentUser();
      }
      setState(() => init = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ListTile(
            title: Text(
              user?.name ?? '',
            ),
            subtitle: Text(
              user?.username ?? '',
            ),
          ),
          ListTile(
            onTap: () {
              userProvider.logout();
              Navigator.pushNamed(context, Root.routeName);
            },
            title: const Text(
              'Logout',
            ),
          ),
        ],
      )),
    );
  }
}
