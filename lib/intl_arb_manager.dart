library polymer_intl.IntlArbManager;

import 'package:polymer_intl/arb/arb_extracor.dart';
import 'package:polymer_intl/arb/dart_generator.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;

class Config{
  final Directory rootProject;
  final Directory outputARB;
  final Directory outpurMessagesDart;
  static final String ARB_FOLDER_NAME = "arb";
  Config(String rootFolderPath):this.rootProject = new Directory(rootFolderPath),
      outputARB = new Directory(path.join(rootFolderPath,ARB_FOLDER_NAME)),
      outpurMessagesDart = new Directory(path.join(rootFolderPath, "lib","gen", "intl"));
}


/**
 * var intlArbMngr = new IntlArbManager(new Config(root_folder));
   intlArbMngr.extractArbFromDart(false).then((File tmpFile) {
    intlArbMngr.generateDartFromArb([tmpFile.path]).then((_)=>tmpFile.delete());});
 */
class IntlArbManager {
  final Config config;

  IntlArbManager(Config this.config);

  Future extractArbFromDart([bool deleteTmpFile = true]) => new ArbExtracor(config).extractArb(deleteTmpFile);

  Future generateDartFromArb([List<String> externalDartFiles]) => new DartGenerator(config).generateFromArb(externalDartFiles);
}