import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:template_binding/template_binding.dart';

void main() {
  initPolymer().run(() {

    Polymer.onReady.then((_) {
      var autoBind = document.querySelector('#auto-bind');
      templateBind(autoBind).model = new MyModel();
    });
  });
}


class MyModel extends Observable {
}
