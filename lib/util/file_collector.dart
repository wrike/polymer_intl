library util;
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as path;

class FileCollector {
  final Directory root;
  final List<String> extensions;
  final RegExp skipRegExp = new RegExp(r'\.pub|packages|\.git|build|\.hg');
  final List<RegExp> observedFolder;
  final bool followLinks;
  FileCollector(Directory root,this.extensions, {List<String> observedFolder,this.followLinks:true}): this.root = root, this.observedFolder = _generateObservedFolder(observedFolder);
  
  static _generateObservedFolder(List<String> observedFolder) {
    if (observedFolder == null){
      return null;
    }
    return observedFolder.map((item)=>new RegExp(r'\/'+item+r'\/')).toList(growable: false);
  }
  Future<List<String>> collect() => root.list(recursive: true, followLinks: followLinks).listen(_processFileEntity).asFuture().then((_) => _files);

  List<String> _files = [];

  void _processFileEntity(FileSystemEntity entity) {
    var entityPath = entity.path;
    if (extensions.contains(path.extension(entityPath))){
      var isFileCouldBeProcessed = !entityPath.contains(skipRegExp) && _isFileInObservedFolder(entityPath);
      if (isFileCouldBeProcessed) {
        _files.add(entityPath);
      }
    };
  }

  bool _isFileInObservedFolder(String file_path) {
    if (observedFolder == null){
      return true;
    }
    var result = false;
    observedFolder.forEach((RegExp expr) {
      result = result || file_path.contains(expr);
    });
    return result;
  }
}
