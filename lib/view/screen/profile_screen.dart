import 'package:checklist_app/core/platform_specific/platform_icons.dart';
import 'package:checklist_app/core/services/hive_service.dart';
import 'package:checklist_app/core/util/config.dart';
import 'package:checklist_app/core/util/themes.dart';
import 'package:checklist_app/injection_container.dart';
import 'package:checklist_app/provider/checklist_provider.dart';
import 'package:checklist_app/view/screen/privacy_policy.dart';
import 'package:checklist_app/view/screen/terms_condition.dart';
import 'package:checklist_app/view/widget/constrained_box.dart';
import 'package:checklist_app/view/widget/custom_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ChecklistProvider _checklistProvider;
  late ThemeOptions _selectedTheme;

  @override
  void initState() {
    super.initState();
    _checklistProvider = context.read<ChecklistProvider>();
    _selectedTheme = _checklistProvider.currentTheme;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBoxWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My account', style: Config.h2(context)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Config.yMargin(context, 2)),
            Expanded(
              child: ListView(
                padding: Config.contentPadding(context),
                children: [
                  CustomListTile(
                    iconData: AppIcons.terms,
                    title: 'Terms of service',
                    onPressed: () => context.push(TermsAndConditions.route),
                  ),
                  CustomListTile(
                    iconData: AppIcons.privacy,
                    title: 'Privacy policy',
                    onPressed: () => context.push(PrivacyPolicy.route),
                  ),
                  SizedBox(height: Config.yMargin(context, 1)),
                  CupertinoSlidingSegmentedControl<ThemeOptions>(
                    groupValue: _selectedTheme,
                    thumbColor: theme.colorScheme.background,
                    backgroundColor: theme.colorScheme.secondary,
                    padding: Config.contentPadding(context, h: 3, v: 1),
                    children: {
                      ThemeOptions.light: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text('Light', style: Config.b1(context)),
                      ),
                      ThemeOptions.dark:
                          Text('Dark', style: Config.b1(context)),
                      ThemeOptions.system:
                          Text('System', style: Config.b1(context)),
                    },
                    onValueChanged: (option) {
                      if (option != null)
                        setState(() {
                          _selectedTheme = option;
                        });
                      _checklistProvider.currentTheme = _selectedTheme;
                      sl<HiveService>().setTheme(_selectedTheme);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
