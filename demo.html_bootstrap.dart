library app_bootstrap;

import 'package:polymer/polymer.dart';

import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_xhr_dart.dart' as i0;
import 'package:core_elements/core_ajax_dart.dart' as i1;
import 'package:core_elements/core_selection.dart' as i2;
import 'package:core_elements/core_selector.dart' as i3;
import 'package:core_elements/core_animated_pages.dart' as i4;
import 'package:app_router/app_router.dart' as i5;
import 'package:app_router/app_route.dart' as i6;
import 'package:pushstate_anchor/pushstate_anchor.dart' as i7;
import 'package:core_elements/core_toolbar.dart' as i8;
import 'package:core_elements/core_media_query.dart' as i9;
import 'package:core_elements/core_drawer_panel.dart' as i10;
import 'package:core_elements/core_header_panel.dart' as i11;
import 'package:core_elements/core_meta.dart' as i12;
import 'package:core_elements/core_iconset.dart' as i13;
import 'package:core_elements/core_icon.dart' as i14;
import 'package:core_elements/core_iconset_svg.dart' as i15;
import 'package:core_elements/core_icon_button.dart' as i16;
import 'package:core_elements/core_scaffold.dart' as i17;
import 'package:core_elements/core_item.dart' as i18;
import 'package:core_elements/core_style.dart' as i19;
import 'demo.html.0.dart' as i20;
import 'package:smoke/smoke.dart' show Declaration, PROPERTY, METHOD;
import 'package:smoke/static.dart' show useGeneratedCode, StaticConfiguration;
import 'package:core_elements/core_xhr_dart.dart' as smoke_0;
import 'package:polymer/polymer.dart' as smoke_1;
import 'package:core_elements/core_ajax_dart.dart' as smoke_2;
import 'package:observe/src/metadata.dart' as smoke_3;
import 'package:app_router/app_router.dart' as smoke_4;
import 'package:app_router/app_route.dart' as smoke_5;
import 'package:pushstate_anchor/pushstate_anchor.dart' as smoke_6;
abstract class _M0 {} // PolymerElement & ChangeNotifier
abstract class _M1 {} // PolymerElement & Observable
abstract class _M3 {} // _M2 & Observable
abstract class _M2 {} // Object & Polymer

void main() {
  useGeneratedCode(new StaticConfiguration(
      checkedMode: false,
      getters: {
        #active: (o) => o.active,
        #auto: (o) => o.auto,
        #autoChanged: (o) => o.autoChanged,
        #bindRouter: (o) => o.bindRouter,
        #body: (o) => o.body,
        #bodyChanged: (o) => o.bodyChanged,
        #color: (o) => o.color,
        #contentType: (o) => o.contentType,
        #core_animated_pages: (o) => o.core_animated_pages,
        #elem: (o) => o.elem,
        #error: (o) => o.error,
        #handleAs: (o) => o.handleAs,
        #headers: (o) => o.headers,
        #imp: (o) => o.imp,
        #init: (o) => o.init,
        #loading: (o) => o.loading,
        #method: (o) => o.method,
        #mode: (o) => o.mode,
        #params: (o) => o.params,
        #paramsChanged: (o) => o.paramsChanged,
        #path: (o) => o.path,
        #progress: (o) => o.progress,
        #redirect: (o) => o.redirect,
        #regex: (o) => o.regex,
        #response: (o) => o.response,
        #selected: (o) => o.selected,
        #shadow: (o) => o.shadow,
        #state: (o) => o.state,
        #template: (o) => o.template,
        #trailingSlash: (o) => o.trailingSlash,
        #transitions: (o) => o.transitions,
        #typecast: (o) => o.typecast,
        #url: (o) => o.url,
        #urlChanged: (o) => o.urlChanged,
        #withCredentials: (o) => o.withCredentials,
      },
      setters: {
        #active: (o, v) { o.active = v; },
        #auto: (o, v) { o.auto = v; },
        #bindRouter: (o, v) { o.bindRouter = v; },
        #body: (o, v) { o.body = v; },
        #color: (o, v) { o.color = v; },
        #contentType: (o, v) { o.contentType = v; },
        #core_animated_pages: (o, v) { o.core_animated_pages = v; },
        #elem: (o, v) { o.elem = v; },
        #error: (o, v) { o.error = v; },
        #handleAs: (o, v) { o.handleAs = v; },
        #headers: (o, v) { o.headers = v; },
        #imp: (o, v) { o.imp = v; },
        #init: (o, v) { o.init = v; },
        #loading: (o, v) { o.loading = v; },
        #method: (o, v) { o.method = v; },
        #mode: (o, v) { o.mode = v; },
        #params: (o, v) { o.params = v; },
        #path: (o, v) { o.path = v; },
        #progress: (o, v) { o.progress = v; },
        #redirect: (o, v) { o.redirect = v; },
        #regex: (o, v) { o.regex = v; },
        #response: (o, v) { o.response = v; },
        #shadow: (o, v) { o.shadow = v; },
        #state: (o, v) { o.state = v; },
        #template: (o, v) { o.template = v; },
        #trailingSlash: (o, v) { o.trailingSlash = v; },
        #transitions: (o, v) { o.transitions = v; },
        #typecast: (o, v) { o.typecast = v; },
        #url: (o, v) { o.url = v; },
        #withCredentials: (o, v) { o.withCredentials = v; },
      },
      parents: {
        smoke_5.AppRoute: _M1,
        smoke_4.AppRouter: smoke_1.PolymerElement,
        smoke_2.CoreAjax: _M0,
        smoke_0.CoreXhr: smoke_1.PolymerElement,
        smoke_6.PushstateAnchor: _M3,
        _M0: smoke_1.PolymerElement,
        _M1: smoke_1.PolymerElement,
        _M3: _M2,
      },
      declarations: {
        smoke_5.AppRoute: {
          #active: const Declaration(#active, bool, annotations: const [smoke_1.published]),
          #bindRouter: const Declaration(#bindRouter, bool, annotations: const [smoke_1.published]),
          #elem: const Declaration(#elem, String, annotations: const [smoke_1.published]),
          #imp: const Declaration(#imp, String, annotations: const [smoke_1.published]),
          #path: const Declaration(#path, String, annotations: const [smoke_1.published]),
          #redirect: const Declaration(#redirect, String, annotations: const [smoke_1.published]),
          #regex: const Declaration(#regex, bool, annotations: const [smoke_1.published]),
          #template: const Declaration(#template, bool, annotations: const [smoke_1.published]),
        },
        smoke_4.AppRouter: {
          #bindRouter: const Declaration(#bindRouter, bool, annotations: const [smoke_1.published]),
          #core_animated_pages: const Declaration(#core_animated_pages, bool, annotations: const [smoke_1.published]),
          #init: const Declaration(#init, String, annotations: const [smoke_1.published]),
          #mode: const Declaration(#mode, String, annotations: const [smoke_1.published]),
          #shadow: const Declaration(#shadow, bool, annotations: const [smoke_1.published]),
          #trailingSlash: const Declaration(#trailingSlash, String, annotations: const [smoke_1.published]),
          #transitions: const Declaration(#transitions, String, annotations: const [smoke_1.published]),
          #typecast: const Declaration(#typecast, String, annotations: const [smoke_1.published]),
        },
        smoke_2.CoreAjax: {
          #auto: const Declaration(#auto, bool, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #autoChanged: const Declaration(#autoChanged, Function, kind: METHOD),
          #body: const Declaration(#body, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #bodyChanged: const Declaration(#bodyChanged, Function, kind: METHOD),
          #contentType: const Declaration(#contentType, String),
          #error: const Declaration(#error, dynamic, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #handleAs: const Declaration(#handleAs, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #headers: const Declaration(#headers, Map, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #loading: const Declaration(#loading, bool, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #method: const Declaration(#method, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #params: const Declaration(#params, dynamic, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #paramsChanged: const Declaration(#paramsChanged, Function, kind: METHOD),
          #progress: const Declaration(#progress, smoke_2.CoreAjaxProgress, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #response: const Declaration(#response, dynamic, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #url: const Declaration(#url, String, kind: PROPERTY, annotations: const [smoke_3.reflectable, smoke_1.published]),
          #urlChanged: const Declaration(#urlChanged, Function, kind: METHOD),
          #withCredentials: const Declaration(#withCredentials, bool),
        },
        smoke_0.CoreXhr: {},
        smoke_6.PushstateAnchor: {
          #state: const Declaration(#state, String, annotations: const [smoke_1.published]),
        },
      },
      names: {
        #active: r'active',
        #auto: r'auto',
        #autoChanged: r'autoChanged',
        #bindRouter: r'bindRouter',
        #body: r'body',
        #bodyChanged: r'bodyChanged',
        #color: r'color',
        #contentType: r'contentType',
        #core_animated_pages: r'core_animated_pages',
        #elem: r'elem',
        #error: r'error',
        #handleAs: r'handleAs',
        #headers: r'headers',
        #imp: r'imp',
        #init: r'init',
        #loading: r'loading',
        #method: r'method',
        #mode: r'mode',
        #params: r'params',
        #paramsChanged: r'paramsChanged',
        #path: r'path',
        #progress: r'progress',
        #redirect: r'redirect',
        #regex: r'regex',
        #response: r'response',
        #selected: r'selected',
        #shadow: r'shadow',
        #state: r'state',
        #template: r'template',
        #trailingSlash: r'trailingSlash',
        #transitions: r'transitions',
        #typecast: r'typecast',
        #url: r'url',
        #urlChanged: r'urlChanged',
        #withCredentials: r'withCredentials',
      }));
  new LogInjector().injectLogsFromUrl('demo.html._buildLogs');
  configureForDeployment([
      () => Polymer.register('core-xhr-dart', i0.CoreXhr),
      () => Polymer.register('core-ajax-dart', i1.CoreAjax),
      i2.upgradeCoreSelection,
      i3.upgradeCoreSelector,
      i4.upgradeCoreAnimatedPages,
      () => Polymer.register('app-router', i5.AppRouter),
      () => Polymer.register('app-route', i6.AppRoute),
      () => Polymer.register('pushstate-anchor', i7.PushstateAnchor),
      i8.upgradeCoreToolbar,
      i9.upgradeCoreMediaQuery,
      i10.upgradeCoreDrawerPanel,
      i11.upgradeCoreHeaderPanel,
      i12.upgradeCoreMeta,
      i13.upgradeCoreIconset,
      i14.upgradeCoreIcon,
      i15.upgradeCoreIconsetSvg,
      i16.upgradeCoreIconButton,
      i17.upgradeCoreScaffold,
      i18.upgradeCoreItem,
      i19.upgradeCoreStyle,
    ]);
  i20.main();
}
