import 'package:polymer/polymer.dart';

@CustomTag('app-route')
class AppRoute extends PolymerElement {
  @published String path = "/";
  @published String imp;
  @published String elem;
  @published bool template = false;
  @published bool regex = false;
  @published String redirect;
  bool transitionAnimationInProgress = false;
  @published bool active = false;
  @published bool bindRouter;

  AppRoute.created() : super.created();

  toString() => "path: $path, imp: $imp, elem: $elem, template: $template, regex: $regex, redirect: $redirect, transitionAnimationInProgress: $transitionAnimationInProgress, active: $active, bindRouter: $bindRouter";
}

  // <app-route path="/path" [imp="/page/cust-el.html"] [elem="cust-el"] [template]></app-route>