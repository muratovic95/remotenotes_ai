import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String)? onSearchChanged;
  final VoidCallback? onFilterTap;
  final bool isCollapsed;

  const SearchBarWidget({
    Key? key,
    this.onSearchChanged,
    this.onFilterTap,
    this.isCollapsed = false,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _searchController.addListener(() {
      widget.onSearchChanged?.call(_searchController.text);
    });
  }

  @override
  void didUpdateWidget(SearchBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCollapsed != oldWidget.isCollapsed) {
      if (widget.isCollapsed && _isExpanded) {
        _animationController.forward();
        _isExpanded = false;
      } else if (!widget.isCollapsed && !_isExpanded) {
        _animationController.reverse();
        _isExpanded = true;
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return SizeTransition(
          sizeFactor: Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).animate(_heightAnimation),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme
                          .lightTheme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.2),
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search meetings...',
                        hintStyle:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme
                              .lightTheme.colorScheme.onSurfaceVariant
                              .withValues(alpha: 0.6),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: CustomIconWidget(
                            iconName: 'search',
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  widget.onSearchChanged?.call('');
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(3.w),
                                  child: CustomIconWidget(
                                    iconName: 'clear',
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                    size: 20,
                                  ),
                                ),
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 2.h,
                        ),
                      ),
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                      onChanged: (value) {
                        setState(() {});
                        widget.onSearchChanged?.call(value);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                GestureDetector(
                  onTap: widget.onFilterTap,
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: CustomIconWidget(
                      iconName: 'filter_list',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
