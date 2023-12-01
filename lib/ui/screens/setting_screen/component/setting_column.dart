import 'package:flutter/material.dart';

class SettingColumn extends StatelessWidget {
  const SettingColumn({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: children.length,
        itemBuilder: (_, index) => children[index],
        separatorBuilder: (context, _) {
          return Divider(
            height: 1,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
          );
        },
      ),
    );
  }
}
