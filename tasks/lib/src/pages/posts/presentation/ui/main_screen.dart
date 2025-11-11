import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/src/core/utils/app_colors.dart';
import 'package:tasks/src/core/utils/app_text_theme.dart';
import 'package:tasks/src/core/utils/responsive.dart';
import 'package:tasks/src/pages/posts/presentation/controller/cubit/posts_screen_cubit.dart';
import 'package:tasks/src/pages/posts/presentation/controller/cubit/posts_screen_state.dart';
import 'package:tasks/src/pages/posts/presentation/ui/posts_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<_NavItem> _navItems = const [
    _NavItem('Trips', Icons.card_travel),
    _NavItem('Explore', Icons.explore),
    _NavItem('Messages', Icons.chat_bubble_outline),
    _NavItem('Settings', Icons.settings),
  ];

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    // Add navigation logic here if you have multiple screens (go_router, Navigator, etc.)
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: ResponsiveNavBar(),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 40),
            for (var item in ['Items', 'Pricing', 'Info', 'Tasks', 'Analytics'])
              ListTile(
                title: Text(item, style: const TextStyle(color: Colors.white)),
                onTap: () {},
              ),
          ],
        ),
      ),
      body: Row(
        children: [
          // if (isDesktop)
          //   SizedBox(
          //     width: 260,
          //     child: Container(
          //       color: Theme.of(context).colorScheme.surfaceVariant,
          //       child: SideNav(
          //         navItems: _navItems,
          //         selectedIndex: _selectedIndex,
          //         onTap: _onNavTap,
          //       ),
          //     ),
          //   ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<TripsCubit, TripsState>(
                builder: (context, state) {
                  // reuse the content widget that displays trips (extracted for clarity)
                  return HomeContent(state: state);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResponsiveNavBar extends StatefulWidget implements PreferredSizeWidget {
  const ResponsiveNavBar({super.key});

  @override
  State<ResponsiveNavBar> createState() => _ResponsiveNavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _ResponsiveNavBarState extends State<ResponsiveNavBar> {
  int selectedIndex = 0;

  final List<String> menuItems = [
    'Items',
    'Pricing',
    'Info',
    'Tasks',
    'Analytics',
  ];

  bool get isMobile => MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Section
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          Image.asset('assets/images/Vector.png'),
          // Center Menu (hide on mobile)
          if (!isMobile) ...[
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(menuItems.length, (index) {
                final active = index == selectedIndex;
                return InkWell(
                  onTap: () => setState(() => selectedIndex = index),
                  hoverColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          menuItems[index],
                          style: TextStyle(
                            color: Colors.white.withOpacity(active ? 1.0 : 0.7),
                            fontSize: 15,
                            fontWeight: active
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (active)
                          Container(
                            height: 2,
                            width: 30,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFC266),
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
          if (!isMobile) ...[
            const SizedBox(width: 16),
            Container(width: 1, height: 20, color: Colors.white24),
            const SizedBox(width: 16),
          ],
          if (isMobile) ...[Spacer()],

          // Right Section
          Row(
            children: [
              const Icon(Icons.settings, color: Colors.white, size: 22),
              const SizedBox(width: 16),
              const Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 22,
              ),
              const SizedBox(width: 16),
              Container(width: 1, height: 20, color: Colors.white24),
              const SizedBox(width: 16),
              const CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/32.jpg',
                ),
              ),
              if (!isMobile) ...[
                const SizedBox(width: 8),
                const Text(
                  'John Doe',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  const _NavItem(this.label, this.icon);
}

class SideNav extends StatelessWidget {
  final List<_NavItem> navItems;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const SideNav({
    Key? key,
    required this.navItems,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Logo / App Name stub
              const FlutterLogo(size: 36),
              const SizedBox(width: 12),
              Text(
                'Travel Dashboard',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              final item = navItems[index];
              final selected = index == selectedIndex;
              return ListTile(
                leading: Icon(
                  item.icon,
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                title: Text(
                  item.label,
                  style: AppTheme.bodyLargeSemiboldTextStyle.copyWith(
                    color: AppColors.white,
                  ),
                ),
                selected: selected,
                onTap: () => onTap(index),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                horizontalTitleGap: 8,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemCount: navItems.length,
          ),
        ),
        const SizedBox(height: 12),
        // Footer
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(child: Text('U')), // replace with real user avatar
              const SizedBox(width: 8),
              Expanded(
                child: Text('Hi, User', overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
