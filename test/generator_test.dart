library generator_test;

import 'package:unittest/unittest.dart';
import 'package:polymer_intl/i18n_manager.dart';
import 'dart:io';
import 'package:html5lib/parser.dart' show parse;

void main() => defineTests();

String readSampleFile(String name) => new File('./test/sample/$name').readAsStringSync();
String readHtmlSampleFile(String name) => parse(new File('./test/sample/$name').readAsStringSync()).outerHtml;

void defineTests() {
  group('Parse', () {
    test('BaseI18nElement', () {
      String srcHTML = readSampleFile("test_message1.html");
      var i18nIO = new I18nManager();
      i18nIO.parseHTML(srcHTML);
      var item = i18nIO.allI18n[0];
      expect(item.id, "msg1");
      expect(item.value, r"The protection \$arg1 of property rights $arg2 remains one of the most $arg3 contentious issues in $arg1 present-day Russia \$arg1.");
      expect(item.meaning, "meaning - Lorem ipsum dolor sit amet, consectetur adipisicing ");
      expect(item.description, "desc - Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia, neque quidem officiis sit perferendis");
      expect(item.locale, null);
      expect(item.args[0].id, "arg1");
      expect(item.args[2].id, "arg3");
      expect(item.args[0].example, "test1");
      expect(item.args[0].value, '"1"');
      expect(item.args[2].example, "test3");
      expect(item.args[2].value, '"3"');

      item = i18nIO.allI18n[1];
      expect(item.id, "msg2_with_param");
      expect(item.value, r"2The protection \$arg1 of property rights $arg2 remains one of the most $arg3 contentious issues in $arg1 present-day Russia \$arg1.");
      expect(item.meaning, "2meaning - Lorem ipsum dolor sit amet, consectetur adipisicing ");
      expect(item.description, "2desc - Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia, neque quidem officiis sit perferendis");
      expect(item.locale, "EN");
      expect(item.args[0].id, "arg1");
      expect(item.args[2].id, "arg3");
      expect(item.args[0].example, "test1");
      expect(item.args[0].value, 'value1');
      expect(item.args[2].example, "test3");
      expect(item.args[2].value, 'value2');

      item = i18nIO.allI18n[2];
      expect(item.id, "msg3_without_args");
      expect(item.value, r"Msg3 Only Text");
      expect(item.meaning, "Msg3 meaning - Lorem ipsum dolor sit amet, consectetur adipisicing ");
      expect(item.description, "3desc - Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia, neque quidem officiis sit perferendis");
      expect(item.locale, null);
      expect(item.args.isEmpty, true);
    });
  });
  group('HTML', () {
    test('message', () {
      String srcHTML = readSampleFile("test_message1.html");
      String expectedHTML = readHtmlSampleFile('test_message1_expected.html');
      var i18nIO = new I18nManager();
      var dom = i18nIO.parseHTML(srcHTML);
      i18nIO.replaceAllMessage();
      expect(i18nIO.generateHTML(dom), expectedHTML);
    });
  });
  group('Dart', () {
      test('message', () {
        String srcHTML = readSampleFile("test_message1.html");
        String expectedDart = readSampleFile('test_message1_intl.dart');
        var i18nIO = new I18nManager();
        var dom = i18nIO.parseHTML(srcHTML);
        expect(i18nIO.getDartMethods(wrapped:true), expectedDart);
      });
    });
}
