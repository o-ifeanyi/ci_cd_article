import 'package:checklist_app/core/platform_specific/platform_icons.dart';
import 'package:checklist_app/core/util/config.dart';
import 'package:checklist_app/model/checklist.dart';
import 'package:checklist_app/provider/checklist_provider.dart';
import 'package:checklist_app/view/widget/constrained_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChecklistScreen extends StatefulWidget {
  static const String route = '/checklist';
  const ChecklistScreen({super.key, this.checklist});

  final ChecklistModel? checklist;

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, FocusNode> _focus;
  late ChecklistModel checklist;
  late bool isUpdate;
  @override
  void initState() {
    super.initState();
    isUpdate = widget.checklist != null;
    if (isUpdate) {
      checklist = widget.checklist!;
    } else {
      checklist = ChecklistModel(
        id: const Uuid().v4(),
        title: 'title',
        updatedAt: DateTime.now(),
        items: [
          ChecklistItemModel(id: const Uuid().v4(), text: '', done: false)
        ],
      );
    }
    _focus = {};
    checklist.undone.forEach((item) {
      _focus[item.id] = FocusNode();
    });
  }

  void _addNewItem() {
    final items = checklist.items;
    final focus = FocusNode();
    final checklistItem = ChecklistItemModel(
      id: const Uuid().v4(),
      text: '',
      done: false,
    );
    items.add(checklistItem);
    _focus[checklistItem.id] = focus;
    checklist = checklist.copyWith(items: items);
    setState(() {});
    focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ChecklistProvider>();
    return WillPopScope(
      onWillPop: () {
        final validItems =
            checklist.items.where((item) => item.text.isNotEmpty).toList();
        checklist = checklist.copyWith(items: validItems);
        if (isUpdate)
          provider.update(checklist);
        else
          provider.create(checklist);
        return Future.value(true);
      },
      child: ConstrainedBoxWidget(
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            padding: Config.contentPadding(context),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: const ValueKey('title_field'),
                    initialValue: checklist.title,
                    autofocus: checklist.title == 'title',
                    style: Config.h2(context),
                    maxLines: null,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      errorStyle: Config.b2(context),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    onChanged: (val) {
                      checklist = checklist.copyWith(title: val.trim());
                    },
                    onFieldSubmitted: (_) =>
                        _focus[checklist.undone.first.id]?.requestFocus(),
                  ),
                  ...checklist.undone.map(
                    (item) {
                      return CheckboxListTile(
                        key: ValueKey('${item.id}'),
                        contentPadding: const EdgeInsets.all(0),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: TextFormField(
                          initialValue: item.text,
                          focusNode: _focus[item.id],
                          style: Config.b1(context),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {
                                final items = checklist.items..remove(item);
                                checklist = checklist.copyWith(items: items);
                                _focus.removeWhere((key, _) => key == item.id);
                                setState(() {});
                              },
                              icon: Icon(AppIcons.clear, size: 20),
                            ),
                          ),
                          onChanged: (val) {
                            final items = checklist.items;
                            final index = items.indexOf(item);
                            items.replaceRange(index, index + 1,
                                [item.copyWith(text: val.trim())]);
                            checklist = checklist.copyWith(items: items);
                          },
                          onFieldSubmitted: (_) => _addNewItem(),
                        ),
                        value: item.done,
                        onChanged: (val) {
                          if (val == null) return;
                          final items = checklist.items;
                          final index = items.indexOf(item);
                          items.replaceRange(
                              index, index + 1, [item.copyWith(done: val)]);
                          checklist = checklist.copyWith(items: items);
                          setState(() {});
                        },
                      );
                    },
                  ).toList(),
                  ListTile(
                    key: const ValueKey('add_new_item_button'),
                    contentPadding: const EdgeInsets.all(0),
                    onTap: _addNewItem,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(AppIcons.add),
                    ),
                    title: Text(
                      'Add item',
                      style: Config.b1(context),
                    ),
                  ),
                  if (checklist.done.isNotEmpty) ...[
                    const Divider(key: ValueKey('divider'), thickness: 1),
                    ...checklist.done.map(
                      (item) {
                        return CheckboxListTile(
                          key: ValueKey('${item.id}'),
                          activeColor: Theme.of(context).colorScheme.background,
                          contentPadding: const EdgeInsets.all(0),
                          controlAffinity: ListTileControlAffinity.leading,
                          title: TextFormField(
                            readOnly: true,
                            initialValue: item.text,
                            style: Config.b1(context).copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            onChanged: (_) {},
                          ),
                          value: item.done,
                          onChanged: (val) {
                            if (val == null) return;
                            final items = checklist.items;
                            final index = items.indexOf(item);
                            items.remove(item);
                            items.insert(index, item.copyWith(done: val));
                            checklist = checklist.copyWith(items: items);
                            setState(() {});
                          },
                        );
                      },
                    ).toList(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
