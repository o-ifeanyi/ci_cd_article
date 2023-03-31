import 'package:checklist_app/core/util/config.dart';
import 'package:checklist_app/view/widget/auth_button.dart';
import 'package:flutter/material.dart';

class DeleteGuidelines extends StatelessWidget {
  const DeleteGuidelines({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      padding: Config.contentPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Config.yMargin(context, 2)),
          Text('Deleting your account would lead to the loss of:',
              style: Config.h3b(context)),
          SizedBox(height: Config.yMargin(context, 2)),
          const Point(
            text: 'Your account on all platforms.',
          ),
          SizedBox(height: Config.yMargin(context, 2)),
          const Point(
            text: 'All list you have created.',
          ),
          const Spacer(),
          Text('Note: This action might take a while',
              style: Config.b2(context)),
          SizedBox(height: Config.yMargin(context, 2)),
          AuthButton(
            key: const ValueKey('continue_delete_acc_button'),
            hPadding: 0,
            text: 'I understand',
            onpressed: () => Navigator.pop(context, true),
          ),
          SizedBox(height: Config.yMargin(context, 3)),
        ],
      ),
    );
  }
}

class Point extends StatelessWidget {
  final String text;
  final bool indent;
  const Point({Key? key, required this.text, this.indent = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (indent) const SizedBox(width: 16),
        const Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: const CircleAvatar(radius: 3),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: Config.b1(context),
          ),
        ),
      ],
    );
  }
}
