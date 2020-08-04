import 'package:flixage/generated/l10n.dart';
import 'package:flixage/model/queryable.dart';
import 'package:flixage/ui/widget/cached_network_image/custom_image.dart';
import 'package:flixage/ui/widget/item/context_menu/context_menu_button.dart';
import 'package:flutter/material.dart';

class QueryableAppBar extends StatelessWidget {
  final Queryable queryable;
  final String secondaryText;
  final bool showRandomButton;
  final Function onRandomButtonTap;
  final String contextMenuRoute;

  const QueryableAppBar({
    Key key,
    @required this.queryable,
    @required this.secondaryText,
    @required this.contextMenuRoute,
    this.showRandomButton,
    this.onRandomButtonTap,
  })  : assert(showRandomButton != null ? onRandomButtonTap != null : true),
        assert(queryable != null),
        assert(secondaryText != null),
        assert(contextMenuRoute != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: true,
      pinned: true,
      delegate: _QueryableAppBarDelegate(
          queryable: queryable,
          secondaryText: secondaryText,
          showRandomButton: showRandomButton,
          onRandomButtonTap: onRandomButtonTap,
          contextMenuRoute: contextMenuRoute),
    );
  }
}

//IconButton(
//  icon: Icon(Icons.more_vert),
//  onPressed: () => {},
//)

class _QueryableAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Queryable queryable;
  final String secondaryText;
  final String contextMenuRoute;
  final bool showRandomButton;
  final Function onRandomButtonTap;

  _QueryableAppBarDelegate({
    @required this.queryable,
    @required this.secondaryText,
    @required this.showRandomButton,
    @required this.onRandomButtonTap,
    @required this.contextMenuRoute,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double scrollableSize = maxExtent - minExtent;

    return Container(
      height: maxExtent,
      child: Stack(
        children: [
          Transform.translate(
            offset: Offset(0, -shrinkOffset.clamp(0, scrollableSize)),
            child: Transform.scale(
              alignment: FractionalOffset.topCenter,
              scale: (maxExtent / (maxExtent - shrinkOffset))
                  .clamp(1, maxExtent / minExtent)
                  .toDouble(),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.alphaBlend(Colors.amber.withOpacity(0.7),
                          Theme.of(context).scaffoldBackgroundColor),
                      Theme.of(context).scaffoldBackgroundColor
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CloseButton(),
                  Text(
                    queryable.name,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white.withOpacity(shrinkOffset / maxExtent),
                        ),
                  ),
                  ContextMenuButton(
                    route: contextMenuRoute,
                    item: queryable,
                  )
                ],
              ),
              Transform.translate(
                offset: Offset(0, shrinkOffset * 0.2),
                child: Transform.scale(
                  scale:
                      ((maxExtent - shrinkOffset) / maxExtent).clamp(0.8, 1).toDouble(),
                  child: Column(
                    children: [
                      CustomImage(
                          imageUrl: queryable.thumbnailUrl, width: 160, height: 160),
                      SizedBox(height: 16),
                      Text(
                        queryable.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        secondaryText.toUpperCase(),
                        style: Theme.of(context).textTheme.overline,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Transform.translate(
            offset: Offset(0, 32),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(S.current.queryablePage_playRandomly.toUpperCase(),
                      style: Theme.of(context).textTheme.button.copyWith(fontSize: 16)),
                ),
                color: Theme.of(context).accentColor,
                shape: StadiumBorder(),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 64;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
