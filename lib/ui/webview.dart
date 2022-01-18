import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_portfolio/constants/assets.dart';
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
            appBar: AppBar(
              leading: _buildLeadingIconButton(context),
              backgroundColor: Colors.black,
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      title ?? "",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyles.heading.copyWith(
                        color: Colors.white,
                        fontSize: ResponsiveWidget.isSmallScreen(context)
                            ? 14.0
                            : 20.0,
                      ),
                    )
                  ],
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
      ),
    );
  }

  Widget _buildLeadingIconButton(BuildContext context) {
    return IconButton(
      icon: Image.network(Assets.ic_back, height: 20.0, width: 20.0),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
