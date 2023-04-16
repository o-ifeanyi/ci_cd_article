import 'package:checklist_app/core/constants/constants.dart';
import 'package:checklist_app/model/checklist.dart';

final date = DateTime.now();

JsonMap get checkListDataFixture => {
      'id': 'id',
      'title': 'title',
      'updated_at': date.millisecondsSinceEpoch,
      'action': 'synched',
      'items': [checkListItemDataFixture],
    };

JsonMap get checkListItemDataFixture => {
      'id': 'id',
      'text': 'text',
      'done': true,
    };

ChecklistModel get checkListModelFixture => ChecklistModel(
      id: 'id',
      title: 'title',
      updatedAt: date,
      action: SyncAction.synched,
      items: [checkListItemModelFixture],
    );

ChecklistItemModel get checkListItemModelFixture => ChecklistItemModel(
      id: 'id',
      text: 'text',
      done: true,
    );
