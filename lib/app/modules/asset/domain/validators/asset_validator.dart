abstract class AssetValidator {
  bool hasValidCode(String code);
}

class AssetValidatorImplementation implements AssetValidator {
  @override
  bool hasValidCode(String code) => code.trim().isEmpty ? false : true;
}
