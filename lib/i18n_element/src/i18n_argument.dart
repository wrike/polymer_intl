part of polymer_intl.i18n_element;

class I18nArgument {
  final String value;
  final String id;
  final String example;
  I18nArgument(this.id, this.example, String value) : this.value = parseValue(value);

  static String parseValue(String value) {
    if (value.contains("{{") && value.contains("}}")) {
      return value.replaceAll(r'{{', r'').replaceAll(r'}}', r'');
    } else {
      return '"$value"';
    }
  }

}
