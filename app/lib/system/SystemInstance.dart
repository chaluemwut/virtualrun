
class SystemInstance {
  static final SystemInstance _instance = SystemInstance._internal();

  factory SystemInstance(){
    return _instance;
  }
  SystemInstance._internal() {}

  String _token;
  int _userId;
  int _aid;
  String _userName;

  String get token => _token;

  set token(String value) {
    _token = value;
  }

  int get userId => _userId;

  set userId(int value) {
    _userId = value;
  }
  int get aid => _aid;

  set aid(int value){
    _aid = value;
  }
  String get userName => _userName;
  set userName(String value){
    _userName = value;
  }
}