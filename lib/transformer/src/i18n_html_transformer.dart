part of polymer_intl.transformer;

class I18nHtmlTransformer extends Transformer {

  I18nHtmlTransformer():super();
  I18nHtmlTransformer.asPlugin();

  String get allowedExtensions => ".html";

  Future apply(Transform transform) {
    return transform.primaryInput.readAsString().then((content) {
      //if(transform.primaryInput.id.extension == '.html'){
        _applyHtml(transform, content);
      //}
    });
  }

  void _applyHtml(Transform transform, String content) {
    var id = transform.primaryInput.id;
    var i18nIO = new I18nManager();
    var doc = i18nIO.parseHTML(content);
    //content, pathForNames: id.path);
    
    if (i18nIO.isEmpty){
      return;
    }
    i18nIO.replaceAllMessage();
    
    var intlDartFileName = id.path.replaceAll('.html', '_intl.dart');
    var output = i18nIO.getDartMethods();
    var dartfileAssetId = new AssetId(id.package, intlDartFileName);
    transform.addOutput(new Asset.fromString(dartfileAssetId, output));
    transform.addOutput(new Asset.fromString(id, i18nIO.generateHTML(doc)));
  }
}
