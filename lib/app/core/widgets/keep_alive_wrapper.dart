import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class KeepAliveWrapper extends StatefulWidget {
  final Widget child;
  const KeepAliveWrapper({@required this.child});
  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(child: widget.child);
  }

  @override
  bool get wantKeepAlive => true;
}
