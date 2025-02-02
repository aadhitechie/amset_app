// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/// Simple align
enum SAlign {
  ///Left to Right
  LTR(Alignment.centerLeft, Alignment.centerRight),

  ///Right to Left
  RTL(Alignment.centerRight, Alignment.centerLeft),

  //Top to Bottom
  TTB(Alignment.topCenter, Alignment.bottomCenter),

  //Bottom to Top
  BTT(Alignment.bottomCenter, Alignment.topCenter);

  const SAlign(this.begin, this.end);
  final Alignment begin;
  final Alignment end;
Axis get orientation {
  switch (this) {
    case SAlign.TTB:
    case SAlign.BTT:
      return Axis.vertical;
    case SAlign.RTL:
    case SAlign.LTR:
      return Axis.horizontal;
    default:
      throw UnimplementedError('Unknown SAlign value');
  }
}

      
bool get isRevers {
  switch (this) {
    case SAlign.BTT:
    case SAlign.RTL:
      return true;
    default:
      return false;
  }
}


  Widget spaceBox(double? size) {
    return SizedBox(
      width: orientation == Axis.horizontal ? size ?? 10 : 0,
      height: orientation == Axis.vertical ? size ?? 5 : 0,
    );
  }
}

class SAlinUtils {
  SAlinUtils._();
  static Widget buildChildWithAlign(
      {required Widget w1,
      required Widget w2,
      required SAlign? childAlign,
      required double? childSpacing}) {
    childAlign ??= SAlign.LTR;
    var parent = childAlign.orientation == Axis.vertical ? Column.new : Row.new;
    var children = [
      w1,
      childAlign.spaceBox(childSpacing),
      w2,
    ];
    if (childAlign.isRevers) {
      children = children.reversed.toList();
    }
    Widget child = parent(mainAxisSize: MainAxisSize.min, children: children);
    return child;
  }
}
