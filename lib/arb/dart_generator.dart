library polymer_intl.dart_generator;

import 'package:polymer_intl/arb/intl_lib/generate_from_arb.dart' as generate_from_arb;
import 'dart:async';
import '../intl_arb_manager.dart';
import '../util/file_collector.dart';

class DartGenerator {
  final Config config;
  DartGenerator(this.config) {
    if (!config.outpurMessagesDart.existsSync()) {
      config.outpurMessagesDart.createSync(recursive: true);
    }
  }

  Future generateFromArb([List<String> externalDartFiles]) {
    var args = ["--output-dir=${config.outpurMessagesDart.path}"];
    return Future.wait([new FileCollector(config.rootProject, ['.dart'], observedFolder: ['web', 'lib']).collect(), 
      new FileCollector(config.rootProject, ['.arb'], observedFolder: [Config.ARB_FOLDER_NAME]).collect()]).then((list) {
      var dartFiles = list[0];
      var arbFiles = list[1];
      if (externalDartFiles != null) {
        args.addAll(externalDartFiles);
      }
      args.addAll(dartFiles);
      args.addAll(arbFiles);
      print("arb_to_dart: $args");
      generate_from_arb.main(args);
      print('ready');
    });
  }
}
