import 'package:polymer_intl/intl_arb_manager.dart';
import 'dart:io';

// Example generate of ARB and Dart.

main(List<String> args) {
  var root_folder = Directory.current.parent.path;
  if (args.isNotEmpty && args[0].isNotEmpty) {
    root_folder = args[0];
  }
  var intlArbMngr = new IntlArbManager(new Config(root_folder));
  intlArbMngr.extractArbFromDart(false).then((File tmpFile) {
    intlArbMngr.generateDartFromArb([tmpFile.path]).then((_)=>tmpFile.delete());
  });
}
