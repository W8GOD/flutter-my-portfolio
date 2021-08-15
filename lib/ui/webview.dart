import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_portfolio/constants/colours.dart';
import 'package:my_portfolio/constants/text_styles.dart';
import 'package:my_portfolio/utils/screen/screen_util.dart';
import 'package:my_portfolio/widgets/responsive_widget.dart';

class WebViewPage extends StatelessWidget {
  final String html;
  final String? title;

  WebViewPage({Key? key, this.title, required this.html}) : super(key: key);

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
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              title ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.heading.copyWith(
                color: Colors.white,
                fontSize: ResponsiveWidget.isSmallScreen(context) ? 16 : 20.0,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Html(
              data: html,
            )),
          ),
        ),
      ),
    );
  }
}
