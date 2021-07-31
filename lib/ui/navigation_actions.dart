import 'dart:html' as html;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/assets.dart';
import 'package:my_portfolio/constants/colours.dart';
import 'package:my_portfolio/constants/fonts.dart';
import 'package:my_portfolio/constants/strings.dart';
import 'package:my_portfolio/constants/text_styles.dart';
import 'package:my_portfolio/widgets/responsive_widget.dart';

import 'about.dart';
import 'home.dart';

abstract class NavigationActions extends StatelessWidget {
  Widget buildAppBar(BuildContext context, {enableAppBarButton = false}) {
    return AppBar(
      automaticallyImplyLeading: enableAppBarButton,
      titleSpacing: 0.0,
      title: buildTitle(),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: !ResponsiveWidget.isSmallScreen(context)
          ? buildActions(context)
          : null,
    );
  }

  Widget buildTitle() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: Strings.name,
            style: TextStyles.logo.copyWith(
              fontFamily: Fonts.quicksand_bold,
              color: Color(Colours.color_accent),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      MaterialButton(
        child: Text(
          Strings.menu_home,
          style: TextStyles.menu_item.copyWith(
            color: Color(Colours.color_accent),
            fontFamily: Fonts.quicksand_bold,
            fontSize: 16.0,
          ),
        ),
        onPressed: () {
          navigateToNextHomePage(context);
        },
      ),
      MaterialButton(
        child: Text(
          Strings.menu_about,
          style: TextStyles.menu_item.copyWith(
            color: Color(Colours.color_accent),
            fontFamily: Fonts.quicksand_bold,
            fontSize: 16.0,
          ),
        ),
        onPressed: () {
          navigateToNextAboutPage(context);
        },
      ),
      MaterialButton(
        child: Text(
          Strings.menu_contact,
          style: TextStyles.menu_item.copyWith(
            color: Color(Colours.color_accent),
            fontFamily: Fonts.quicksand_bold,
            fontSize: 16.0,
          ),
        ),
        onPressed: () {},
      ),
    ];
  }

  Widget? buildDrawer(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: buildActions(context),
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
        GestureDetector(
          onTap: () {
            html.window.open(
                "https://www.linkedin.com/in/arnon-aroondech", "LinkedIn");
          },
          child: Image.network(
            Assets.linkedin,
            color: Color(Colours.color_primary_dark),
            height: 20.0,
            width: 20.0,
          ),
        ),
        SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {
            html.window.open("https://medium.com/@arnona56", "Medium");
          },
          child: Image.network(
            Assets.medium,
            color: Color(Colours.color_primary_dark),
            height: 20.0,
            width: 20.0,
          ),
        ),
        SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {
            html.window.open("https://github.com/W8GOD", "Github");
          },
          child: Image.network(
            Assets.github,
            color: Color(Colours.color_primary_dark),
            height: 20.0,
            width: 20.0,
          ),
        ),
      ],
    );
  }

  void navigateToNextAboutPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AboutPage()));
  }

  void navigateToNextHomePage(BuildContext context) {
    Route route = MaterialPageRoute(builder: (context) => HomePage());
    Navigator.of(context)
        .pushAndRemoveUntil(route, (Route<dynamic> route) => false);
  }
}
