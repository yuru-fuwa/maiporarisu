import 'package:flutter/material.dart';
import 'package:maiporarisu/ui/screens/setting_screen/component/setting_column.dart';
import 'package:maiporarisu/ui/screens/setting_screen/component/setting_item.dart';
import 'package:maiporarisu/ui/screens/setting_screen/component/setting_title.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SettingTitle(
                  icon: Icons.account_circle_rounded,
                  title: 'アカウント',
                ),
                SettingColumn(
                  children: [
                    const SettingItem(
                      navigate: null,
                      icon: Icons.email_rounded,
                      label: 'メールアドレス',
                      value: 'example@example.com',
                    ),
                    SettingItem(
                      navigate: () {},
                      icon: Icons.lock_reset_rounded,
                      label: 'パスワード変更',
                    ),
                    SettingItem(
                      navigate: () async {},
                      icon: Icons.logout_rounded,
                      label: 'ログアウト',
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const SettingTitle(
                  icon: Icons.help_outline_rounded,
                  title: 'ヘルプ',
                ),
                SettingColumn(
                  children: [
                    SettingItem(
                      navigate: () {},
                      icon: Icons.chat_bubble_rounded,
                      label: 'お問い合わせ',
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const SettingTitle(
                  icon: Icons.library_books_rounded,
                  title: '規約',
                ),
                SettingColumn(
                  children: [
                    SettingItem(
                      navigate: () {},
                      icon: Icons.gavel_rounded,
                      label: '利用規約',
                    ),
                    SettingItem(
                      navigate: () {},
                      icon: Icons.privacy_tip_rounded,
                      label: 'プライバシーポリシー',
                    ),
                    SettingItem(
                      navigate: () {},
                      icon: Icons.balance_rounded,
                      label: 'ライセンス',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  '© ${DateTime.now().year} yurufuwa',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
