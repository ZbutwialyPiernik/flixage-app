import 'package:flixage/model/user.dart';
import 'package:flixage/ui/pages/routes/user/user_page.dart';
import 'package:flixage/ui/widget/item/queryable_item.dart';
import 'package:flutter/cupertino.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryableItem(
      item: user,
      roundedImage: true,
      onTap: () => Navigator.pushNamed(context, UserPage.route, arguments: user),
      details: Text(user.name),
    );
  }
}
