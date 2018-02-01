// Copyright 2018, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of firebase_remote_config;

class RemoteConfig {
  @visibleForTesting
  RemoteConfig() {
    Completer<Null> completer;
    // Use invokeMethod on _instance to populate _remoteValues
    // then call completer.complete();
    initialized = completer.future;
  }

  @visibleForTesting
  static const MethodChannel channel = const MethodChannel(
    'plugins.flutter.io/firebase_remote_config',
  );

  static final RemoteConfig _instance = new RemoteConfig();

  // Future that completes when this RemoteConfig is ready to use
  @visibleForTesting
  Future<Null> initialized;

  /// Obtains the RemoteConfig instance shared throughout your app.
  ///
  /// This singleton object contains the complete set of Remote Config parameter
  /// values available to the app, including the Active Config and Default
  /// Config. This object also caches values fetched from the Remote Config
  /// Server until they are copied to the Active Config by calling
  /// activateFetched. When you fetch values from the Remote Config Server using
  /// the default Firebase namespace service, you should use this class method
  /// to create a shared instance of the RemoteConfig object to ensure that
  /// your app will function properly with the Remote Config Server and the
  /// Firebase service.
  static Future<RemoteConfig> getInstance() async {
    await _instance.initialized;
    return _instance;
  }

  Map<String, RemoteConfigValue> _remoteValues;
  Map<String, RemoteConfigValue> _defaultValues = <String, RemoteConfigValue>{};
  RemoteConfigFetchStatus _lastFetchStatus;

  /// Last fetch status. The status can be any enumerated value from
  /// FIRRemoteConfigFetchStatus.
  RemoteConfigFetchStatus get lastFetchStatus => _lastFetchStatus;

  /// Fetches Remote Config data and sets a duration that specifies how long
  /// config data lasts. Call activateFetched to make fetched data available to
  /// your app.
  Future<Null> fetch({ Duration expirationDuration }) async {
    // Call fetch() on the native side, returning _lastFetchStatus
    // Method should complete after setting _lastFetchStatus on the Dart side
  }

  /// Applies Fetched Config data to the Active Config, causing updates to the
  /// behavior and appearance of the app to take effect (depending on how config
  /// data is used in the app). Returns true if there was a Fetched Config, and
  /// it was activated. Returns false if no Fetched Config was found, or the
  /// Fetched Config was already activated.
  Future<Null> activateFetched() async {
    // Needs to be implemented
    // On the native side:
    // * Call activateFetched, if it returns false return early
    // * Otherwise allKeysFromSource to get the full list of keys
    // * Put all the remote and default values into Map
    // * Return remoteValues, defaultValues to the Dart side and save them there
    // * Complete Future indicating that remoteValues/defaultValues are
    //   ready for use.
  }

  Future<Null> setDefaults(Map<String, dynamic> defaults) {
    // This method should NOT be async because we want the Dart side change
    // to take effect immediately
    _defaultValues = defaults;

    // TODO:
    // * Push the change to the native side
    // * Complete the Future when the native side is done.
    return null;
  }

  /// Enables access to configuration values by using object subscripting
  /// syntax. This is used to get the config value of the default namespace.
  RemoteConfigValue operator[](String key) {
    return _remoteValues[key] ?? _defaultValues[key] ?? RemoteConfigValue._empty;
  }

  /// Gets the config value of a given namespace.
  ///
  /// This method is asynchronous because there's no way to enumerate
  /// non-default namespaces.
  Future<RemoteConfigValue> configValue(String key, { String namespace }) async {
    if (namespace == null)
      return this[key];
    final Map<String, dynamic> result = await channel.invokeMethod('RemoteConfig#configValue', {
      'key': key,
      'namespace': namespace,
    });
    return new RemoteConfigValue._(
      result['value'],
      RemoteConfigSource.values.firstWhere(
        (RemoteConfigSource source) => source.toString() == result['source'],
      ),
    );
  }

  RemoteConfigValue defaultValue(String key) => _defaultValues[key];
}
