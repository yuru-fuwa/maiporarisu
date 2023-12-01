import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    this.navigate,
    this.icon,
    required this.label,
    this.value,
    this.description,
  });

  final void Function()? navigate;
  final IconData? icon;
  final String label;
  final String? value;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: navigate,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
          constraints: const BoxConstraints(minHeight: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          color: navigate != null && value == null
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.7)
                              : Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.4),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        label,
                        style: navigate != null && value == null
                            ? TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.6),
                              ),
                      ),
                    ],
                  ),
                  if (value != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          value!,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: navigate == null
                                ? Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.5)
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              if (description != null) ...[
                const SizedBox(height: 8),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: icon == null ? 8 : 32),
                  child: Text(
                    description!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.4),
                        ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
