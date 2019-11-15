import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CustomSwipePagenation extends SwiperPlugin {
  /// dot style pagination
  static const SwiperPlugin dots = const DotSwiperPaginationBuilder(
      activeColor: Colors.black, color: Colors.white);

  /// fraction style pagination
  static const SwiperPlugin fraction = const FractionPaginationBuilder();

  static const SwiperPlugin rect = const RectSwiperPaginationBuilder();

  /// Alignment.bottomCenter by default when scrollDirection== Axis.horizontal
  /// Alignment.centerRight by default when scrollDirection== Axis.vertical
  final Alignment alignment;

  /// Distance between pagination and the container
  final EdgeInsetsGeometry margin;

  /// Build the widet
  final SwiperPlugin builder;

  final Key key;

  const CustomSwipePagenation(
      {this.alignment,
      this.key,
      this.margin: const EdgeInsets.all(10.0),
      this.builder: CustomSwipePagenation.dots});

  Widget build(BuildContext context, SwiperPluginConfig config) {
    Alignment alignment = this.alignment ??
        (config.scrollDirection == Axis.horizontal
            ? Alignment.bottomCenter
            : Alignment.centerRight);
    Widget child = Container(
      margin: margin,
      child: this.builder.build(context, config),
    );
    if (!config.outer) {
      child = new Align(
        key: key,
        alignment: alignment,
        child: child,
      );
    }
    return child;
  }
}
