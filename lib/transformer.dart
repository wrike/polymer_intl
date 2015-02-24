library polymer_intl.transformer;
import 'package:barback/barback.dart';
import 'transformer/transformer.dart';

class I18nTransformerGroup implements TransformerGroup {
  final Iterable<Iterable> phases;

  I18nTransformerGroup()
        : phases = createDeployPhases();
  
  I18nTransformerGroup.asPlugin(BarbackSettings settings)
      : this();
}

List<List<Transformer>> createDeployPhases(){
  List phases = [];
  phases.addAll([
    [new I18nHtmlTransformer()],
    [new I18nPolymerComponentTransformer()]
  ]);
  return phases;
}
