import 'package:checklist_app/core/util/config.dart';
import 'package:checklist_app/model/checklist.dart';
import 'package:checklist_app/provider/checklist_provider.dart';
import 'package:checklist_app/view/screen/checklist_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChecklistItem extends StatelessWidget {
  const ChecklistItem({
    Key? key,
    required this.checklist,
  }) : super(key: key);

  final ChecklistModel checklist;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChecklistProvider>();
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        if (provider.marked.isNotEmpty) {
          provider.updateMarked(checklist);
          return;
        }
        context.push(ChecklistScreen.route, extra: checklist);
      },
      onLongPress: () {
        provider.updateMarked(checklist);
      },
      child: Container(
        padding: Config.contentPadding(h: 15, v: 8),
        decoration: BoxDecoration(
          border: Border.all(
            width: provider.marked.contains(checklist) ? 2 : 1,
            color: provider.marked.contains(checklist)
                ? theme.colorScheme.secondary
                : theme.colorScheme.onPrimary.withOpacity(0.6),
          ),
          borderRadius: BorderRadius.circular(12),
          color: theme.colorScheme.surfaceVariant,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              checklist.title,
              overflow: TextOverflow.ellipsis,
              style: Config.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Config.vGap10,
            ...checklist.undone
                .take(4)
                .map(
                  (e) => CheckboxListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    controlAffinity: ListTileControlAffinity.leading,
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    title: Text(
                      e.text,
                      style: Config.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    value: false,
                    onChanged: null,
                  ),
                )
                .toList(),
            if (checklist.undone.length > 4) ...[
              Config.vGap10,
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.colorScheme.outline,
                ),
                child: Text(
                  '+ ${checklist.undone.length - 4} more',
                  overflow: TextOverflow.ellipsis,
                  style: Config.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
