import 'dart:html' as html;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/assets.dart';
import 'package:my_portfolio/constants/colours.dart';
import 'package:my_portfolio/constants/strings.dart';
import 'package:my_portfolio/constants/text_styles.dart';
import 'package:my_portfolio/models/page_type.dart';
import 'package:my_portfolio/ui/blog.dart';
import 'package:my_portfolio/utils/screen/screen_util.dart';
import 'package:my_portfolio/widgets/responsive_widget.dart';

import 'about.dart';
import 'blog.dart';
import 'contact.dart';
import 'home.dart';

abstract class NavigationActions<T extends StatefulWidget> extends State<T> {
  Widget buildAppBar(BuildContext context, GlobalKey<ScaffoldState> _drawerKey,
      PageType _pageType) {
    return AppBar(
      automaticallyImplyLeading: ResponsiveWidget.isSmallScreen(context),
      leading: ResponsiveWidget.isSmallScreen(context)
          ? _buildLeadingIconButton(_drawerKey)
          : null,
      titleSpacing: 0.0,
      title: buildTitle(),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: !ResponsiveWidget.isSmallScreen(context)
          ? buildActions(context, _pageType)
          : null,
    );
  }

  Widget _buildLeadingIconButton(GlobalKey<ScaffoldState> _drawerKey) {
    return IconButton(
      icon: Image.network(
        Assets.ic_menu,
        height: ScreenUtil.getInstance().setWidth(48),
      ),
      onPressed: () {
        _drawerKey.currentState?.openDrawer();
      },
    );
  }

  Widget buildTitle() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.0,
          color: Color(Colours.color_primary_dark),
        ),
        children: <TextSpan>[
          TextSpan(text: Strings.name, style: TextStyles.logo),
        ],
      ),
    );
  }

  List<Widget> buildActions(BuildContext context, PageType pageType) {
    return <Widget>[
      MaterialButton(
        child: Text(
          Strings.menu_home,
          style: TextStyles.menu_item.copyWith(
            color: Color(Colours.color_accent),
            fontSize: 16.0,
          ),
        ),
        onPressed: () {
          if (pageType != PageType.home)
            navigateToNextPage(context, HomePage());
        },
      ),
      MaterialButton(
        child: Text(
          Strings.menu_about,
          style: TextStyles.menu_item.copyWith(
            color: Color(Colours.color_accent),
            fontSize: 16.0,
          ),
        ),
        onPressed: () {
          if (pageType != PageType.about)
            navigateToNextPage(context, AboutPage());
        },
      ),
      MaterialButton(
        child: Text(
          Strings.menu_blog,
          style: TextStyles.menu_item.copyWith(
            color: Color(Colours.color_accent),
            fontSize: 16.0,
          ),
        ),
        onPressed: () {
          if (pageType != PageType.blog)
            navigateToNextPage(context, BlogPage());
        },
      ),
      MaterialButton(
        child: Text(
          Strings.menu_contact,
          style: TextStyles.menu_item.copyWith(
            color: Color(Colours.color_accent),
            fontSize: 16.0,
          ),
        ),
        onPressed: () {
          if (pageType != PageType.contact)
            navigateToNextPage(context, ContactPage());
        },
      ),
    ];
  }

  Widget? buildDrawer(BuildContext context, PageType pageType) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return Drawer(
        child: Container(
          color: Color(Colours.color_background),
          child: ListView(
            padding: EdgeInsets.all(20),
            children: buildActions(context, pageType),
          ),
        ),
      );
    } else {
      return null;
    }
  }

  Widget buildFooter(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                child: buildCopyRightText(context),
                alignment: Alignment.centerLeft,
              ),
              Align(
                child: buildSocialIcons(),
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCopyRightText(BuildContext context) {
    return Text(
      Strings.rights_reserved,
      style: TextStyles.body1.copyWith(
        fontSize: ResponsiveWidget.isSmallScreen(context) ? 8 : 10.0,
      ),
    );
  }

  Widget buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: 16.0),
        InkWell(
          onTap: () {
            html.window.open(
                "https://www.linkedin.com/in/arnon-aroondech", "LinkedIn");
          },
          child: Image.network(
            Assets.ic_linkedin,
            color: Color(Colours.color_primary_dark),
            height: 20.0,
            width: 20.0,
          ),
        ),
        SizedBox(width: 16.0),
        InkWell(
          onTap: () {
            html.window.open("https://medium.com/@arnona56", "Medium");
          },
          child: Image.network(
            Assets.ic_medium,
            color: Color(Colours.color_primary_dark),
            height: 20.0,
            width: 20.0,
          ),
        ),
        SizedBox(width: 16.0),
        InkWell(
          onTap: () {
            html.window.open("https://github.com/W8GOD", "Github");
          },
          child: Image.network(
            Assets.ic_github,
            color: Color(Colours.color_primary_dark),
            height: 20.0,
            width: 20.0,
          ),
        ),
      ],
    );
  }

  void navigateToNextPage(BuildContext context, Widget page) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => page,
      transitionDuration: Duration.zero,
    ));
  }
}
