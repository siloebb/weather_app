import 'dart:math';

enum ABTestVariant { variantA, variantB }

class LocalRemoteConfig {

  static late ABTestVariant variant;

  static setup(){
    variant = _getVariant();
  }

  static ABTestVariant _getVariant() {
    Random random = Random();
    return random.nextBool() ? ABTestVariant.variantA : ABTestVariant.variantB;
  }
}