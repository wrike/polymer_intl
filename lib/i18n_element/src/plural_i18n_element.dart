part of polymer_intl.i18n_element;

class PluralI18nElement extends BaseI18nElement {
  static const String TAG = "i18n-plural";
  final String zero;
  final String one;
  final String two;
  final String few;
  final String many;
  final String other;

  static const String zero_TAG = "zero";
  static const String one_TAG = "one";
  static const String two_TAG = "two";
  static const String few_TAG = "few";
  static const String many_TAG = "many";
  static const String other_TAG = "default";

  final NAME_PREFIX = 'plural';

  PluralI18nElement.fromElement(Element element)
      : super.fromElement(element),
        this.zero = element.getElementsByTagName(zero_TAG).single.text,
        this.one = element.getElementsByTagName(one_TAG).single.text,
        this.two = element.getElementsByTagName(two_TAG).single.text,
        this.few = element.getElementsByTagName(few_TAG).single.text,
        this.many = element.getElementsByTagName(many_TAG).single.text,
        this.other = element.getElementsByTagName(other_TAG).single.text {
  }

  @override
  String generateDartMethod() {
    var jsonExample = JSON.encode(getExample());
    Iterable<String> arguments = args.map((item) => item.id);
    var result = '''
    ${generateDartMethodInterface()} => Intl.plural(
        "$value",
        name: "$methodName",${locale!= null?"locale:'$locale',":""}
        zero: "$zero",
        one: "$one",
        two: "$two",
        few: "$few",
        many: "$many",
        other: "$other",
        desc: "$description",
        args: [${arguments.join(', ')}],
        examples: $jsonExample);''';
    return result;
  }
}
