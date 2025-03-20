import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mango/model/NavItem.dart';
import 'package:mango/model/login/auth_model.dart';
import 'package:mango/providers/login_auth_provider.dart';
import 'package:mango/view/group/group_view.dart';
import 'package:mango/view/login/terms_overlay.dart';
import 'package:mango/view/refrigerator/refrigerator_view.dart';
import 'package:mango/view/setting/setting_view.dart';

// 메인화면
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with SingleTickerProviderStateMixin {
  AuthInfo? get user => ref.watch(loginAuthProvider);
  late TabController _tabController;
  int _index = 0;

  static const List<NavItem> _navItems = <NavItem>[
    NavItem(activeIcon: Icons.home, label: '홈'),
    NavItem(activeIcon: Icons.group, label: '그룹'),
    NavItem(activeIcon: Icons.settings, label: '설정'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _navItems.length, vsync: this);
    _tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(tabListener);
    _tabController.dispose();
    super.dispose();
  }

  void tabListener() {
    setState(() {
      _index = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(), // 스와이프 금지
            controller: _tabController,
            children: const <Widget>[
              RefrigeratorView(), // 냉장고
              GroupView(), // 그룹
              SettingView(), // 설정
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              _tabController.animateTo(index);
            },
            currentIndex: _index,
            items:
                _navItems.map((NavItem item) {
                  return BottomNavigationBarItem(
                    icon: Icon(item.activeIcon),
                    label: item.label,
                  );
                }).toList(),
          ),
        ),
        _buildTermsOverlay(), // 약관 동의
      ],
    );
  }

  // TermsOverlay 표시 여부를 결정하는 메소드
  Widget _buildTermsOverlay() {
    // 유저가 없으면 화면을 띄우지 않음.
    if (user == null) return const SizedBox.shrink();

    // 유저가 동의를 하지 않았을 때,
    if (!user!.agreePrivacyPolicy!) {
      return const TermsOverlay(
        key: ValueKey('privacyPolicy'),
        termsType: 'privacy policy',
      );
    }
    // 유저가 동의를 하지 않았을 때,
    if (!user!.agreeTermsOfService!) {
      return const TermsOverlay(key: ValueKey('terms'), termsType: 'terms');
    }

    // 유저가 모든 동의를 했을경우, 화면을 띄우지 않음.
    return const SizedBox.shrink();
  }
}
