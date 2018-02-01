// Copyright 2018, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of firebase_remote_config;

class RemoteConfigValue {
  const RemoteConfigValue._(this.value, this.source);

  final dynamic value;
  final RemoteConfigSource source;

  static const RemoteConfigValue _empty = const RemoteConfigValue._(
    null,
    RemoteConfigSource.staticSource,
  );
}
