// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

/// Represents user data returned from an identity provider.
class UserInfo {
  final Map<String, dynamic> _data;
  UserInfo._(this._data);

  /// The provider identifier.
  String get providerId => _data['providerId'];

  /// The provider’s user ID for the user.
  String get uid => _data['uid'];

  /// The name of the user.
  String get displayName => _data['displayName'];

  /// The URL of the user’s profile photo.
  String get photoUrl => _data['photoUrl'];

  /// The user’s email address.
  String get email => _data['email'];

  @override
  String toString() {
    return '$runtimeType($_data)';
  }
}

/// Represents a user.
class FirebaseUser extends UserInfo {
  final List<UserInfo> providerData;
  FirebaseUser._(Map<String, dynamic> data)
      : providerData = data['providerData']
            .map((Map<String, dynamic> info) => new UserInfo._(info))
            .toList(),
        super._(data);

  // Returns true if the user is anonymous; that is, the user account was
  // created with signInAnonymously() and has not been linked to another
  // account.
  bool get isAnonymous => _data['isAnonymous'];

  /// Returns true if the user's email is verified.
  bool get isEmailVerified => _data['isEmailVerified'];

  /// Obtains the id token for the current user, forcing a [refresh] if desired.
  ///
  /// Completes with an error if the user is signed out.
  Future<String> getToken({bool refresh: false}) {
    return FirebaseAuth.channel.invokeMethod('getToken', <String, bool>{
      'refresh': refresh,
    });
  }

  @override
  String toString() {
    return '$runtimeType($_data)';
  }
}

class FirebaseAuth {
  @visibleForTesting
  static const MethodChannel channel = const MethodChannel(
    'plugins.flutter.io/firebase_auth',
  );

  /// Provides an instance of this class corresponding to the default app.
  ///
  /// TODO(jackson): Support for non-default apps.
  static FirebaseAuth instance = new FirebaseAuth._();

  FirebaseAuth._();

  /// Asynchronously creates and becomes an anonymous user.
  ///
  /// If there is already an anonymous user signed in, that user will be
  /// returned instead. If there is any other existing user signed in, that
  /// user will be signed out.
  ///
  /// Will throw a PlatformException if
  /// FIRAuthErrorCodeOperationNotAllowed - Indicates that anonymous accounts are not enabled. Enable them in the Auth section of the Firebase console.
  /// See FIRAuthErrors for a list of error codes that are common to all API methods.
  Future<FirebaseUser> signInAnonymously() async {
    final Map<String, dynamic> data =
        await channel.invokeMethod('signInAnonymously');
    _currentUser = new FirebaseUser._(data);
    return _currentUser;
  }


  /// Tries to create a new user account with the given [email] and [password].
  ///
  /// If successful, it also signs the user in into the app.
  Future<FirebaseUser> createUserWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null);
    assert(password != null);
    final Map<String, dynamic> data = await channel.invokeMethod(
      'createUserWithEmailAndPassword',
      <String, String>{
        'email': email,
        'password': password,
      },
    );
    _currentUser = new FirebaseUser._(data);
    return _currentUser;
  }

  /// Tries to sign in a user with the given [email] and [password].
  Future<FirebaseUser> signInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null);
    assert(password != null);
    final Map<String, dynamic> data = await channel.invokeMethod(
      'signInWithEmailAndPassword',
      <String, String>{
        'email': email,
        'password': password,
      },
    );
    _currentUser = new FirebaseUser._(data);
    return _currentUser;
  }

  /// Tries to sign in a user with a Google Sign-In ID token and access token.
  Future<FirebaseUser> signInWithGoogle({
    @required String idToken,
    @required String accessToken,
  }) async {
    assert(idToken != null);
    assert(accessToken != null);
    final Map<String, dynamic> data = await channel.invokeMethod(
      'signInWithGoogle',
      <String, String>{
        'idToken': idToken,
        'accessToken': accessToken,
      },
    );
    _currentUser = new FirebaseUser._(data);
    return _currentUser;
  }

  /// Initiates phone authentication by sending an SMS code to [phoneNumber].
  ///
  /// Ask the user for the code and use a [Completer] to generate a [Future]
  /// that completes to the code.
  ///
  /// On Android, this method can sign in automatically without waiting for
  /// the code to be entered in some cases:
  /// 1 - Instant verification. In some cases the phone number can be instantly
  ///     verified without needing to send or enter a verification code.
  /// 2 - Auto-retrieval. On some devices Google Play services can automatically
  ///     detect the incoming verification SMS and perform verification without
  ///     user action.
  Future<FirebaseUser> signInWithPhone({
    @required String phoneNumber,
    @required Future<String> verificationCode,
  }) async {
    assert(phoneNumber != null);
    assert(verificationCode != null);
    Map<String, dynamic> data = await channel.invokeMethod(
      'signInWithPhone',
      phoneNumber
    );
    final String verificationId = data['verificationId'];
    if (verificationId != null) {
      data = await channel.invokeMethod(
        'signInWithVerificationCode',
        <String, String>{
          'verificationId': verificationId,
          'verificationCode': await verificationCode,
        },
      );
    }
    _currentUser = new FirebaseUser._(data);
    return _currentUser;
  }


  Future<Null> signOut() async {
    await channel.invokeMethod("signOut");
    _currentUser = null;
  }

  FirebaseUser _currentUser;

  /// Synchronously gets the cached current user, or `null` if there is none.
  FirebaseUser get currentUser => _currentUser;
}
