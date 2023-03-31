import 'package:checklist_app/core/constants/constants.dart';
import 'package:checklist_app/core/platform_specific/platform_icons.dart';
import 'package:checklist_app/core/util/config.dart';
import 'package:checklist_app/core/util/debouncer.dart';
import 'package:checklist_app/model/checklist.dart';
import 'package:checklist_app/provider/checklist_provider.dart';
import 'package:checklist_app/view/screen/checklist_screen.dart';
import 'package:checklist_app/view/screen/profile_screen.dart';
import 'package:checklist_app/view/widget/checklist_item.dart';
import 'package:checklist_app/view/widget/constrained_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ChecklistProvider _provider;
  late ValueListenable<Box<dynamic>> _checklistBox;
  List<ChecklistModel> checklists = [];
  bool _markAll = false;
  final _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();
    _provider = context.read<ChecklistProvider>();
    _checklistBox = Hive.box(kHiveBoxes.checklist.name).listenable();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider.getAll().then((_) => checklists = _provider.allChecklist);
      _checklistBox.addListener(() {
        _provider.getAll().then((_) => checklists = _provider.allChecklist);
      });
    });
  }

  @override
  void dispose() {
    _checklistBox.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<ChecklistProvider>();
    final _checklists = _provider.allChecklist;
    return ConstrainedBoxWidget(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _provider.checkState == CheckState.idle
                  ? const SizedBox(height: 2)
                  : const LinearProgressIndicator(minHeight: 2),
              Container(
                height: Config.yMargin(context, 11),
                padding: Config.contentPadding(context),
                child: _provider.marked.isNotEmpty
                    ? Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.all(0),
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                'Select all  (${_provider.marked.length})',
                                style: Config.b1b(context),
                                overflow: TextOverflow.ellipsis,
                              ),
                              value: _markAll,
                              onChanged: (val) {
                                if (val == null) return;
                                _markAll = val;
                                _provider.markAll(val);
                              },
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            key: const ValueKey('delete_button'),
                            onTap: () {
                              _provider.delete(_provider.marked).then((sucess) {
                                _provider.markAll(false);
                              });
                            },
                            child: Icon(
                              AppIcons.delete,
                            ),
                          )
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              key: const ValueKey('search_field'),
                              keyboardType: TextInputType.emailAddress,
                              style: Config.b1(context),
                              decoration: InputDecoration(
                                hintText: 'Search',
                                prefixIcon: Icon(AppIcons.search),
                                errorStyle: Config.b2(context),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              onChanged: (val) {
                                _debouncer(() {
                                  setState(() {
                                    checklists = _checklists
                                        .where((checklist) =>
                                            checklist.title
                                                .toLowerCase()
                                                .contains(val.toLowerCase()) ||
                                            checklist.items.any((item) => item
                                                .text
                                                .toLowerCase()
                                                .contains(val.toLowerCase())))
                                        .toList();
                                  });
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            key: const ValueKey('profile_button'),
                            onTap: () => context.push(ProfileScreen.route),
                            child: Icon(
                              AppIcons.setting,
                              size: 30,
                            ),
                          )
                        ],
                      ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await _provider.getAll();
                    return;
                  },
                  child: checklists.isEmpty
                      ? Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                AppIcons.note,
                                size: Config.yMargin(context, 8),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Nothing to see here',
                                style: Config.h2(context),
                              ),
                              SizedBox(height: Config.yMargin(context, 10))
                            ],
                          ),
                        )
                      : MasonryGridView.builder(
                          padding: Config.contentPadding(context),
                          itemCount: checklists.length,
                          gridDelegate:
                              SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: Config.xMargin(context, 70),
                          ),
                          crossAxisSpacing: Config.xMargin(context, 3),
                          mainAxisSpacing: Config.yMargin(context, 2),
                          itemBuilder: (context, index) {
                            final checklist = checklists[index];
                            return ChecklistItem(checklist: checklist);
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: const ValueKey('add_button'),
          child: Icon(AppIcons.add, size: 40),
          onPressed: () => context.push(ChecklistScreen.route),
        ),
      ),
    );
  }
}
