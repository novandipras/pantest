import 'package:flutter/material.dart';

class KeepAliveWidget extends StatefulWidget {
  final Widget child;
  final bool wantKeepAlive;
  const KeepAliveWidget({
    super.key,
    required this.child,
    this.wantKeepAlive = true,
  });

  @override
  State<KeepAliveWidget> createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget> with AutomaticKeepAliveClientMixin<KeepAliveWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;
}
