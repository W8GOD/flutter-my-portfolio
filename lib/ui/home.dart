import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/assets.dart';
import 'package:my_portfolio/constants/colours.dart';
import 'package:my_portfolio/constants/fonts.dart';
import 'package:my_portfolio/constants/strings.dart';
import 'package:my_portfolio/constants/text_styles.dart';
import 'package:my_portfolio/models/page_type.dart';
import 'package:my_portfolio/utils/screen/screen_util.dart';
import 'package:my_portfolio/widgets/responsive_widget.dart';

import 'navigation_actions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends NavigationActions {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    return Material(
      color: Color(Colours.color_snow),
      child: Padding(
        padding: ResponsiveWidget.isSmallScreen(context)
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(
                horizontal: (ScreenUtil.getInstance().setWidth(108))),
        child: Scaffold(
          key: _drawerKey,
          drawerEdgeDragWidth: 0.0,
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(context, _drawerKey, PageType.home)
              as PreferredSizeWidget,
          drawer: buildDrawer(context, PageType.home),
          body: LayoutBuilder(builder: (context, constraints) {
            return _buildBody(context, constraints);
          }),
        ),
      ),
    );
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
          buildFooter(context)
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
          buildFooter(context)
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
          buildCopyRightText(context),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
          buildSocialIcons(),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
        ],
      ),
    );
  }

  Widget _buildImageProfile(double imageSize) {
    return Image.network(
      Assets.ic_profile,
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
            text: Strings.introduce,
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
      padding: EdgeInsets.zero,
      child: SelectableText(
        Strings.position_detail,
        textAlign: ResponsiveWidget.isSmallScreen(context)
            ? TextAlign.center
            : TextAlign.start,
        style: TextStyles.body.copyWith(
          fontFamily: Fonts.quicksand_light,
          fontSize: ResponsiveWidget.isSmallScreen(context) ? 20.0 : 26.0,
        ),
      ),
    );
  }
}
