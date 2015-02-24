part of polymer_intl.i18n_element;

class GenderI18nElement extends BaseI18nElement {
  static const String TAG = "i18n-gender";
  final String male;
  final String female;
  final String other;
  static const String MALE_TAG = "male";
  static const String FEMALE_TAG = "female";
  static const String OTHER_TAG = "default";
  @override
  final NAME_PREFIX = 'gender';

  GenderI18nElement.fromElement(Element element)
      : super.fromElement(element),
        this.male = element.getElementsByTagName(MALE_TAG).single.text,
        this.female = element.getElementsByTagName(FEMALE_TAG).single.text,
        this.other = element.getElementsByTagName(OTHER_TAG).single.text {
  }

  @override
  String generateDartMethod() {
    var jsonExample = JSON.encode(getExample());
    Iterable<String> arguments = args.map((item) => item.id);
    var result = '''
    ${generateDartMethodInterface()} => Intl.gender(
        "$value",
        name: "$methodName",${locale!= null?"locale:'$locale',":""}
        male: "$male",
        female: "$female",
        other: "$other",
        desc: "$description",
        args: [${arguments.join(', ')}],
        examples: $jsonExample);''';
    return result;
  }

}
