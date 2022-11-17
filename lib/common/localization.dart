class Localization {
  static String getFlag(String code) {
    switch(code) {
      case 'en':
        return "${String.fromCharCode(0x1F1FA)}${String.fromCharCode(0x1F1F8)}";
      case 'id':
      default:
        return "${String.fromCharCode(0x1F1EE)}${String.fromCharCode(0x1F1E9)}";
    }
  }
}