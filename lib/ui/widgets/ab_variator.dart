
import 'package:flutter/material.dart';
import 'package:weather_app/services/remote_config_service.dart';

class AbVariator extends StatelessWidget {

  final Widget widgetA;
  final Widget widgetB;

  const AbVariator({super.key, required this.widgetA, required this.widgetB});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(LocalRemoteConfig.variant == ABTestVariant.variantA) widgetA,
        widgetB,
        if(LocalRemoteConfig.variant == ABTestVariant.variantB) widgetA,
      ],
    );
  }
}
