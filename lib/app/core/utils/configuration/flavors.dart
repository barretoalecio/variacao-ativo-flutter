enum FlavorOption { development, production }

class F {
  static FlavorOption? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case FlavorOption.development:
        return 'Variacao Ativo Development';
      case FlavorOption.production:
        return 'Variacao Ativo';
      default:
        return '';
    }
  }
}
