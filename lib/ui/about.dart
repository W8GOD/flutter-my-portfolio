import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colours.dart';
import 'package:my_portfolio/constants/fonts.dart';
import 'package:my_portfolio/constants/strings.dart';
import 'package:my_portfolio/constants/text_styles.dart';
import 'package:my_portfolio/models/education.dart';
import 'package:my_portfolio/models/page_type.dart';
import 'package:my_portfolio/models/work_experience.dart';
import 'package:my_portfolio/ui/navigation_actions.dart';
import 'package:my_portfolio/utils/screen/screen_util.dart';
import 'package:my_portfolio/widgets/responsive_widget.dart';

class AboutPage extends NavigationActions {
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
          appBar: buildAppBar(context, _drawerKey, PageType.about)
              as PreferredSizeWidget,
          drawer: buildDrawer(context, PageType.about),
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
    return SelectableText(
      Strings.introduce_full_name,
      style: TextStyles.body.copyWith(
        fontFamily: Fonts.quicksand_bold,
        fontSize: ResponsiveWidget.isSmallScreen(context) ? 18 : 22.0,
      ),
    );
  }

  Widget _buildSummarySingleColumns(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSummaryItem(context, Strings.summary),
      ],
    );
  }

  Widget _buildSummaryMultipleColumns(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
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
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SelectableText(
          summary,
          style: TextStyles.body.copyWith(
            fontSize: ResponsiveWidget.isSmallScreen(context) ? 14 : 16.0,
          ),
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
            text: Strings.about,
            style: TextStyles.heading.copyWith(
              fontFamily: Fonts.quicksand_bold,
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
          TextSpan(
            text: Strings.me,
            style: TextStyles.heading.copyWith(
              color: Color(0xFF50AFC0),
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
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
      style: TextStyles.sub_heading,
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
              color: Color(0xFF45405B),
            ),
          ),
          SelectableText(
            '${education.from}-${education.to}',
            style: TextStyles.body,
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
      style: TextStyles.sub_heading,
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
          SelectableText(
            '${workExperience.post}',
            style: TextStyles.company,
          ),
          SelectableText(
            '${workExperience.organization}',
            style: TextStyles.body.copyWith(
              color: Color(0xFF45405B),
            ),
          ),
          SelectableText(
            '${workExperience.from}-${workExperience.to}',
            style: TextStyles.body,
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
      label: SelectableText(
        label,
        style: TextStyles.chip.copyWith(
          fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.0 : 11.0,
        ),
      ),
    );
  }

  Widget _buildTechnicalSkillsContainerHeading() {
    return SelectableText(
      Strings.technical_skills,
      style: TextStyles.sub_heading,
    );
  }

  Widget _buildSoftSkillsContainerHeading() {
    return SelectableText(
      Strings.soft_skills,
      style: TextStyles.sub_heading,
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
    WorkExperience(
      'Jun 2017',
      'Nov 2017',
      'Geotalent., Co. Ltd.',
      'Programmer (Android/iOS Developer)',
    ),
    WorkExperience(
      'Nov 2017',
      'Jul 2019',
      'True Digital Group., Co. Ltd.',
      'Programmer (Android)',
    ),
    WorkExperience(
      'Aug 2019',
      'Present',
      'Amity Corporation (HQ)',
      'Android Engineer',
    ),
  ];

  final technicalSkills = [
    'Kotlin',
    'Java',
    'Unit Test JUnit/Mockito',
    'Objective-C',
    'Swift',
    'Dart',
    'MVC',
    'MVP',
    'MVVM',
    'Clean Architecture',
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
