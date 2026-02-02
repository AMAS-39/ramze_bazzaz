import 'package:app/core/shared/imports.dart';
import 'package:flutter/material.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class AppExpansionTile extends StatefulWidget {
  const AppExpansionTile({
    super.key,
    this.leading,
    required this.title,
    this.callback,
    this.backgroundColor = const Color(0XFFe6e0f9),
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.iconSize = 24,
    this.titlePadding = const EdgeInsets.all(20),
    this.initiallyExpanded = false,
    this.onHeaderClick = true,
    this.circularAvatar = false,
  });

  final Widget? leading;
  final Widget title;
  final bool Function()? callback;
  final double? iconSize;
  final EdgeInsetsGeometry titlePadding;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final Color? backgroundColor;
  final Widget? trailing;
  final bool initiallyExpanded;
  final bool onHeaderClick;
  final bool circularAvatar;
  @override
  AppExpansionTileState createState() => AppExpansionTileState();
}

class AppExpansionTileState extends State<AppExpansionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation easeOutAnimation;
  late CurvedAnimation _easeInAnimation;
  late ColorTween _borderColor;
  late ColorTween _headerColor;
  late ColorTween _iconColor;
  late ColorTween _backgroundColor;
  late Animation<double> _iconTurns;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    easeOutAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _easeInAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _borderColor = ColorTween();
    _headerColor = ColorTween();
    _iconColor = ColorTween();
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation);
    _backgroundColor = ColorTween();

    _isExpanded =
        PageStorage.of(context).readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void expand() {
    _setExpanded(true);
  }

  void collapse() {
    _setExpanded(false);
  }

  void toggle() {
    _setExpanded(!_isExpanded);
  }

  void _setExpanded(bool isExpanded) {
    if (widget.callback != null) {
      if (!widget.callback!()) {
        return;
      }
    }

    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
        if (_isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse().then<void>((void value) {
            setState(() {});
          });
        }
        PageStorage.of(context).writeState(context, _isExpanded);
      });
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged?.call(_isExpanded);
      }
    }
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BORDER_RADUIS),
          color: widget.backgroundColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: IconTheme.merge(
              data: IconThemeData(color: _iconColor.evaluate(_easeInAnimation)),
              child: InkWell(
                borderRadius: BorderRadius.circular(BORDER_RADUIS),

                onTap: widget.onHeaderClick ? toggle : null,
                // leading: widget.leading,
                // title: DefaultTextStyle(
                //   style: Theme.of(context)
                //       .textTheme
                //       .bodyLarge!
                //       .copyWith(color: titleColor),
                //   child: widget.title,
                // ),
                // trailing: InkWell(
                //   onTap: toggle,
                //   child: widget.trailing ??
                //       RotationTransition(
                //         turns: _iconTurns,
                //         child: Icon(Icons.expand_more,
                //             color: _isExpanded == true ? titleColor : null,
                //             size: (30)),
                //       ),
                // ),
                child: Padding(
                  padding: widget.titlePadding,
                  child: Row(
                    children: [
                      if (widget.leading != null) widget.leading!,
                      DefaultTextStyle(
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 16.sp),
                        child: widget.title,
                      ),
                      const Spacer(),
                      InkWell(
                        borderRadius: BorderRadius.circular(45),
                        onTap: toggle,
                        child: Container(
                          padding: widget.circularAvatar
                              ? const EdgeInsets.all(5)
                              : null,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.circularAvatar
                                  ? AppColor.i.borderColor
                                  : null),
                          child: widget.trailing ??
                              RotationTransition(
                                turns: _iconTurns,
                                child: Icon(Icons.expand_more,
                                    color: Colors.black,
                                    size: (widget.iconSize ?? 24)),
                              ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _easeInAnimation.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _borderColor.end = theme.dividerColor;
    _headerColor
      ..begin = theme.textTheme.bodyLarge?.color
      ..end = theme.colorScheme.secondary;
    _iconColor
      ..begin = theme.unselectedWidgetColor
      ..end = theme.colorScheme.secondary;
    _backgroundColor.end = widget.backgroundColor;

    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : SizedBox(
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: widget.children),
            ),
    );
  }
}
