import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  static const String ID = 'dashboardScreen';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bgAnim;

  Future<void> _onRefresh() async {
    // TODO: wire to real data
    await Future<void>.delayed(const Duration(milliseconds: 600));
  }

  @override
  void initState() {
    super.initState();
    _bgAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat();
  }

  @override
  void dispose() {
    _bgAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.kantumruyProTextTheme(
      Theme.of(context).textTheme,
    );

    return Scaffold(
      body: Stack(
        children: [
          // Soft animated gradient background (colorful but subtle)
          AnimatedBuilder(
            animation: _bgAnim,
            builder: (context, _) {
              final t = _bgAnim.value;
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1 + t, -0.8),
                    end: Alignment(1 - t, 0.9),
                    colors: const [
                      Color(0xFFFDE68A), // amber
                      Color(0xFFA7F3D0), // mint
                      Color(0xFFBFDBFE), // sky
                      Color(0xFFFBCFE8), // pink
                    ],
                  ),
                ),
              );
            },
          ),

          // Content with scroll
          RefreshIndicator(
            onRefresh: _onRefresh,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // Top AppBar replacement
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.white.withOpacity(0.85),
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  titleSpacing: 16,
                  title: Text(
                    'Welcome back, Admin 🌈',
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.search),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.bell),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),

                // Colorful horizontal stat strip
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 140,
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      scrollDirection: Axis.horizontal,
                      children: const [
                        _GradientStatPill(
                          title: 'Total Users',
                          value: '1,230',
                          icon: CupertinoIcons.person_2_fill,
                          colors: [Color(0xFF60A5FA), Color(0xFF2563EB)],
                        ),
                        _GradientStatPill(
                          title: 'Products Sold',
                          value: '865',
                          icon: CupertinoIcons.bag_fill,
                          colors: [Color(0xFFFCA5A5), Color(0xFFF43F5E)],
                        ),
                        _GradientStatPill(
                          title: 'Payments',
                          value: '\$12.4K',
                          icon: CupertinoIcons.money_dollar_circle_fill,
                          colors: [Color(0xFFA7F3D0), Color(0xFF10B981)],
                        ),
                        _GradientStatPill(
                          title: 'Money Earned',
                          value: '\$18.9K',
                          icon: CupertinoIcons.chart_bar_alt_fill,
                          colors: [Color(0xFFFDE68A), Color(0xFFF59E0B)],
                        ),
                      ],
                    ),
                  ),
                ),

                // Colorful grid cards (auto-wrap)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final w = constraints.crossAxisExtent;
                      final crossAxisCount = w > 1000 ? 4 : (w > 680 ? 2 : 1);

                      final items = const [
                        _MetricCard(
                          title: 'Active Subs',
                          value: '742',
                          sub: '+4.1% WoW',
                          icon: CupertinoIcons.heart_fill,
                          colors: [Color(0xFFDDD6FE), Color(0xFF8B5CF6)],
                        ),
                        _MetricCard(
                          title: 'Refund Rate',
                          value: '1.7%',
                          sub: '-0.3% MoM',
                          icon: CupertinoIcons.arrow_branch,
                          colors: [Color(0xFFBAE6FD), Color(0xFF0EA5E9)],
                        ),
                        _MetricCard(
                          title: 'Avg. Order',
                          value: '\$21.30',
                          sub: '+\$0.80',
                          icon: CupertinoIcons.cart_fill,
                          colors: [Color(0xFFFBCFE8), Color(0xFFEC4899)],
                        ),
                        _MetricCard(
                          title: 'Tickets',
                          value: '63',
                          sub: '12 open',
                          icon: CupertinoIcons.chat_bubble_2_fill,
                          colors: [Color(0xFFBBF7D0), Color(0xFF22C55E)],
                        ),
                      ];

                      return SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => items[i],
                          childCount: items.length,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 2.2,
                        ),
                      );
                    },
                  ),
                ),

                // Recent Activity header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _RainbowTitle(text: 'Recent Activity'),
                          const SizedBox(width: 16),
                          _CategoryChip(
                            label: 'All',
                            icon: CupertinoIcons.square_grid_2x2,
                            color: const Color(0xFF0284C7),
                          ),
                          const SizedBox(width: 8),
                          _CategoryChip(
                            label: 'Orders',
                            icon: CupertinoIcons.cube_box_fill,
                            color: const Color(0xFFF59E0B),
                          ),
                          const SizedBox(width: 8),
                          _CategoryChip(
                            label: 'Users',
                            icon: CupertinoIcons.person_crop_circle_fill,
                            color: const Color(0xFF10B981),
                          ),
                          const SizedBox(width: 8),
                          _CategoryChip(
                            label: 'Payments',
                            icon: CupertinoIcons.money_dollar,
                            color: const Color(0xFF6366F1),
                          ),
                          const SizedBox(width: 8),
                          _CategoryChip(
                            label: 'Reviews',
                            icon: CupertinoIcons.star_fill,
                            color: const Color(0xFFEC4899),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Recent Activity list (vertical)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.list(
                    children: const [
                      _ActivityTile(
                        name: 'John Doe',
                        action: 'Placed an order',
                        date: '2025-07-20',
                        dotColor: Color(0xFF60A5FA),
                      ),
                      _ActivityTile(
                        name: 'Jane Smith',
                        action: 'Registered',
                        date: '2025-07-19',
                        dotColor: Color(0xFF10B981),
                      ),
                      _ActivityTile(
                        name: 'Alice Johnson',
                        action: 'Left a review',
                        date: '2025-07-18',
                        dotColor: Color(0xFFF43F5E),
                      ),
                      _ActivityTile(
                        name: 'Daniel Park',
                        action: 'Updated payment method',
                        date: '2025-07-18',
                        dotColor: Color(0xFF8B5CF6),
                      ),
                      _ActivityTile(
                        name: 'Maria Garcia',
                        action: 'Placed an order',
                        date: '2025-07-17',
                        dotColor: Color(0xFFF59E0B),
                      ),
                      SizedBox(height: 28),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(CupertinoIcons.add),
        label: const Text('New'),
      ),
    );
  }
}

/// ───────────────────── Widgets ─────────────────────

class _GradientStatPill extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final List<Color> colors;

  const _GradientStatPill({
    required this.title,
    required this.value,
    required this.icon,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.kantumruyProTextTheme(
      Theme.of(context).textTheme,
    );

    return Container(
      width: 230,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          _CircleIcon(icon: icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelLarge!.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String sub;
  final IconData icon;
  final List<Color> colors;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.sub,
    required this.icon,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.kantumruyProTextTheme(
      Theme.of(context).textTheme,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // base card
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Stack(
        children: [
          // colorful border accent
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    colors: colors.map((c) => c.withOpacity(0.10)).toList(),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              _ColorBadge(colors: colors, icon: icon),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.labelLarge!.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      value,
                      style: textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sub,
                      style: textTheme.bodySmall!.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              // playful progress arc
              CustomPaint(
                size: const Size(54, 54),
                painter: _ArcPainter(colors: colors),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final String name;
  final String action;
  final String date;
  final Color dotColor;

  const _ActivityTile({
    required this.name,
    required this.action,
    required this.date,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.kantumruyProTextTheme(
      Theme.of(context).textTheme,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          _InitialsAvatar(name: name, tint: dotColor),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: textTheme.bodyMedium!.copyWith(color: Colors.black87),
                children: [
                  TextSpan(
                    text: name,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const TextSpan(text: '  •  '),
                  TextSpan(text: action),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                date,
                style: textTheme.bodySmall!.copyWith(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RainbowTitle extends StatelessWidget {
  final String text;
  const _RainbowTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.kantumruyPro(
      fontSize: 18,
      fontWeight: FontWeight.w900,
      letterSpacing: .2,
    );

    return ShaderMask(
      shaderCallback: (rect) => const LinearGradient(
        colors: [
          Color(0xFFEF4444),
          Color(0xFFF59E0B),
          Color(0xFF10B981),
          Color(0xFF3B82F6),
          Color(0xFF8B5CF6),
        ],
      ).createShader(rect),
      child: Text(text, style: style.copyWith(color: Colors.white)),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: color,
        child: Icon(icon, size: 14, color: Colors.white),
      ),
      label: Text(
        label,
        style: GoogleFonts.kantumruyPro(fontWeight: FontWeight.w700),
      ),
      backgroundColor: color.withOpacity(0.12),
      side: BorderSide(color: color.withOpacity(0.5)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  const _CircleIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white24,
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}

class _ColorBadge extends StatelessWidget {
  final List<Color> colors;
  final IconData icon;
  const _ColorBadge({required this.colors, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final List<Color> colors;
  _ArcPainter({required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(colors: colors).createShader(rect);

    final bg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..color = Colors.black12;

    // background arc
    canvas.drawArc(
      Rect.fromLTWH(3, 3, size.width - 6, size.height - 6),
      0,
      math.pi * 2,
      false,
      bg,
    );
    // colorful arc (70%)
    canvas.drawArc(
      Rect.fromLTWH(3, 3, size.width - 6, size.height - 6),
      -math.pi / 2,
      math.pi * 1.4,
      false,
      stroke,
    );
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) => false;
}

class _InitialsAvatar extends StatelessWidget {
  final String name;
  final Color tint;
  const _InitialsAvatar({required this.name, required this.tint});

  @override
  Widget build(BuildContext context) {
    final initials = _initials(name);
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tint.withOpacity(.15), tint.withOpacity(.45)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        initials,
        style: GoogleFonts.kantumruyPro(
          fontWeight: FontWeight.w900,
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }

  String _initials(String n) {
    final parts = n.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return (parts.first.characters.first + parts.last.characters.first)
        .toUpperCase();
  }
}
