// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:test/test.dart';

import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';

void main() {
  group('$FirebaseAuth', () {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final List<MethodCall> log = <MethodCall>[];
    bool verifyPhoneAutomatically;

    const String kMockProviderId = 'firebase';
    const String kMockUid = '12345';
    const String kMockDisplayName = 'Flutter Test User';
    const String kMockPhotoUrl = 'http://www.example.com/';
    const String kMockEmail = 'test@example.com';
    const String kMockPassword = 'passw0rd';
    const String kMockIdToken = '12345';
    const String kMockAccessToken = '67890';
    const String kMockPhoneNumber = '206-555-5555';
    const String kMockVerificationId = '99999';
    const String kMockVerificationCode = '987654';

    const Map<String, dynamic> kMockUser = const <String, dynamic>{
      'isAnonymous': true,
      'isEmailVerified': false,
      'providerData': const <Map<String, String>>[
        const <String, String>{
          'providerId': kMockProviderId,
          'uid': kMockUid,
          'displayName': kMockDisplayName,
          'photoUrl': kMockPhotoUrl,
          'email': kMockEmail,
        },
      ],
    };

    setUp(() {
      log.clear();
      verifyPhoneAutomatically = false;
      FirebaseAuth.channel.setMockMethodCallHandler((MethodCall call) async {
        log.add(call);
        switch (call.method) {
          case "getToken":
            return kMockIdToken;
          case "signInWithPhone":
            if (verifyPhoneAutomatically)
              return kMockUser;
            return { 'verificationId': kMockVerificationId };
          default:
            return kMockUser;
        }
      });
    });
    void verifyUser(FirebaseUser user) {
      expect(user, isNotNull);
      expect(user, auth.currentUser);
      expect(user.isAnonymous, isTrue);
      expect(user.isEmailVerified, isFalse);
      expect(user.providerData.length, 1);
      final UserInfo userInfo = user.providerData[0];
      expect(userInfo.providerId, kMockProviderId);
      expect(userInfo.uid, kMockUid);
      expect(userInfo.displayName, kMockDisplayName);
      expect(userInfo.photoUrl, kMockPhotoUrl);
      expect(userInfo.email, kMockEmail);
    }

    test('signInAnonymously', () async {
      final FirebaseUser user = await auth.signInAnonymously();
      verifyUser(user);
      expect(await user.getToken(), equals(kMockIdToken));
      expect(await user.getToken(refresh: true), equals(kMockIdToken));
      expect(
        log,
        equals(<MethodCall>[
          const MethodCall('signInAnonymously'),
          const MethodCall('getToken', const <String, bool>{'refresh': false}),
          const MethodCall('getToken', const <String, bool>{'refresh': true}),
        ]),
      );
    });

    test('createUserWithEmailAndPassword', () async {
      final FirebaseUser user = await auth.createUserWithEmailAndPassword(
        email: kMockEmail,
        password: kMockPassword,
      );
      verifyUser(user);
      expect(
        log,
        equals(<MethodCall>[
          new MethodCall('createUserWithEmailAndPassword', <String, String>{
            'email': kMockEmail,
            'password': kMockPassword,
          })
        ]),
      );
    });

    test('signInWithEmailAndPassword', () async {
      final FirebaseUser user = await auth.signInWithEmailAndPassword(
        email: kMockEmail,
        password: kMockPassword,
      );
      verifyUser(user);
      expect(
        log,
        equals(<MethodCall>[
          new MethodCall('signInWithEmailAndPassword', <String, String>{
            'email': kMockEmail,
            'password': kMockPassword,
          })
        ]),
      );
    });

    test('signInWithGoogle', () async {
      final FirebaseUser user = await auth.signInWithGoogle(
        idToken: kMockIdToken,
        accessToken: kMockAccessToken,
      );
      verifyUser(user);
      expect(
        log,
        equals(<MethodCall>[
          new MethodCall('signInWithGoogle', <String, String>{
            'idToken': kMockIdToken,
            'accessToken': kMockAccessToken,
          })
        ]),
      );
    });

    group('signInWithPhone', () {
      test('manual', () async {
        final FirebaseUser user = await auth.signInWithPhone(
          phoneNumber: kMockPhoneNumber,
          verificationCode: new Future<String>.value(kMockVerificationCode),
        );
        verifyUser(user);
        expect(
          log,
          equals(<MethodCall>[
            const MethodCall('signInWithPhone', kMockPhoneNumber),
            const MethodCall('signInWithVerificationCode', const <String, String>{
              'verificationId': kMockVerificationId,
              'verificationCode': kMockVerificationCode,
            })
          ]),
        );
      });

      test('automatic', () async {
        verifyPhoneAutomatically = true;
        final FirebaseUser user = await auth.signInWithPhone(
          phoneNumber: kMockPhoneNumber,
          verificationCode: new Future(() {
            throw 'automatic phone auth failed';
          }),
        );
        verifyUser(user);
        expect(
          log,
          equals(<MethodCall>[
            const MethodCall('signInWithPhone', kMockPhoneNumber),
          ]),
        );
      });
    });
  });
}
