// Copyright 2017, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:firebase_core/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$RemoteConfig', () {
    final List<MethodCall> log = <MethodCall>[];

    setUp(() async {
      RemoteConfig.channel
          .setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'RemoteConfig#initialize':
            return <Map<String, dynamic>>[
              <String, dynamic>{
                'defaultSource': { 'foo': 'bar' },
                'lastFetchStatus': 'noFetchYet',
              },
            ];
          case 'RemoteConfig#activateFetched':
            return <Map<String, dynamic>>[
              <String, dynamic>{
                'defaultSource': { 'foo': 'bar' },
                'remoteSource': { 'foo': 'baz' },
                'lastFetchStatus': 'succeeeded',
              },
            ];
          case 'RemoteConfig#fetch':
            return 'success';
          case 'RemoteConfig#setDefaults':
            return null;
          default:
            break;
        }
      });
      log.clear();
    });

    test('getInstance', () async {
      final RemoteConfig app = await RemoteConfig.getInstance();
      expect(
        log,
        <Matcher>[
          isMethodCall(
            'RemoteConfig#configure',
            arguments: <String, dynamic>{},
          ),
        ],
      );
    });

    test('fetch', () async {
      final RemoteConfig config = new RemoteConfig();
      await config.initialized;
      log.clear();
      expect(config.lastFetchStatus, equals(RemoteConfigFetchStatus.noFetchYet));
      await config.fetch();
      expect(
        log,
        <Matcher>[
          isMethodCall(
            'RemoteConfig#fetch',
            arguments: <String, dynamic>{},
          ),
        ],
      );
      expect(config.lastFetchStatus, equals(RemoteConfigFetchStatus.succeeded));
    });

    test('activateFetched', () async {
      final RemoteConfig config = new RemoteConfig();
      await config.initialized;
      log.clear();
      RemoteConfigValue fooValue = config.configValue('foo');
      expect(fooValue, equals(config['foo']));
      expect(fooValue.value, equals('bar'));
      expect(fooValue.source, equals(RemoteConfigSource.defaultSource));
      config.activateFetched();
      expect(
        log,
        <Matcher>[
          isMethodCall(
            'RemoteConfig#activateFetched',
            arguments: <String, dynamic>{},
          ),
        ],
      );
      fooValue = config.configValue('foo');
      expect(fooValue, equals(config['foo']));
      expect(fooValue.value, equals('baz'));
      expect(fooValue.source, equals(RemoteConfigSource.remoteSource));
    });
  });
}
