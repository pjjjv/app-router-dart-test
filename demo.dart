/*
 *  App Router Test - dart
 *  Copyright (c) 2015 pjv
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:template_binding/template_binding.dart';
import 'package:pushstate_anchor/pushstate_anchor.dart';

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
