part of polymer_intl.i18n_element;

abstract class BaseI18nElement {
  String get NAME_PREFIX;
  final List<I18nArgument> args;
  final Element element;
  final String description;
  final String locale;
  final String meaning;
  final String value;
  final String _id;
  static const String LOCALE_ATTR_NAME = "locale";
  static const String DESCRIPTION_TAG = "desc";
  static const String MEANING_TAG = "meaning";
  static const String VALUE_TAG = "value";
  static const String ARGS_TAG = "arg";

  /*
   This method returns a hash code for this string. The hash code for a String object is computed as:
  s[0]*31^(n-1) + s[1]*31^(n-2) + ... + s[n-1]
  Using int arithmetic, where s[i] is the ith character of the string, n is the length of the string, and ^ indicates exponentiation. (The hash value of the empty string is zero.)
   */
  static String strHashId(String s) {
    Int32 hash = new Int32( 0 );
    var len = s.length;
    var index = 0;
    s.codeUnits.forEach((element) {
      index++;
      hash += element * math.pow(31, len - index);
    });
    return hash.toHexString().toUpperCase().replaceFirst('-', 'M');
  }

  BaseI18nElement.fromElement(Element element)
      : this._id = element.getElementsByTagName(VALUE_TAG).single.text,
        this.locale = element.attributes[LOCALE_ATTR_NAME],
        this.description = element.getElementsByTagName(DESCRIPTION_TAG).single.text,
        this.meaning = element.getElementsByTagName(MEANING_TAG).single.text,
        this.value = element.getElementsByTagName(VALUE_TAG).single.text,
        this.args = getArguments(element.getElementsByTagName(ARGS_TAG)),
        this.element = element {
  }


  String get id => strHashId(this._id);

  BaseI18nElement(this.locale, this.description, this.meaning, String value, this.args, [this.element]):this.value = value, this._id = value;


  String generateDartMethod();

  Text generateCallMethodForHTML() {
    Text result;
    Iterable<String> arguments = args.map((item) => item.value);
    result = new Text('{{$methodName(${arguments.join(', ')})}}');
    return result;
  }

  static List<I18nArgument> getArguments(List<Element> items) {
    return items.map((item) => new I18nArgument(item.attributes['id'], item.attributes['example'], item.innerHtml)).toList(growable: false);
  }

  Map<String, String> getExample() => new Map.fromIterable(args, key: (I18nArgument arg) => arg.id, value: (I18nArgument arg) => arg.example);

  String get methodName => '${NAME_PREFIX}_${id}';

  String generateDartMethodInterface() {
    Iterable<String> arguments = args.map((item) => item.id);
    return "String $methodName(${arguments.join(', ')})";
  }
}
