part of polymer_intl.i18n_element;

class SelectI18nCase {
  final String id;
  final String value;
  SelectI18nCase(this.id, this.value);
}

class SelectI18nElement extends BaseI18nElement {
  static const String TAG = "i18n-select";
  final List<SelectI18nCase> cases;
  final NAME_PREFIX = 'select';
  static const String case_TAG = "case";

  SelectI18nElement.fromElement(Element element)
      : super.fromElement(element),
        this.cases = parseCases(element.getElementsByTagName(case_TAG)) {

  }

  static List<SelectI18nCase> parseCases(List<Element> items) {
    return items.map((item) => new SelectI18nCase(item.attributes['id'], item.attributes['value']));
  }

  @override
  String generateDartMethod() {
    var jsonExample = JSON.encode(getExample());
    var jsonCases = JSON.encode(getCases());
    Iterable<String> arguments = args.map((item) => item.id);
    var result = '''
    ${generateDartMethodInterface()} => Intl.select(
        "$value",
        $jsonCases,
        name: "$methodName",${locale!= null?"locale:'$locale',":""}
        desc: "$description",
        args: [${arguments.join(', ')}],
        examples: $jsonExample);''';
    return result;
  }

  Map<String, String> getCases() => new Map.fromIterable(cases, key: (SelectI18nCase arg) => arg.id, value: (SelectI18nCase arg) => arg.value);
}
