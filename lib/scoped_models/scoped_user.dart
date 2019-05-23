import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart';

import '../models/expression.dart';
import '../models/sphere.dart';
import '../models/pack.dart';
import '../models/user.dart';
import '../models/setUser.dart';

class ScopedUser extends Model {
  String _userAddress = '';
  String _username = '';
  String _firstName = '';
  String _lastName = '';
  String _password = '';
  String _bio = '';
  String _profilePicture = '';

  List<Expression> _collectiveExpressions = [];
  List<Sphere> _spheres = Sphere.fetchAll();
  List<Pack> _packs = Pack.fetchAll();

  // create user
  void createUser(username, firstName, lastName, profilePicture, bio) async {
    String url = 'http://127.0.0.1:8888';
    Map<String, String> headers = {"Content-type": "application/json"};
    final body =
        '{"jsonrpc":"2.0", "id": "0", "method": "call", "params": {"instance_id":"test-instance", "zome": "core", "function": "create_user", "args": {"user_data": {"username": "' + username + '", "first_name":"' + firstName + '", "last_name":"' + lastName + '", "profile_picture":"' + profilePicture + '", "bio":"' + bio + '"}}}}';

    Response response = await post(url, headers: headers, body: body);
    int statusCode = response.statusCode;
    // print(statusCode);

    var hellos = json.decode(response.body);
    // print(hellos);

    if (statusCode == 200) {
      User user = User.fromJson(hellos);

      _userAddress = user.result.ok.privateDen.entry.parent;
      print(_userAddress);

      setUsername(user.result.ok.username.usernameEntry.username);
      setFirstName(user.result.ok.profile.profileEntry.firstName);
      setLastName(user.result.ok.profile.profileEntry.lastName);
      setProfilePicture(user.result.ok.profile.profileEntry.profilePicture);      
      setBio(user.result.ok.profile.profileEntry.bio);
    } else {
      print(hellos);
    }
  }  

  void setUser(usernameAddress) async {  
    String url = 'http://127.0.0.1:8888';
    Map<String, String> headers = {"Content-type": "application/json"};

    // get username from address
    final usernameBody =
        '{"jsonrpc":"2.0", "id": "0", "method": "call", "params": {"instance_id":"test-instance", "zome": "core", "function": "get_username_from_address", "args": {"username_address": "' + usernameAddress + '"}}}';
    
    Response usernameResponse = await post(url, headers: headers, body: usernameBody);

    // get profile from address
    final profileBody =
        '{"jsonrpc":"2.0", "id": "0", "method": "call", "params": {"instance_id":"test-instance", "zome": "core", "function": "get_user_profile_from_address", "args": {"username_address": "' + usernameAddress + '"}}}';    

    Response profileResponse = await post(url, headers: headers, body: profileBody);

    SetUserUsername setUserUsername = SetUserUsername.fromJson(json.decode(usernameResponse.body));
    SetUserProfile setUserProfile = SetUserProfile.fromJson(json.decode(profileResponse.body));
    _username = setUserUsername.result.ok.username;
    _firstName = setUserProfile.result.ok.firstName;
    _lastName = setUserProfile.result.ok.lastName;
    _profilePicture = setUserProfile.result.ok.profilePicture;
    _bio = setUserProfile.result.ok.bio;

  }


  // get dens
  void getDens() async {
    String url = 'http://127.0.0.1:8888';
    Map<String, String> headers = {"Content-type": "application/json"};
    final body =
        '{"jsonrpc":"2.0", "id": "0", "method": "call", "params": {"instance_id":"test-instance", "zome": "core", "function": "user_dens", "function":"user_dens", "args": {"username_address":"hellos"}}}';

    Response response = await post(url, headers: headers, body: body);
    int statusCode = response.statusCode;
    print(statusCode);
  }
  
  // get pack
  void getPack() async {
    String url = 'http://127.0.0.1:8888';
    Map<String, String> headers = {"Content-type": "application/json"};
    final json =
        '{"jsonrpc":"2.0", "id": "0", "method": "call", "params": {"instance_id":"test-instance", "zome": "core", "function": "user_pack", "function":"user_dens", "args": {"username_address":"hellos"}}}';

    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    print(statusCode);
    print(response.body);
  }  

  // set username for member
  void setUsername(username) {
    _username = username; 

    notifyListeners();
  }

  // set first for member
  void setFirstName(firstName) {
    _firstName = firstName;

    notifyListeners();
  }

  // set last name for member
  void setLastName(lastName) {
    _lastName = lastName;

    notifyListeners();
  }

  // set password for member (temporary function)
  void setPassword(password) {
    _password = password;

    notifyListeners();
  }

  // set bio for member
  void setBio(bio) {
    _bio = bio;

    notifyListeners();
  }

  // set profile picture for member
  void setProfilePicture(profilePicture) {
    _profilePicture = profilePicture;

    notifyListeners();
  }

  // Set collective expressions for member
  void setCollectiveExpressions() {
    _collectiveExpressions = Expression.fetchAll();
  }

  // Set following list for member
  setFollowingExpressions() {
    return;
  }

  // Set perspectives for member
  setPerspectives() {
    return;
  }

  // set spheres for member
  setSpheres() {
    return;
  }

  // set packs for member
  setPacks() {
    return;
  }

  // getters
  get username {
    return _username;
  }

  get firstName {
    return _firstName;
  }

  get lastName {
    return _lastName;
  }

  get password {
    return _password;
  }

  get bio {
    return _bio;
  }

  get profilePicture {
    return _profilePicture;
  }

  List get collectiveExpressions {
    return List.from(_collectiveExpressions);
  }

  List get spheres {
    return _spheres;
  }

  List get packs {
    return _packs;
  }
}
