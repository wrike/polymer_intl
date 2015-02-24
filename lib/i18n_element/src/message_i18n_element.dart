part of polymer_intl.i18n_element;

class MessageI18nElement extends BaseI18nElement {
  final NAME_PREFIX = 'message';
  static const String TAG = 'i18n-message';

  MessageI18nElement.fromElement(Element element) : super.fromElement(element);

  @override
  String generateDartMethod() {
    String jsonExample = JSON.encode(getExample());
    Iterable<String> arguments = args.map((item) => item.id);
    String result = '''
    ${generateDartMethodInterface()} => Intl.message(
        "$value",
        name: "$methodName",${locale!= null?"locale:'$locale',":""}
        desc: "$description",
        args: [${arguments.join(', ')}],
        examples: $jsonExample);''';
    return result;
  }
}
