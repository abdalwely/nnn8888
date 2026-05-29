import 'dart:ui';

import 'package:flutter/material.dart';

/// Bottom Navigation Bar فاخر عائم مع blur و indicators متحركة.
class ModernBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavItem> items;

  const ModernBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: scheme.shadow.withOpacity(isDark ? .28 : .14),
              blurRadius: 34,
              offset: const Offset(0, 18),
            ),
            BoxShadow(
              color: scheme.primary.withOpacity(isDark ? .18 : .10),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
            child: Container(
              height: 74,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: scheme.surface.withOpacity(isDark ? .72 : .86),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: scheme.outlineVariant.withOpacity(isDark ? .22 : .38),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    scheme.surface.withOpacity(isDark ? .78 : .94),
                    scheme.primaryContainer.withOpacity(isDark ? .12 : .22),
                  ],
                ),
              ),
              child: Row(
                children: List.generate(
                  items.length,
                  (index) => Expanded(
                    child: _NavPill(
                      item: items[index],
                      isActive: index == currentIndex,
                      onTap: () => onTap(index),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavPill extends StatelessWidget {
  final BottomNavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavPill({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final activeColor = scheme.primary;
    final inactiveColor = scheme.onSurfaceVariant;

    return Semantics(
      selected: isActive,
      button: true,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 360),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: isActive
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      activeColor.withOpacity(.18),
                      activeColor.withOpacity(.08),
                    ],
                  )
                : null,
            border: Border.all(
              color: isActive
                  ? activeColor.withOpacity(.26)
                  : Colors.transparent,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: isActive ? 1.08 : 1,
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutBack,
                child: Icon(
                  item.icon,
                  color: isActive ? activeColor : inactiveColor.withOpacity(.78),
                  size: isActive ? 25 : 23,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 260),
                style: theme.textTheme.labelSmall!.copyWith(
                  color: isActive ? activeColor : inactiveColor.withOpacity(.78),
                  fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
                  fontSize: isActive ? 11 : 10,
                ),
                child: Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                width: isActive ? 22 : 4,
                height: 3,
                decoration: BoxDecoration(
                  color: isActive ? activeColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavItem {
  final String label;
  final IconData icon;

  const BottomNavItem({
    required this.label,
    required this.icon,
  });
}

class AdvancedBottomNavBar extends ModernBottomNavBar {
  const AdvancedBottomNavBar({
    super.key,
    required super.currentIndex,
    required super.onTap,
    required super.items,
  });
}

class SimpleBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavItem> items;

  const SimpleBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) => ModernBottomNavBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: items,
      );
}
