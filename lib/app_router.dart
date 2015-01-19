import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'package:core_elements/core_animated_pages.dart';
import 'package:app_router_dart_test/app_route.dart';

Map importedURIs = {};
var isIE = false;//TODO
RouteUri previousUrl = new RouteUri.parse(window.location.href, "auto");

@CustomTag('app-router')
class AppRouter extends PolymerElement {

  @published String init = "auto";
  @published String mode = "auto";
  @published String trailingSlash = "strict";
  @published bool shadow = false;
  @published String typecast = "auto";
  @published bool core_animated_pages = false;
  @published String transitions = "";
  @published bool bindRouter;

  bool isInitialized = false;
  EventListener stateChangeHandler;
  AppRoute previousRoute;
  AppRoute activeRoute;
  CoreAnimatedPages coreAnimatedPages;

  AppRouter.created() : super.created();

  void domReady() {
    super.domReady();
    if(init != "manual") {
      initialize();
    }
  }

  // Initial set up when attached
  /*void attached() {
    super.attached();
    if(init != "manual") {
      initialize();
    }
  }*/

  // Initialize the router
  void initialize() {
    if(isInitialized == true) {
      return;
    }
    isInitialized = true;

    // <app-router core-animated-pages transitions="hero-transition cross-fade">
    if (core_animated_pages) {
      // use shadow DOM to wrap the <app-route> elements in a <core-animated-pages> element
      // <app-router>
      //   # shadowRoot
      //   <core-animated-pages>
      //     # content in the light DOM
      //     <app-route elem="home-page">
      //       <home-page>
      //       </home-page>
      //     </app-route>
      //   </core-animated-pages>
      // </app-router>
      createShadowRoot();
      CoreAnimatedPages coreAnimatedPages = document.createElement('core-animated-pages');
      coreAnimatedPages.append(document.createElement('content'));

      // don't know why it needs to be static, but absolute doesn't display the page
      coreAnimatedPages.style.position = 'static';

      // toggle the selected page using selected="path" instead of selected="integer"
      coreAnimatedPages.setAttribute('valueattr', 'path');

      // pass the transitions attribute from <app-router core-animated-pages transitions="hero-transition cross-fade">
      // to <core-animated-pages transitions="hero-transition cross-fade">
      coreAnimatedPages.setAttribute('transitions', transitions);

      // set the shadow DOM's content
      shadowRoot.append(coreAnimatedPages);

      // when a transition finishes, remove the previous route's content. there is a temporary overlap where both
      // the new and old route's content is in the DOM to animate the transition.
      coreAnimatedPages.addEventListener('core-animated-pages-transition-end', (e) => transitionAnimationEnd(previousRoute));
    }

    // listen for URL change events
    stateChangeHandler = (Event e) => stateChange(this); //stateChange.bind(null, this); //TODO
    window.addEventListener('popstate', stateChangeHandler, false);
    if (isIE) {
      // IE bug. A hashchange is supposed to trigger a popstate event, making popstate the only event you
      // need to listen to. That's not the case in IE so we make another event listener for it.
      window.addEventListener('hashchange', stateChangeHandler, false);
    }

    // load the web component for the current route
    stateChange(this);
  }


  // clean up global event listeners
  void detached() {
    super.detached();
    window.removeEventListener('popstate', stateChangeHandler, false);
    if (isIE) {
      window.removeEventListener('hashchange', this.stateChangeHandler, false);
    }
  }

  // go(path, options) Navigate to the path
  //
  // options = {
  //   replace: true
  // }
  void go(String path, Map options) {
    if (mode != "pushstate") {
      // mode == auto or hash
      path = '#' + path;
    }
    if (options != null && options['replace'] == true) {
      window.history.replaceState(null, null, path);
    } else {
      window.history.pushState(null, null, path);
    }

    // dispatch a popstate event
    try {
      PopStateEvent popstateEvent = new Event.eventType('PopStateEvent', 'popstate', canBubble: false, cancelable: false);

      /*if (window.dispatchEvent_ != null) {
        // FireFox with polyfill
        window.dispatchEvent_(popstateEvent);
      } else {*/ //TODO
        // normal
        window.dispatchEvent(popstateEvent);
      /*}*/
    } catch(error) {
      // Internet Exploder
      /*var fallbackEvent = document.createEvent('CustomEvent');
      fallbackEvent.initCustomEvent('popstate', false, false, { state: {} });
      window.dispatchEvent(fallbackEvent);*/ //TODO
    }
  }


  // fire(type, detail, node) - Fire a new CustomEvent(type, detail) on the node
  //
  // listen with document.querySelector('app-router').addEventListener(type, function(event) {
  //   event.detail, event.preventDefault()
  // })

  bool fireEvent(String type, var detail, Node node) {
    CustomEvent event = new CustomEvent(type, detail: detail, canBubble: false, cancelable: true);
    //CustomEvent event = fire(type, detail: detail, canBubble: false, cancelable: true, onNode: node);
    return node.dispatchEvent(event);
  }
}

  // <app-router [init="auto|manual"] [mode="auto|hash|pushstate"] [trailingSlash="strict|ignore"] [shadow]></app-router>

    // <app-router core_animated_pages transitions="hero-transition cross-fade">





class RouteUri {
  Uri uri;
  bool isHashPath = false;

  String get hash {
    return uri.fragment;
  }

  String get path {
    return uri.path;
  }

  String get search {
    return uri.query;
  }

  toString() => uri.toString()+" isHashPath: $isHashPath";


  // parseUrl(location, mode) - Augment the native URL() constructor to get info about hash paths
  //
  // Example parseUrl('http://domain.com/other/path?queryParam3=false#/example/path?queryParam1=true&queryParam2=example%20string#middle', 'auto')
  //
  // returns {
  //   path: '/example/path',
  //   hash: '#middle'
  //   search: '?queryParam1=true&queryParam2=example%20string',
  //   isHashPath: true
  // }
  //
  // Note: The location must be a fully qualified URL with a protocol like 'http(s)://'
  RouteUri.parse(String uriIn, String mode){
    uri = Uri.parse(uriIn);
    isHashPath = (mode == "hash");

    if (mode != "pushstate") {
      // auto or hash

      // check for a hash path
      if (uri.fragment.startsWith('#/')) {
        // hash path
        isHashPath = true;
        uri = uri.replace(path: uri.fragment.substring(1));
      } else if (uri.fragment.startsWith('#!/')) {
        // hashbang path
        isHashPath = true;
        uri = uri.replace(path: uri.fragment.substring(2));
      } else if (isHashPath) {
        // still use the hash if mode="hash"
        if (uri.fragment.length == 0) {
          uri = uri.replace(path: '/');
        } else {
          uri = uri.replace(path: uri.fragment.substring(1));
        }
      }

      if (isHashPath) {
        uri = uri.replace(fragment: '');

        // hash paths might have an additional hash in the hash path for scrolling to a specific part of the page #/hash/path#elementId
        int secondHashIndex = uri.path.indexOf('#');
        if (secondHashIndex != -1) {
          uri = uri.replace(fragment: uri.path.substring(secondHashIndex));
          uri = uri.replace(path: uri.path.substring(0, secondHashIndex));
        }

        // hash paths get the search from the hash if it exists
        int searchIndex = uri.path.indexOf('?');
        if (searchIndex != -1) {
          uri = uri.replace(query: uri.path.substring(searchIndex));
          uri = uri.replace(path: uri.path.substring(0, searchIndex));
        }
      }
    }
  }
}

// Find the first <app-route> that matches the current URL and change the active route
void stateChange(AppRouter router) {
  RouteUri url = new RouteUri.parse(window.location.href, router.mode);

  // don't load a new route if only the hash fragment changed
  if (url.hash != previousUrl.hash && url.path == previousUrl.path && url.search == previousUrl.search && url.isHashPath == previousUrl.isHashPath) {
    scrollToHash(url.hash);
    return;
  }
  previousUrl = url;

  // fire a state-change event on the app-router and return early if the user called event.preventDefault()
  Map eventDetail = {
    'path': url.path
  };
  if (!router.fireEvent('state-change', eventDetail, router)) {
    return;
  }

  // find the first matching route
  for (Element ele in router.children){
    if (ele.tagName == 'APP-ROUTE'){
      AppRoute route = ele;
      if (testRoute(route.path, url.path, router.trailingSlash, route.regex)) {
        activateRoute(router, route, url);
        return;
      }
    }
  }

  router.fireEvent('not-found', eventDetail, router);
}

  // Activate the route
void activateRoute(AppRouter router, AppRoute route, RouteUri url) {
  if (route.redirect != null) {
    router.go(route.redirect, {'replace': true});
    return;
  }

  Map eventDetail = {
    'path': url.path,
    'route': route,
    'oldRoute': router.activeRoute
  };
  if (!router.fireEvent('activate-route-start', eventDetail, router)) {//TODO: are dashes allowed in Polymer event names?
    return;
  }
  if (!router.fireEvent('activate-route-start', eventDetail, route)) {
    return;
  }

  // update the references to the activeRoute and previousRoute. if you switch between routes quickly you may go to a
  // new route before the previous route's transition animation has completed. if that's the case we need to remove
  // the previous route's content before we replace the reference to the previous route.
  if (router.previousRoute != null && router.previousRoute.transitionAnimationInProgress) {
    transitionAnimationEnd(router.previousRoute);
  }
  if (router.activeRoute != null) {
    router.activeRoute.attributes.remove('active');
  }
  router.previousRoute = router.activeRoute;
  router.activeRoute = route;
  router.activeRoute.active = true;//TODO

  // import custom element or template
  if (route.imp != null) {
    importAndActivate(router, route.imp, route, url, eventDetail);
  }
  // pre-loaded custom element
  else if (route.elem != null) {
    activateCustomElement(router, route.elem, route, url, eventDetail);
  }
  // inline template
  else if (route.children.length != 0 && route.children.first != null && route.children.first.tagName == 'TEMPLATE') {
    activeTemplate(router, route.children.first, route, url, eventDetail);
  }
}

  // Import and activate a custom element or template
void importAndActivate(AppRouter router, String importUri, AppRoute route, RouteUri url, Map eventDetail){
  LinkElement importLink;
  importLoadedCallback(Event e) {
    activateImport(router, importLink, importUri, route, url, eventDetail);
  }

  if (!importedURIs.containsKey(importUri)) {//TODO
    // hasn't been imported yet
    importedURIs[importUri] = true;
    importLink = document.createElement('link');
    importLink.rel = 'import';
    importLink.href = importUri;
    importLink.addEventListener('load', importLoadedCallback);
    print("importURL: dh: ${document.head}, importLink: ${importLink.toString()}.");
    document.head.append(importLink);
  } else {
    // previously imported. this is an async operation and may not be complete yet.
    LinkElement importLink = document.querySelector('link[href="' + importUri + '"]');
    if (importLink.import != null) {
      // import complete
      importLoadedCallback(null);
    } else {
      // wait for `onload`
      importLink.addEventListener('load', importLoadedCallback);
    }
  }
}

  // Activate the imported custom element or template
void activateImport(AppRouter router, LinkElement importLink, String importUri, AppRoute route, RouteUri url, Map eventDetail) {
  // make sure the user didn't navigate to a different route while it loaded
  if (route.active = true) {
    if (route.template = true) {
      // template
      activeTemplate(router, importLink.import.querySelector('template'), route, url, eventDetail);
    } else {
      // custom element
      String elementName;
      if (route.elem != null) {
        elementName = route.elem;
      } else {
        elementName = importUri.split('/').last.replaceAll('.html', '');//TODO
      }
      activateCustomElement(router, elementName, route, url, eventDetail);
    }
  }
}

  // Data bind the custom element then activate it
void activateCustomElement(AppRouter router, String elementName, AppRoute route, RouteUri url, Map eventDetail) {
  Element customElement = document.createElement(elementName);
  Map model = createModel(router, route, url, eventDetail);
  customElement.attributes.addAll(model);//TODO
  activeElement(router, customElement, url, eventDetail);
}

  // Create an instance of the template
void activeTemplate(AppRouter router, AutoBindingElement template, AppRoute route, RouteUri url, Map eventDetail) {
  TemplateElement templateInstance;
  /*if ('createInstance' in template) {*/ //TODO
    // template.createInstance(model) is a Polymer method that binds a model to a template and also fixes
    // https://github.com/erikringsmuth/app-router/issues/19
    Map model = createModel(router, route, url, eventDetail);
    template.model = toObservable(model);//templateBind(template).model = model
    templateInstance = template;
  /*} else {
    templateInstance = document.importNode(template.content, true);
  }*/
  activeElement(router, templateInstance, url, eventDetail);
}

  // Create the route's model
Map createModel(AppRouter router, AppRoute route, RouteUri url, Map eventDetail) {
  Map model = routeArguments(route.getAttribute('path'), url.path, url.search, route.regex == true, router.typecast == 'auto');
  if (route.bindRouter != null || router.bindRouter != null) {
    model['router'] = router;
  }
  eventDetail['model'] = model;
  router.fireEvent('before-data-binding', eventDetail, router);
  router.fireEvent('before-data-binding', eventDetail, eventDetail['route']);
  return eventDetail['model'];
}

  // Replace the active route's content with the new element
void activeElement(AppRouter router, Element element, RouteUri url, Map eventDetail) {
  // core-animated-pages temporarily needs the old and new route in the DOM at the same time to animate the transition,
  // otherwise we can remove the old route's content right away.
  // UNLESS
  // if the route we're navigating to matches the same app-route (ex: path="/article/:id" navigating from /article/0 to
  // /article/1), then we have to simply replace the route's content instead of animating a transition.
  if (router.core_animated_pages == false || eventDetail['route'] == eventDetail['oldRoute']) {
    removeRouteContent(router.previousRoute);
  }

  // add the new content
  router.activeRoute.append(element);

  // animate the transition if core-animated-pages are being used
  if (router.core_animated_pages == true) {
    router.coreAnimatedPages.selected = router.activeRoute.path;

    // we already wired up transitionAnimationEnd() in init()

    // use to check if the previous route has finished animating before being removed
    if (router.previousRoute != null) {
      router.previousRoute.transitionAnimationInProgress = true;
    }
  }

  // scroll to the URL hash if it's present
  if (url.hash != null && router.core_animated_pages == false) {
    scrollToHash(url.hash);
  }

  router.fireEvent('activate-route-end', eventDetail, router);
  router.fireEvent('activate-route-end', eventDetail, eventDetail['route']);
}

  // Call when the previousRoute has finished the transition animation out
void transitionAnimationEnd(AppRoute previousRoute) {
  if (previousRoute != null) {
    previousRoute.transitionAnimationInProgress = false;
    removeRouteContent(previousRoute);
  }
}

  // Remove the route's content (but not the <template> if it exists)
void removeRouteContent(AppRoute route) {
  if (route != null) {
    List<Element> newChildren = [];
    for (Element node in route.children) {
      if (node.tagName == 'TEMPLATE') {
        newChildren.add(node);
      }
    }
    route.children = newChildren;
  }
}

  // scroll to the element with id="hash" or name="hash"
void scrollToHash(String hash) {
  if (hash == null) return;

  // wait for the browser's scrolling to finish before we scroll to the hash
  // ex: http://example.com/#/page1#middle
  // the browser will scroll to an element with id or name `/page1#middle` when the page finishes loading. if it doesn't exist
  // it will scroll to the top of the page. let the browser finish the current event loop and scroll to the top of the page
  // before we scroll to the element with id or name `middle`.

  void onTimerScrollToHash () {
    Element hashElement = document.querySelector('html /deep/ ' + hash);
    if (hashElement == null) {
      hashElement = document.querySelector('html /deep/ [name="' + hash.substring(1) + '"]');
    }
    if (hashElement != null /*&& hashElement.scrollIntoView*/) {//TODO
      hashElement.scrollIntoView(ScrollAlignment.TOP);
    }
  }

  new Timer(new Duration(milliseconds: 0), onTimerScrollToHash);//TODO
}

  // testRoute(routePath, urlPath, trailingSlashOption, isRegExp) - Test if the route's path matches the URL's path
  //
  // Example routePath: '/example/*'
  // Example urlPath = '/example/path'
bool testRoute(String routePath, String urlPath, String trailingSlashOption, bool isRegExp) {
  // this algorithm tries to fail or succeed as quickly as possible for the most common cases

  // handle trailing slashes (options: strict (default), ignore)
  if (trailingSlashOption == 'ignore') {
    // remove trailing / from the route path and URL path
    if(urlPath.endsWith('/')) {
      urlPath = urlPath.substring(0, urlPath.length-1);//TODO
    }
    if(routePath.endsWith('/') && !isRegExp) {
      routePath = routePath.substring(0, urlPath.length-1);
    }
  }

  // test regular expressions
  if (isRegExp) {
    return testRegExString(routePath, urlPath);
  }

  // if the urlPath is an exact match or '*' then the route is a match
  if (routePath == urlPath || routePath == '*') {
    return true;
  }

  // look for wildcards
  if (routePath.indexOf('*') == -1 && routePath.indexOf(':') == -1) {
    // no wildcards and we already made sure it wasn't an exact match so the test fails
    return false;
  }

  // example urlPathSegments = ['', example', 'path']
  List<String> urlPathSegments = urlPath.split('/');

  // example routePathSegments = ['', 'example', '*']
  List<String> routePathSegments = routePath.split('/');

  // there must be the same number of path segments or it isn't a match
  if (urlPathSegments.length != routePathSegments.length) {
    return false;
  }

  // check equality of each path segment
  for (int i = 0; i < routePathSegments.length; i++) {
    // the path segments must be equal, be a wildcard segment '*', or be a path parameter like ':id'
    String routeSegment = routePathSegments[i];
    if (routeSegment != urlPathSegments[i] && routeSegment != '*' && !routeSegment.startsWith(':')) {
      // the path segment wasn't the same string and it wasn't a wildcard or parameter
      return false;
    }
  }

  // nothing failed. the route matches the URL.
  return true;
}

  // routeArguments(routePath, urlPath, search, isRegExp) - Gets the path variables and query parameter values from the URL
Map routeArguments(String routePath, String urlPath, String search, bool isRegExp, bool autoTypecast) {
  Map args = {};

  // regular expressions can't have path variables
  if (!isRegExp) {
    // example urlPathSegments = ['', example', 'path']
    List<String> urlPathSegments = urlPath.split('/');

    // example routePathSegments = ['', 'example', '*']
    List<String> routePathSegments = routePath.split('/');

    // get path variables
    // urlPath '/customer/123'
    // routePath '/customer/:id'
    // parses id = '123'
    for (int index = 0; index < routePathSegments.length; index++) {
      String routeSegment = routePathSegments[index];
      if (routeSegment.startsWith(':')) {
        args[routeSegment.substring(1)] = urlPathSegments[index];
      }
    }
  }

  List<String> queryParameters = search.substring(1).split('&');
  // split() on an empty string has a strange behavior of returning [''] instead of []
  if (queryParameters.length == 1 && queryParameters[0] == '') {
    queryParameters = [];
  }
  for (int i = 0; i < queryParameters.length; i++) {
    String queryParameter = queryParameters[i];
    List<String> queryParameterParts = queryParameter.split('=');
    args[queryParameterParts[0]] = queryParameterParts.sublist(1, queryParameterParts.length - 1).join('=');//TODO
  }

  if (autoTypecast) {
    // parse the arguments into unescaped strings, numbers, or booleans
    for (String arg in args.keys) {
      args[arg] = typecast(args[arg]);
    }
  }

  return args;
}

  // typecast(value) - Typecast the string value to an unescaped string, number, or boolean
typecast (String value) {
  // bool
  if (value == 'true') {
    return true;
  }
  if (value == 'false') {
    return false;
  }

  // number
  if (value != '' && !value.startsWith('0')) {
    int number = int.parse(value, onError: (string) => 0);
    if (number != 0) {
      return number;
    }
  }

  // string
  return Uri.decodeComponent(value);
}

  // testRegExString(pattern, value) - Parse HTML attribute path="/^\/\w+\/\d+$/i" to a regular
  // expression `new RegExp('^\/\w+\/\d+$', 'i')` and test against it.
  //
  // note that 'i' is the only valid option. global 'g', multiline 'm', and sticky 'y' won't be valid matchers for a path.
bool testRegExString(String pattern, String value) {
  if (!pattern.startsWith('/')) {
    // must start with a slash
    return false;
  }
  pattern = pattern.substring(1);
  var options = '';
  if (pattern.endsWith('/')) {
    pattern = pattern.substring(0, -1);
  }
  else if (pattern.endsWith('/i')) {
    pattern = pattern.substring(0, -2);
    options = 'i';
  }
  else {
    // must end with a slash followed by zero or more options
    return false;
  }
  return new RegExp(r"$pattern").hasMatch(value);//TODO
}