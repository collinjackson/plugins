// Copyright 2018, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of cloud_firestore;

class FirestoreSettings {

  const FirestoreSettings({
    this.host,
    this.sslEnabled,
    this.persistenceEnabled,
  });

  /// The hostname to connect to.
  final String host;

  /// Whether to use SSL when connecting.
  final bool sslEnabled;

  /// Set to false to disable local persistent storage.
  final bool persistenceEnabled;
}
