// This class is modified version of packages/observe/transformer.dart

part of polymer_intl.transformer;

class I18nPolymerComponentTransformer extends Transformer {
  final bool releaseMode;
  final List<String> _files;

  I18nPolymerComponentTransformer([List<String> files, bool releaseMode])
      : _files = files,
        releaseMode = releaseMode == true;
  I18nPolymerComponentTransformer.asPlugin(BarbackSettings settings)
      : _files = _readFiles(settings.configuration['files']),
        releaseMode = settings.mode == BarbackMode.RELEASE;

  // TODO(nweiz): This should just take an AssetId when barback <0.13.0 support
  // is dropped.
  Future<bool> isPrimary(idOrAsset) {
    var id = idOrAsset is AssetId ? idOrAsset : idOrAsset.id;
    return new Future.value(id.extension == '.dart' && (_files == null || _files.contains(id.path)));
  }

  static List<String> _readFiles(value) {
    if (value == null) return null;
    var files = [];
    bool error;
    if (value is List) {
      files = value;
      error = value.any((e) => e is! String);
    } else if (value is String) {
      files = [value];
      error = false;
    } else {
      error = true;
    }
    if (error) print('Invalid value for "files" in the observe transformer.');
    return files;
  }

  Future apply(Transform transform) {
    return transform.primaryInput.readAsString().then((content) {
      var id = transform.primaryInput.id;
      var intlDartFileName = transform.primaryInput.id.path.replaceAll('.dart', '_intl.dart');
      var dartFileAssetId = new AssetId(id.package, intlDartFileName);
      if (!customTagMatcher.hasMatch(content)) return null;
      return transform.hasInput(dartFileAssetId).then((isExist) {
        if (isExist == false) {
          return null;
        }
        // TODO(sigmund): improve how we compute this url
        var url = id.path.startsWith('lib/') ? 'package:${id.package}/${id.path.substring(4)}' : id.path;
        var sourceFile = new SourceFile(content, url: url);
        var logger = new BuildLogger(transform, convertErrorsToWarnings: !releaseMode/*, detailsUri: 'http://goo.gl/5HPeuP'*/);
        var transaction = _transformCompilationUnit(content, sourceFile, logger);
        if (!transaction.hasEdits) {
          transform.addOutput(transform.primaryInput);
        } else {
          var printer = transaction.commit();
          // TODO(sigmund): emit source maps when barback supports it (see
          // dartbug.com/12340)
          printer.build(url);
          transform.addOutput(new Asset.fromString(id, printer.text));
        }
        return logger.writeOutput();
      });
    });
  }

  static TextEditTransaction _transformCompilationUnit(String inputCode, SourceFile sourceFile, BuildLogger logger) {
    var unit = parseCompilationUnit(inputCode, suppressErrors: true);
    var code = new TextEditTransaction(inputCode, sourceFile);
    for (var directive in unit.directives) {
      if (directive is ImportDirective) {
        var pos = directive.end;
        var intlExtractMsgsFile = sourceFile.url.path.replaceAll('.dart', '_intl.dart');
        code.edit(pos, pos, "import '${path.basename(intlExtractMsgsFile)}';");
        break;
      }
    }


    for (var declaration in unit.declarations) {
      if (declaration is ClassDeclaration && _hasCustomTag(declaration)) {
        _transformClass(declaration, code, sourceFile, logger);
      }
    }
    return code;
  }


  static void _transformClass(ClassDeclaration cls, TextEditTransaction code, SourceFile file, BuildLogger logger) {
    // see packages/observe/transformer.dart
    _mixinIntlExtract(cls, code);
  }

/// Adds "with IntlExtract" and associated implementation.
  static void _mixinIntlExtract(ClassDeclaration cls, TextEditTransaction code) {
    // Note: we need to be careful to put the with clause after extends, but
    // before implements clause.
    if (cls.withClause != null) {
      var pos = cls.withClause.end;
      code.edit(pos, pos, ', IntlExtract');
    } else if (cls.extendsClause != null) {
      var pos = cls.extendsClause.end;
      code.edit(pos, pos, ' with IntlExtract ');
    }
  }

/// True if the node has the `@observable` or `@published` annotation.
// TODO(jmesserly): it is not good to be hard coding Polymer support here.
  static bool _hasCustomTag(AnnotatedNode node) => node.metadata.any(_isCustomTagAnnotation);

//_getSpan(SourceFile file, AstNode node) => file.span(node.offset, node.end);

  static final customTagMatcher = new RegExp(r"@CustomTag\(");

// TODO(jmesserly): this isn't correct if the annotation has been imported
// with a prefix, or cases like that. We should technically be resolving, but
// that is expensive in analyzer, so it isn't feasible yet.
  static bool _isCustomTagAnnotation(Annotation node) => _isAnnotationContant(node, 'CustomTag');

  static bool _isAnnotationContant(Annotation m, String name) => m.name.name == name && m.constructorName == null;
}
