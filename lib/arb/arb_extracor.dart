library polymer_intl.extractor;

import 'dart:io';
import 'package:polymer_intl/i18n_manager.dart';
import 'intl_lib/extract_to_arb.dart' as extract_to_arb;
import 'dart:async';
import 'package:polymer_intl/intl_arb_manager.dart';
import 'package:polymer_intl/util/file_collector.dart';
import 'package:path/path.dart' as path;

class ArbExtracor {
  final Config config;
  final I18nManager i18nManager = new I18nManager();
  ArbExtracor(this.config) {
    if (!config.outputARB.existsSync()) {
      config.outputARB.createSync();
    }
  }

  Future<File> extractArb([bool deleteTmpFile = true]) {
    File tmpFile;
    i18nManager.reset();
    return Future.wait([new FileCollector(config.rootProject, ['.dart'], observedFolder: ['web', 'lib']).collect(), new FileCollector(config.rootProject, ['.html'], followLinks: false).collect()]).then((list) {
      var dartFiles = list[0];
      var htmlFiles = list[1];
      htmlFiles.forEach((htmlFile) {
        i18nManager.parseHTML(new File(htmlFile).readAsStringSync());
      });
      String allDartIntlMethods = i18nManager.getDartMethods();
      tmpFile = new File(path.join(Directory.systemTemp.path, "int_${new DateTime.now().millisecondsSinceEpoch}.dart"));
      tmpFile.writeAsStringSync(allDartIntlMethods);
      
      var args = ["--output-dir=${config.outputARB.path}", tmpFile.path];
      args.addAll(dartFiles);
      
      print("extract_to_arb: $args");
      extract_to_arb.main(args);
      
      print('ready');
      return tmpFile;
    }).whenComplete(() {
      if (deleteTmpFile && tmpFile != null) {
         return tmpFile.delete();
       }
    });
  }
}
