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
      color: Color(Colours.color_snow),
      child: Padding(
        padding: ResponsiveWidget.isSmallScreen(context)
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(
                horizontal: (ScreenUtil.getInstance().setWidth(108))),
        child: Scaffold(
          key: _drawerKey,
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
                      builder: (context, constraints) => _cardList(
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

  Widget _cardList(
      BuildContext context, BoxConstraints constraints, BlogList? data) {
    return Container(
        child: SingleChildScrollView(
      child: GridView.count(
        childAspectRatio: constraints.biggest.aspectRatio * 3 / 2,
        shrinkWrap: true,
        crossAxisCount: ResponsiveWidget.isSmallScreen(context) ? 2 : 3,
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
                  navigateToNextWebViewPage(data?.blogs?[index].title,
                      data!.blogs![index].content!);
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
    return GestureDetector(
      onTap: () {
        onClickAction();
      },
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
            alignment: Alignment.bottomCenter,
            decoration: _cardImageItem(),
            child: _cardTextItem(context)),
      ),
    );
  }

  BoxDecoration _cardImageItem() {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }

  Widget _cardTextItem(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black54,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyles.heading.copyWith(
            color: Colors.white,
            fontSize: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 14.0,
          ),
          maxLines: 2,
        ),
      ),
    );
  }
}
