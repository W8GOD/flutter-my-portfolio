import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/assets.dart';
import 'package:my_portfolio/constants/colours.dart';
import 'package:my_portfolio/constants/strings.dart';
import 'package:my_portfolio/constants/text_styles.dart';
import 'package:my_portfolio/models/page_type.dart';
import 'package:my_portfolio/utils/screen/screen_util.dart';
import 'package:my_portfolio/widgets/responsive_widget.dart';

import 'navigation_actions.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends NavigationActions<ContactPage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    return Material(
      color: Color(Colours.color_background),
      child: Padding(
        padding: ResponsiveWidget.isSmallScreen(context)
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(
                horizontal: (ScreenUtil.getInstance().setWidth(108.0))),
        child: Scaffold(
          key: _drawerKey,
          drawerEdgeDragWidth: 0.0,
          backgroundColor: Colors.transparent,
          drawer: buildDrawer(context, PageType.contact),
          appBar: buildAppBar(context, _drawerKey, PageType.contact)
              as PreferredSizeWidget,
          body: LayoutBuilder(builder: (context, constraints) {
            return _buildBody(context, constraints);
          }),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildImageProfile(context),
              SizedBox(
                height: 20.0,
              ),
              _buildContactTitle(),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildContactButton(
                      Assets.github, Strings.github, Strings.github_link),
                  _buildContactButton(
                      Assets.linkedin, Strings.linkedin, Strings.linkedin_link),
                  _buildContactButton(
                      Assets.medium, Strings.medium, Strings.medium_link),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildContactButton(
                      Assets.facebook, Strings.facebook, Strings.facebook_link),
                  _buildContactButton(Assets.phone, Strings.phone, "")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageProfile(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: ResponsiveWidget.isSmallScreen(context) ? 100 : 200,
      child: Image.network(Assets.mail),
    );
  }

  Widget _buildContactTitle() {
    return Text(
      Strings.contact_me,
      textScaleFactor: 4.0,
      style: TextStyles.heading.copyWith(
          fontSize: ResponsiveWidget.isSmallScreen(context) ? 10 : 14),
    );
  }

  Widget _buildContactButton(String imageAsset, String title, String link) {
    double imageSize = ResponsiveWidget.isSmallScreen(context) ? 20.0 : 22.0;
    return TextButton.icon(
      icon: SizedBox(
          width: imageSize,
          height: imageSize,
          child: Image.network(imageAsset)),
      label: Text(title,
          style: TextStyles.heading.copyWith(
              color: Color(Colours.color_accent),
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 10 : 14)),
      onPressed: () {
        if (link.isNotEmpty) {
          html.window.open(link, title);
        }
      },
    );
  }
}
