class AllForMomsAppModel {
  var _isAuth = false;
  bool get isAuth => _isAuth;

  void changeAuth() {
    _isAuth = !_isAuth;
  }
}
