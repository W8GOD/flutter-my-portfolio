import 'package:flutter/material.dart';
import 'package:my_portfolio/apis/medium.dart';
import 'package:my_portfolio/constants/colours.dart';
import 'package:my_portfolio/constants/text_styles.dart';
import 'package:my_portfolio/models/bloglist.dart';
import 'package:my_portfolio/models/page_type.dart';
import 'package:my_portfolio/ui/webview.dart';
import 'package:my_portfolio/utils/screen/screen_util.dart';
import 'package:my_portfolio/widgets/responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'navigation_actions.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends NavigationActions<BlogPage> {
  void launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    return Material(
      color: Color(Colours.color_background),
      child: Padding(
        padding: ResponsiveWidget.isSmallScreen(context)
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(
                horizontal: (ScreenUtil.getInstance().setWidth(108))),
        child: Scaffold(
          key: _drawerKey,
          drawerEdgeDragWidth: 0.0,
          backgroundColor: Colors.transparent,
          drawer: buildDrawer(context, PageType.blog),
          appBar: buildAppBar(context, _drawerKey, PageType.blog)
              as PreferredSizeWidget,
          body: SafeArea(
            child: FutureBuilder(
              future: Medium().getAllBlogs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return LayoutBuilder(
                      builder: (context, constraints) => _buildCardList(
                          context, constraints, snapshot.data as BlogList));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardList(
      BuildContext context, BoxConstraints constraints, BlogList? data) {
    int axisCount = 0;
    if (ResponsiveWidget.isSmallScreen(context)) {
      axisCount = 2;
    } else if (ResponsiveWidget.isMediumScreen(context)) {
      axisCount = 3;
    } else {
      axisCount = 5;
    }

    return Container(
        child: SingleChildScrollView(
      child: GridView.count(
        shrinkWrap: true,
        childAspectRatio: 9.0 / 8.0,
        padding: EdgeInsets.all(16.0),
        crossAxisCount: axisCount,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
          (data?.blogs != null && data?.blogs?.isNotEmpty == true)
              ? data!.blogs!.length
              : 0,
          (index) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: _CardItem(
              imageUrl: data?.blogs?[index].thumbnail ?? "",
              title: data?.blogs?[index].title ?? "",
              onClickAction: () {
                if (data?.blogs?[index].content?.isNotEmpty == true) {
                  navigateToNextWebViewPage(
                      data?.blogs?[index].title, data!.blogs![index].content!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Oops. Something went wrong. Please try again later"),
                  ));
                }
              },
            ),
          ),
        ).toList(),
      ),
    ));
  }

  void navigateToNextWebViewPage(String? title, String html) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => WebViewPage(
              title: title,
              html: html,
            )));
  }
}

class _CardItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Function onClickAction;

  _CardItem(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.onClickAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Image.network(imageUrl, fit: BoxFit.fill),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyles.heading.copyWith(
                        fontSize: 13.0,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

//published date
