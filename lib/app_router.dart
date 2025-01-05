import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";
import "package:pondok/presentation/buku_santri/pages/buku_santri_page.dart";
import "package:pondok/presentation/calendar/pages/calendar_page.dart";
import "package:pondok/presentation/dakwah/pages/dakwah_page.dart";
import "package:pondok/presentation/home/pages/home_page.dart";
import "package:pondok/presentation/profile/pages/profile_page.dart";
import "package:pondok/presentation/qiblat/pages/qiblat_page.dart";
import "package:pondok/presentation/quran/pages/quran_page.dart";
import "package:pondok/presentation/setting/pages/setting_page.dart";
import "package:pondok/presentation/sholat/pages/sholat_page.dart";
import "package:pondok/presentation/sidafa/pages/sidafa_page.dart";
import "package:pondok/presentation/store/pages/store_page.dart";


GoRouter appRouter() {
  final parentKey = GlobalKey<NavigatorState>();
  final shellKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: parentKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => PersistentTabView.router(
          tabs: [
            PersistentRouterTabConfig(
              item: ItemConfig(
                icon: const Icon(Icons.home),
                title: "Home",
                activeForegroundColor: Theme.of(context).colorScheme.primary,
                inactiveForegroundColor:
                Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            PersistentRouterTabConfig(
              item: ItemConfig(
                icon: const Icon(Icons.menu_book_outlined),
                title: "Al-Qur'an",
                activeForegroundColor: Theme.of(context).colorScheme.primary,
                inactiveForegroundColor:
                Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            PersistentRouterTabConfig(
              item: ItemConfig(
                icon: const Icon(Icons.person_2),
                title: "Sidafa",
                activeForegroundColor: Theme.of(context).colorScheme.primary,
                inactiveForegroundColor:
                Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            PersistentRouterTabConfig(
              item: ItemConfig(
                icon: const Icon(Icons.calendar_today_outlined),
                title: "Kalender",
                activeForegroundColor: Theme.of(context).colorScheme.primary,
                inactiveForegroundColor:
                Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            PersistentRouterTabConfig(
              item: ItemConfig(
                icon: const Icon(Icons.settings),
                title: "Settings",
                activeForegroundColor: Theme.of(context).colorScheme.primary,
                inactiveForegroundColor:
                Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
          navBarBuilder: (navBarConfig) => Style4BottomNavBar(
            navBarConfig: navBarConfig,
            navBarDecoration: NavBarDecoration(
              color: Theme.of(context).colorScheme.surface,
              // border: const Border(
              //   top: BorderSide(color: Colors.grey, width: 0.5),
              // ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, -1),
                ),
              ],
            ),
          ),
          navigationShell: navigationShell,
        ),
        branches: [
          // The route branch for the 1st Tab
          StatefulShellBranch(
            navigatorKey: shellKey,
            routes: <RouteBase>[
              GoRoute(
                path: "/",
                builder: (context, state) => const HomePage(),
                routes: [
                  GoRoute(
                      parentNavigatorKey: parentKey,
                      path: "/sholat",
                      builder: (context, state) => const SholatPage()
                    // routes: [
                    //   GoRoute(
                    //     path: "super-detail",
                    //     builder: (context, state) => const MainScreen3(),
                    //   ),
                    // ],
                  ),
                  GoRoute(
                      parentNavigatorKey: parentKey,
                      path: "/dakwah",
                      builder: (context, state) => const DakwahPage()
                  ),
                  GoRoute(
                      parentNavigatorKey: parentKey,
                      path: "/buku-santri",
                      builder: (context, state) => const BukuSantriPage()
                  ),
                  GoRoute(
                      parentNavigatorKey: parentKey,
                      path: "/profile",
                      builder: (context, state) => const ProfilePage()
                  ),
                  GoRoute(
                      parentNavigatorKey: parentKey,
                      path: "/store",
                      builder: (context, state) => const StorePage()
                  ),
                  GoRoute(
                      parentNavigatorKey: parentKey,
                      path: "/qiblat",
                      builder: (context, state) => const QiblatPage()
                  ),
                ],
              ),
            ],
          ),
          // The route branch for 2nd Tab
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: "/quran",
                builder: (context, state) => const QuranPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                  path: "/sidafa",
                  builder: (context, state) => const SidafaPage()
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                  path: "/calendar",
                  builder: (context, state) => const CalendarPage()
              ),
            ],
          ),
          // The route branch for 3rd Tab
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                  path: "/settings",
                  builder: (context, state) => const SettingPage()
                // routes: [
                //   GoRoute(
                //     path: "/detail",
                //     builder: (context, state) => const MainScreen2(
                //       useRouter: true,
                //     ),
                //   )
                // ]
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
