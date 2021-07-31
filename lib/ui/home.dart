import 'dart:html' as html;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/assets.dart';
import 'package:my_portfolio/constants/colours.dart';
import 'package:my_portfolio/constants/fonts.dart';
import 'package:my_portfolio/constants/strings.dart';
import 'package:my_portfolio/constants/text_styles.dart';
import 'package:my_portfolio/ui/about.dart';
import 'package:my_portfolio/utils/screen/screen_util.dart';
import 'package:my_portfolio/widgets/responsive_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(Colours.color_snow),
      child: Padding(
        padding: ResponsiveWidget.isSmallScreen(context)
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(
                horizontal: (ScreenUtil.getInstance().setWidth(108))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(context) as PreferredSizeWidget,
          drawer: _buildDrawer(context),
          body: LayoutBuilder(builder: (context, constraints) {
            return _buildBody(context, constraints);
          }),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      title: _buildTitle(),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: !ResponsiveWidget.isSmallScreen(context)
          ? _buildActions(context)
          : null,
    );
  }

  Widget _buildTitle() {
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

  List<Widget> _buildActions(BuildContext context) {
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
        onPressed: () {},
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
          _navigateToNextAboutPage(context);
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

  void _navigateToNextAboutPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AboutPage()));
  }

  Widget? _buildDrawer(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: _buildActions(context),
        ),
      );
    } else {
      return null;
    }
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      padding: ResponsiveWidget.isSmallScreen(context)
          ? EdgeInsets.symmetric(
              horizontal: (ScreenUtil.getInstance().setWidth(108)))
          : EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
        child: ResponsiveWidget(
          largeScreen: _buildLargeScreen(context),
          mediumScreen: _buildMediumScreen(context),
          smallScreen: _buildSmallScreen(context),
        ),
      ),
    );
  }

  Widget _buildLargeScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(flex: 1, child: _buildContent(context)),
                _buildImageProfile(345),
              ],
            ),
          ),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildMediumScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.zero,
                  child: _buildImageProfile(640),
                ),
                _buildContent(context),
              ],
            ),
          ),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildSmallScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: _buildImageProfile(720),
                ),
                _buildContent(context),
              ],
            ),
          ),
          Divider(),
          _buildCopyRightText(context),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
          _buildSocialIcons(),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
        ],
      ),
    );
  }

  Widget _buildImageProfile(double imageSize) {
    return Image.network(
      Assets.profile_image,
      height: ScreenUtil.getInstance().setWidth(imageSize),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 0.0),
        _buildHello(context),
        SizedBox(height: 4.0),
        _buildFullName(context),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 8.0 : 16.0),
        _buildPositionDescription(context),
      ],
    );
  }

  Widget _buildHello(BuildContext context) {
    return Row(
      mainAxisAlignment: ResponsiveWidget.isSmallScreen(context)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        SelectableText(
          Strings.hello,
          style: TextStyles.heading.copyWith(
            fontFamily: Fonts.quicksand_bold,
            fontSize: ResponsiveWidget.isSmallScreen(context) ? 14.0 : 18.0,
          ),
        ),
      ],
    );
  }

  Widget _buildFullName(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: ResponsiveWidget.isSmallScreen(context)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: <Widget>[
        Text.rich(
          TextSpan(
            text: Strings.headline,
            style: TextStyles.heading.copyWith(
              fontFamily: Fonts.quicksand_bold,
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 20.0 : 32.0,
            ),
          ),
        ),
        DefaultTextStyle(
          style: TextStyle(),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                Strings.full_name,
                textStyle: TextStyles.heading.copyWith(
                  fontFamily: Fonts.quicksand_light,
                  color: Color(Colours.color_accent),
                  fontSize:
                      ResponsiveWidget.isSmallScreen(context) ? 26.0 : 32.0,
                ),
              ),
            ],
            totalRepeatCount: 5,
            pause: Duration(microseconds: 200),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ),
      ],
    );
  }

  Widget _buildPositionDescription(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40.0),
      child: SelectableText(
        Strings.position_detail,
        textAlign: ResponsiveWidget.isSmallScreen(context)
            ? TextAlign.center
            : TextAlign.start,
        style: TextStyles.body.copyWith(
          fontFamily: Fonts.quicksand_light,
          fontSize: ResponsiveWidget.isSmallScreen(context) ? 20.0 : 28.0,
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
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
                child: _buildCopyRightText(context),
                alignment: Alignment.centerLeft,
              ),
              Align(
                child: _buildSocialIcons(),
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCopyRightText(BuildContext context) {
    return Text(
      Strings.rights_reserved,
      style: TextStyles.body1.copyWith(
        fontSize: ResponsiveWidget.isSmallScreen(context) ? 8 : 10.0,
      ),
    );
  }

  Widget _buildSocialIcons() {
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
}
