library polymer_intl.I18nManager;
import 'dart:io';

import 'package:html5lib/dom.dart';
import 'package:html5lib/parser.dart' show parse;

import 'i18n_element/i18n_element.dart';

class I18nManager {

  final List<BaseI18nElement> allI18n = [];

  I18nManager();

  void reset(){
    allI18n.clear();
  }

  Document parseHTML(String text) {
    Document _source_document = parse(text);
    var i18nMessageBlocks = _source_document.getElementsByTagName(MessageI18nElement.TAG);
    var i18nPluralBlock = _source_document.getElementsByTagName(PluralI18nElement.TAG);
    var i18nGenderBlock = _source_document.getElementsByTagName(GenderI18nElement.TAG);
    var i18nSelectBlock = _source_document.getElementsByTagName(SelectI18nElement.TAG);
    allI18n.addAll(i18nMessageBlocks.map((element) => new MessageI18nElement.fromElement(element)));
    allI18n.addAll(i18nGenderBlock.map((element) => new GenderI18nElement.fromElement(element)));
    allI18n.addAll(i18nPluralBlock.map((element) => new PluralI18nElement.fromElement(element)));
    allI18n.addAll(i18nSelectBlock.map((element) => new SelectI18nElement.fromElement(element)));
    return _source_document;
  }

  String generateHTML(Document _source_document) {
    return _source_document.outerHtml;
  }

  bool get isEmpty => allI18n.isEmpty;
  bool get isNotEmpty => allI18n.isNotEmpty;

  String getDartMethods({bool wrapped: true}) {
    StringBuffer sb = new StringBuffer();

    if (wrapped) {
      sb.writeln('''import 'package:intl/intl.dart';
class IntlExtract{''');
    }
    allI18n.forEach((BaseI18nElement item) {
      sb.writeln(item.generateDartMethod());
      sb.writeln('');
    });

    if (wrapped) {
      sb.write('''}''');
    }
    return sb.toString();
  }

  void writeDartToFile(File dartFile) {
    StringBuffer sb = new StringBuffer();

    allI18n.forEach((BaseI18nElement item) {
      sb.writeln(item.generateDartMethod());
      sb.writeln('');
    });

    dartFile.writeAsStringSync(sb.toString());
  }

  void replaceAllMessage() {
    allI18n.forEach((el) {
      el.element.replaceWith(el.generateCallMethodForHTML());
    });
  }

}
