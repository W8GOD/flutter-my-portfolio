import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/assets.dart';
import 'package:my_portfolio/constants/colours.dart';
import 'package:my_portfolio/constants/strings.dart';
import 'package:my_portfolio/constants/text_styles.dart';
import 'package:my_portfolio/models/education.dart';
import 'package:my_portfolio/models/page_type.dart';
import 'package:my_portfolio/models/work_experience.dart';
import 'package:my_portfolio/ui/navigation_actions.dart';
import 'package:my_portfolio/utils/screen/screen_util.dart';
import 'package:my_portfolio/widgets/responsive_widget.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends NavigationActions {
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
            appBar: buildAppBar(context, _drawerKey, PageType.about)
                as PreferredSizeWidget,
            drawer: buildDrawer(context, PageType.about),
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
      padding: ResponsiveWidget.isSmallScreen(context)
          ? EdgeInsets.symmetric(
              horizontal: (ScreenUtil.getInstance().setWidth(108.0)))
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

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 0.0),
        _buildAboutMe(context),
        SizedBox(height: 4.0),
        _buildHeadline(context),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 24.0),
        ResponsiveWidget.isSmallScreen(context)
            ? _buildSummarySingleColumns(context)
            : _buildSummaryMultipleColumns(context),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 48.0),
        ResponsiveWidget.isSmallScreen(context)
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildWorkExperience(),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: _buildEducation(),
                  ),
                  SizedBox(height: 24.0),
                  _buildTechnicalSkills(context),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: _buildSoftSkills(context),
                  ),
                ],
              )
            : _buildSkillsAndHistory(context)
      ],
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: ResponsiveWidget.isSmallScreen(context)
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: <Widget>[
          SelectableText(
            Strings.introduce,
            style: TextStyles.body.copyWith(
              color: Color(Colours.color_primary_dark),
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 18 : 22.0,
            ),
          ),
          SelectableText(
            Strings.full_name,
            style: TextStyles.body.copyWith(
              color: Color(Colours.color_primary),
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 18 : 22.0,
            ),
          ),
        ]);
  }

  Widget _buildSummarySingleColumns(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildSummaryItem(context, Strings.summary),
        _buildSummaryItem(context, Strings.summaryExtra),
      ],
    );
  }

  Widget _buildSummaryMultipleColumns(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _buildSummaryItem(context, Strings.summary)),
        SizedBox(
          width: 30,
        ),
        Expanded(child: _buildSummaryItem(context, Strings.summaryExtra)),
      ],
    );
  }

  Widget _buildSummaryItem(BuildContext context, String summary) {
    return Column(
      children: <Widget>[
        SelectableText(
          summary,
          textAlign: TextAlign.start,
          style: TextStyles.body.copyWith(
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 14 : 16.0,
              color: Color(Colours.color_primary_dark)),
        ),
      ],
    );
  }

  Widget _buildAboutMe(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: Strings.about_me,
            style: TextStyles.heading.copyWith(
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEducation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildEducationContainerHeading(),
        SizedBox(height: 8.0),
        _buildEducationTimeline(),
      ],
    );
  }

  Widget _buildEducationContainerHeading() {
    return SelectableText(
      Strings.education,
      style: TextStyles.sub_heading.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildEducationTimeline() {
    final List<Widget> widgets = educationList
        .map((education) => _buildEducationTile(education))
        .toList();
    return Column(children: widgets);
  }

  Widget _buildEducationTile(Education education) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SelectableText(
            '${education.post}',
            style: TextStyles.company,
          ),
          SelectableText(
            '${education.university}',
            style: TextStyles.body.copyWith(
              color: Color(Colours.color_primary_dark),
            ),
          ),
          SelectableText(
            '${education.from}-${education.to}',
            style:
                TextStyles.body.copyWith(color: Color(Colours.color_primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkExperience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildWorkExperienceContainerHeading(),
        SizedBox(height: 8.0),
        _buildWorkExperienceTimeline(),
      ],
    );
  }

  Widget _buildWorkExperienceContainerHeading() {
    return SelectableText(
      Strings.work_experience,
      style: TextStyles.sub_heading.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildWorkExperienceTimeline() {
    final List<Widget> widgets = workExperienceList
        .map((workExperience) => _buildWorkExperienceTile(workExperience))
        .toList();
    return Column(children: widgets);
  }

  Widget _buildWorkExperienceTile(WorkExperience workExperience) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(0.0),
            alignment: Alignment.centerLeft,
            height: ResponsiveWidget.isSmallScreen(context) ? 20 : 26,
            child: Image.network(workExperience.icon),
          ),
          SelectableText(
            '${workExperience.post}',
            style: TextStyles.company,
          ),
          SelectableText(
            '${workExperience.organization}',
            style: TextStyles.body.copyWith(
              color: Color(Colours.color_primary_dark),
            ),
          ),
          SelectableText(
            '${workExperience.from}-${workExperience.to}',
            style:
                TextStyles.body.copyWith(color: Color(Colours.color_primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalSkills(BuildContext context) {
    final List<Widget> widgets = technicalSkills
        .map((skill) => Padding(
              padding: EdgeInsets.only(top: 8.0, right: 4.0),
              child: _buildSkillChip(context, skill),
            ))
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTechnicalSkillsContainerHeading(),
        Wrap(children: widgets),
      ],
    );
  }

  Widget _buildSoftSkills(BuildContext context) {
    final List<Widget> widgets = softSkills
        .map((skill) => Padding(
              padding: EdgeInsets.only(top: 8.0, right: 4.0),
              child: _buildSkillChip(context, skill),
            ))
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSoftSkillsContainerHeading(),
        Wrap(children: widgets),
      ],
    );
  }

  Widget _buildSkillsAndHistory(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildWorkExperience(),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: _buildEducation(),
              )
            ],
          ),
        ),
        SizedBox(width: 40.0),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTechnicalSkills(context),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: _buildSoftSkills(context),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(BuildContext context, String label) {
    return Chip(
      backgroundColor: Color(Colours.color_highlight).withOpacity(0.5),
      label: SelectableText(
        label,
        style: TextStyles.chip.copyWith(
          fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.0 : 12.0,
        ),
      ),
    );
  }

  Widget _buildTechnicalSkillsContainerHeading() {
    return SelectableText(
      Strings.technical_skills,
      style: TextStyles.sub_heading.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSoftSkillsContainerHeading() {
    return SelectableText(
      Strings.soft_skills,
      style: TextStyles.sub_heading.copyWith(fontWeight: FontWeight.bold),
    );
  }

  final educationList = [
    Education(
      'Aug 2013',
      'May 2017',
      'Naresuan University',
      'B.Eng (Computer Engineering)',
    ),
  ];

  final workExperienceList = [
    WorkExperience('Jun 2017', 'Nov 2017', 'Geotalent., Co. Ltd.',
        'Programmer (Android/iOS)', Assets.ic_geotalent),
    WorkExperience('Nov 2017', 'Jul 2019', 'True Digital Group., Co. Ltd.',
        'Programmer (Android)', Assets.ic_true),
    WorkExperience('Aug 2019', 'Nov 2021', 'Amity Corporation (HQ)',
        'Android Engineer', Assets.ic_amity),
    WorkExperience('Nov 2021', 'Present', 'Central Retail Co, Ltd.',
        'Android Engineer Specialist', Assets.ic_central),
  ];

  final technicalSkills = [
    'Kotlin',
    'Java',
    'Swift',
    'Objective-C',
    'Dart',
    'MVC',
    'MVP',
    'MVVM',
    'Clean Architecture',
    'Unit Test JUnit/Mockito',
    'Flutter',
    'Android',
    'iOS',
    'Jenkins',
    'Version control',
    'Agile/Scrum',
    'JIRA',
    'Photoshop',
  ];

  final softSkills = [
    'Communication',
    'Problem solving',
    'Time management',
    'Flexibility',
    'Research',
    'Creativity',
    'Adaptability',
    'Work ethic',
    'Leadership',
  ];
}
