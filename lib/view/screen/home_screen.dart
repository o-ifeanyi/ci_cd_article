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
              Padding(
                padding: Config.contentPadding(h: 15, v: 10),
                child: _provider.marked.isNotEmpty
                    ? Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.all(0),
                              controlAffinity: ListTileControlAffinity.leading,
                              checkboxShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              title: Text(
                                'Select all  (${_provider.marked.length})',
                                style: Config.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
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
                              style: Config.textTheme.bodyMedium,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                prefixIcon: Icon(AppIcons.search),
                                errorStyle: Config.textTheme.bodySmall,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
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
                                size: Config.y(60),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Nothing to see here',
                                style: Config.textTheme.titleMedium,
                              ),
                              Config.vGap20,
                            ],
                          ),
                        )
                      : MasonryGridView.builder(
                          padding: Config.contentPadding(h: 15, v: 15),
                          itemCount: checklists.length,
                          gridDelegate:
                              SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: Config.x(200),
                          ),
                          crossAxisSpacing: Config.x(15),
                          mainAxisSpacing: Config.x(15),
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
          backgroundColor: Theme.of(context).colorScheme.outline,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          key: const ValueKey('add_button'),
          child: Icon(AppIcons.add, size: 40),
          onPressed: () => context.push(ChecklistScreen.route),
          shape: const CircleBorder(),
        ),
      ),
    );
  }
}
