import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/assets.dart';
import 'package:my_portfolio/constants/colours.dart';
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
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: NetworkImage(Assets.background),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: ResponsiveWidget.isSmallScreen(context)
              ? EdgeInsets.zero
              : EdgeInsets.symmetric(
                  horizontal: (ScreenUtil.getInstance().setWidth(108.0))),
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
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
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
                _buildImageProfile(345.0),
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
                  padding: EdgeInsets.all(20.0),
                  child: _buildImageProfile(640.0),
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
                  padding: EdgeInsets.all(10.0),
                  child: _buildImageProfile(720.0),
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
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: ScreenUtil.getInstance().setWidth(imageSize / 2),
      backgroundImage: NetworkImage(Assets.profile),
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
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 8.0 : 16.0),
        ResponsiveWidget.isSmallScreen(context)
            ? Container()
            : _buildCaption(context),
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
            color: Color(Colours.color_accent),
            fontSize: ResponsiveWidget.isSmallScreen(context) ? 14.0 : 18.0,
          ),
        ),
      ],
    );
  }

  Widget _buildFullName(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: ResponsiveWidget.isSmallScreen(context)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisAlignment: ResponsiveWidget.isSmallScreen(context)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: <Widget>[
        Text(Strings.introduce,
            style: TextStyles.heading.copyWith(
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 20.0 : 32.0,
            )),
        DefaultTextStyle(
          style: TextStyle(),
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                Strings.full_name,
                textStyle: TextStyles.heading.copyWith(
                  color: Color(Colours.color_primary),
                  fontSize:
                      ResponsiveWidget.isSmallScreen(context) ? 20.0 : 32.0,
                ),
              ),
            ],
            totalRepeatCount: 4,
            pause: Duration(microseconds: 200),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ),
      ],
    );
  }

  Widget _buildPositionDescription(BuildContext context) {
    return Container(
      alignment: ResponsiveWidget.isSmallScreen(context)
          ? Alignment.center
          : Alignment.centerLeft,
      child: SelectableText(
        Strings.position_detail,
        textAlign: ResponsiveWidget.isSmallScreen(context)
            ? TextAlign.center
            : TextAlign.start,
        style: TextStyles.body.copyWith(
          color: Color(Colours.color_primary_dark),
          fontSize: ResponsiveWidget.isSmallScreen(context) ? 14.0 : 20.0,
        ),
      ),
    );
  }

  Widget _buildCaption(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: SelectableText(
        Strings.caption,
        textAlign: ResponsiveWidget.isSmallScreen(context)
            ? TextAlign.center
            : TextAlign.start,
        style: TextStyles.body.copyWith(
          color: Color(Colours.color_accent),
          fontSize: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 16.0,
        ),
      ),
    );
  }
}
