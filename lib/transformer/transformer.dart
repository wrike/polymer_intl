library polymer_intl.transformer;

import 'package:barback/barback.dart';
import 'dart:async';
import 'package:polymer_intl/i18n_manager.dart';
import 'package:code_transformers/messages/build_logger.dart';
import 'package:source_maps/refactor.dart';
import 'package:source_span/source_span.dart';
import 'package:analyzer/analyzer.dart';
import 'package:path/path.dart' as path;

part 'src/i18n_polymer_component_transformer.dart';
part 'src/i18n_html_transformer.dart';