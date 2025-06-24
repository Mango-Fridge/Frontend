import 'package:go_router/go_router.dart';
import 'package:mango/model/cook.dart';
import 'package:mango/model/refrigerator_item.dart';
import 'package:mango/providers/refrigerator_provider.dart';
import 'package:mango/view/cook/modal_view/add_cook_content_view.dart';
import 'package:mango/view/cook/widget/cook_view.dart';
import 'package:mango/view/cook/widget/add_cook_view.dart';
import 'package:mango/view/cook/widget/cook_detail_view.dart';
import 'package:mango/view/group/group_view.dart';
import 'package:mango/view/home/home_view.dart';
import 'package:mango/view/refrigerator/add_content_view.dart';
import 'package:mango/view/refrigerator/search_item_view.dart';
import 'package:mango/view/refrigerator/refrigerator_view.dart';
import 'package:mango/view/login/login_view.dart';
import 'package:mango/view/setting/nickname_edit_view.dart';
import 'package:mango/view/setting/setting_terms_view.dart';
import 'package:mango/view/setting/setting_view.dart';
import 'package:mango/view/splashView.dart';

// 라우터 관리(go_router)
final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true, // 라우팅 디버깅 로그 활성화
  routes: <RouteBase>[
    // 초기 화면
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    // 로그인 화면
    GoRoute(path: '/login', builder: (context, state) => const LoginView()),
    // 메인 화면
    // 2025-04-21 메인 == 냉장고 화면 통일
    GoRoute(
      path: '/home',
      builder: (context, state) => const RefrigeratorView(),
    ),
    // 냉장고 화면
    GoRoute(
      path: '/refrigerator',
      builder: (context, state) => const RefrigeratorView(),
    ),
    GoRoute(
      path: '/searchContent',
      builder: (context, state) => const SearchContentView(),
    ),
    GoRoute(
      path: '/addContent',
      builder: (context, state) {
        final item = state.extra as RefrigeratorItem?;
        return AddContentView(item: item);
      },
    ),
    // 그룹 화면
    GoRoute(path: '/group', builder: (context, state) => const GroupView()),
    // 요리 화면
    GoRoute(path: '/cook', builder: (context, state) => const CookView()),
    // 요리 제작 화면
    GoRoute(path: '/addCook', builder: (context, state) => const AddCookView()),
    // 요리 재 상세 화면
    // GoRoute(
    //   path: '/cookContentDetail',
    //   builder: (context, state) => const CookContentDetailView(),
    // ),
    GoRoute(
      path: '/cookDetail',
      builder: (context, state) {
        final cook = state.extra as Cook;
        return CookDetailView(cook: cook);
      },
    ),
    // 그룹 화면
    GoRoute(path: '/setting', builder: (context, state) => const SettingView()),
    // 설정 - 닉네임 변경
    GoRoute(
      path: '/editNickName',
      builder: (context, state) {
        return const NicknameEditView();
      },
    ),
    // 설정 - 약관 및 정책
    GoRoute(
      path: '/settingTerms',
      builder: (context, state) {
        return const SettingTermsView();
      },
    ),
  ],
);
