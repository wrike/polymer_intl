part of polymer_intl.i18n_element;

abstract class BaseI18nElement {
  String get NAME_PREFIX;
  final List<I18nArgument> args;
  final Element element;
  final String description;
  final String locale;
  final String meaning;
  final String value;
  final String id;
  static const String ID_ATTR_NAME = "id";
  static const String LOCALE_ATTR_NAME = "locale";
  static const String DESCRIPTION_TAG = "desc";
  static const String MEANING_TAG = "meaning";
  static const String VALUE_TAG = "value";
  static const String ARGS_TAG = "arg";



  BaseI18nElement.fromElement(Element element)
      : this.id = element.attributes[ID_ATTR_NAME],
        this.locale = element.attributes[LOCALE_ATTR_NAME],
        this.description = element.getElementsByTagName(DESCRIPTION_TAG).single.text,
        this.meaning = element.getElementsByTagName(MEANING_TAG).single.text,
        this.value = element.getElementsByTagName(VALUE_TAG).single.text,
        this.args = getArguments(element.getElementsByTagName(ARGS_TAG)),
        this.element = element {
  }

  BaseI18nElement(this.id, this.locale, this.description, this.meaning, this.value, this.args, [this.element]);


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
