# FlutterFire

FlutterFire is a set of [Flutter plugins](https://flutter.io/platform-plugins/)
that enable Flutter apps to use one or more [Firebase](https://firebase.google.com/) services. You can follow an example that shows how to use these plugins in the [Firebase for Flutter](https://codelabs.developers.google.com/codelabs/flutter-firebase/index.html#0) codelab.

[Flutter](https://flutter.io) is a new mobile app SDK to help developers and
designers build modern mobile apps for iOS and Android.
  
*Note*: These plugins are part of the [Flutter open source project](https://github.com/flutter). 
The plugins are still under development, and some APIs might not be available yet. 
[Feedback](https://github.com/flutter/flutter/issues) and [Pull Requests](https://github.com/flutter/plugins/pulls) are most welcome!
 
## Available FlutterFire plugins

| Plugin | Version | Firebase feature | Source code |
|---|---|---|---|
| [cloud_firestore][firestore_pub] | ![pub package][firestore_badge] | [Cloud Firestore][firestore_product] | [`packages/cloud_firestore`][firestore_code] | ![admob_issues_badge][admob_issues]
| [cloud_functions][functions_pub] | ![pub package][functions_badge] | [Cloud Functions][functions_product] | [`packages/cloud_functions`][functions_code] | ![admob_issues_badge][admob_issues]
| [firebase_admob][admob_pub] | ![pub package][admob_badge] | [Firebase AdMob][admob_product] | [`packages/firebase_admob`][admob_code] | ![admob_issues_badge][admob_issues]
| [firebase_analytics][analytics_pub] | ![pub package][analytics_badge] | [Firebase Analytics][analytics_product] | [`packages/firebase_analytics`][analytics_code] | ![analytics_issues_badge][analytics_issues]
| [firebase_auth][auth_pub] | ![pub package][auth_badge] | [Firebase Authentication][auth_product] | [`packages/firebase_auth`][auth_code] | ![auth_issues_badge][auth_issues]
| [firebase_core][core_pub] | ![pub package][core_badge] | [Firebase Core][core_product] | [`packages/firebase_core`][core_code] | ![core_issues_badge][core_issues]
| [firebase_crashlytics][crash_pub] | ![pub package][crash_badge] | [Firebase Crashlytics][crash_product] | [`packages/firebase_crashlytics`][crash_code] | ![crash_issues_badge][crash_issues]
| [firebase_database][database_pub] | ![pub package][database_badge] | [Firebase Realtime Database][database_product] | [`packages/firebase_database`][database_code] | ![database_issues_badge][database_issues]
| [firebase_dynamic_links][dynamic_links_pub] | ![pub package][dynamic_links_badge] | [Firebase Dynamic Links][dynamic_links_product] | [`packages/firebase_dynamic_links`][dynamic_links_code] | ![dynamic_links_issues_badge][dynamic_links_issues]
| [firebase_messaging][messaging_pub] | ![pub package][messaging_badge] | [Firebase Cloud Messaging][messaging_product] | [`packages/firebase_messaging`][messaging_code] | ![messaging_issues_badge][messaging_issues]
| [firebase_ml_vision][ml_vision_pub] | ![pub package][ml_vision_badge] | [Firebase ML Kit][ml_vision_product] | [`packages/firebase_ml_vision`][ml_vision_code] | ![ml_vision_issues_badge][ml_vision_issues]
| [firebase_performance][performance_pub] | ![pub package][performance_badge] | [Firebase Performance Monitoring][performance_product] | [`packages/firebase_performance`][performance_code] | ![performance_issues_badge][performance_issues]
| [firebase_remote_config][remote_config_pub] | ![pub package][remote_config_badge] | [Firebase Remote Config][remote_config_product] | [`packages/firebase_remote_config`][remote_config_code] | ![remote_config_issues_badge][remote_config_issues]
| [firebase_storage][storage_pub] | ![pub package][storage_badge] | [Firebase Cloud Storage][storage_product] | [`packages/firebase_storage`][storage_code] | ![storage_issues_badge][storage_issues]

[admob_pub]: https://pub.dartlang.org/packages/firebase_admob
[admob_product]: https://firebase.google.com/docs/admob/
[admob_code]: https://github.com/flutter/plugins/tree/master/packages/firebase_admob
[admob_badge]: https://img.shields.io/pub/v/firebase_admob.svg
[admob_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+firebase_admob%22
[admob_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20admob.svg

[analytics_pub]: https://pub.dartlang.org/packages/firebase_analytics
[analytics_product]: https://firebase.google.com/products/analytics/
[analytics_code]: https://github.com/flutter/plugins/tree/master/packages/firebase_analytics
[analytics_badge]: https://img.shields.io/pub/v/firebase_analytics.svg
[analytics_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+firebase_analytics%22
[analytics_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20analytics.svg

[auth_pub]: https://pub.dartlang.org/packages/firebase_auth
[auth_product]: https://firebase.google.com/products/auth/
[auth_code]: https://github.com/flutter/plugins/tree/master/packages/firebase_auth
[auth_badge]: https://img.shields.io/pub/v/firebase_auth.svg
[auth_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+firebase_auth%22
[auth_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20firebase_auth.svg

[core_pub]: https://pub.dartlang.org/packages/firebase_core
[core_product]: https://firebase.google.com/
[core_code]: https://github.com/flutter/plugins/tree/master/packages/firebase_core
[core_badge]: https://img.shields.io/pub/v/firebase_core.svg
[core_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+firebase_core%22
[core_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20firebase_core.svg

[crash_pub]: https://pub.dartlang.org/packages/firebase_crashlytics
[crash_product]: https://firebase.google.com/products/crashlytics/
[crash_code]: https://github.com/flutter/plugins/tree/master/packages/firebase_crashlytics
[crash_badge]: https://img.shields.io/pub/v/firebase_crashlytics.svg
[crash_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+firebase_crashlytics%22
[crash_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20firebase_crashlytics.svg

[database_pub]: https://pub.dartlang.org/packages/firebase_database
[database_product]: https://firebase.google.com/products/database/
[database_code]: https://github.com/flutter/plugins/tree/master/packages/firebase_database
[database_badge]: https://img.shields.io/pub/v/firebase_database.svg
[database_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+firebase_database%22
[database_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20firebase_database.svg

[dynamic_links_pub]: https://pub.dartlang.org/packages/firebase_dynamic_links
[dynamic_links_product]: https://firebase.google.com/products/dynamic-links/
[dynamic_links_code]: https://github.com/flutter/plugins/tree/master/packages/firebase_dynamic_links
[dynamic_links_badge]: https://img.shields.io/pub/v/firebase_dynamic_links.svg
[dynamic_links_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+firebase_dynamic_links%22
[dynamic_links_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20firebase_dynamic_links.svg

[firestore_pub]: https://pub.dartlang.org/packages/cloud_firestore
[firestore_product]: https://firebase.google.com/products/firestore/
[firestore_code]: https://github.com/flutter/plugins/tree/master/packages/cloud_firestore
[firestore_badge]: https://img.shields.io/pub/v/cloud_firestore.svg
[firestore_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+cloud_firestore%22
[firestore_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20cloud_firestore.svg

[functions_pub]: https://pub.dartlang.org/packages/cloud_functions
[functions_product]: https://firebase.google.com/products/functions/
[functions_code]: https://github.com/flutter/plugins/tree/master/packages/cloud_functions
[functions_badge]: https://img.shields.io/pub/v/cloud_functions.svg
[functions_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+cloud_functions%22
[functions_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20cloud_functions.svg

[messaging_pub]: https://pub.dartlang.org/packages/firebase_messaging
[messaging_product]: https://firebase.google.com/products/cloud-messaging/
[messaging_code]: https://github.com/flutter/plugins/tree/master/packages/firebase_messaging
[messaging_badge]: https://img.shields.io/pub/v/firebase_messaging.svg
[messaging_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+firebase_messaging%22
[messaging_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20cloud_messaging.svg

[ml_vision_pub]: https://pub.dartlang.org/packages/firebase_ml_vision
[ml_vision_product]: https://firebase.google.com/products/ml-kit/
[ml_vision_code]: https://github.com/flutter/plugins/tree/master/packages/firebase_ml_vision
[ml_vision_badge]: https://img.shields.io/pub/v/firebase_ml_vision.svg
[ml_vision_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+firebase_ml_vision%22
[ml_vision_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20firebase_ml_vision.svg

[performance_pub]: https://pub.dartlang.org/packages/firebase_performance
[performance_product]: https://firebase.google.com/products/performance/
[performance_code]: https://github.com/flutter/plugins/tree/master/packages/firebase_performance
[performance_badge]: https://img.shields.io/pub/v/firebase_performance.svg
[performance_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+firebase_performance%22
[performance_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20firebase_performance.svg

[remote_config_pub]: https://pub.dartlang.org/packages/firebase_remote_config
[remote_config_product]: https://firebase.google.com/products/remote-config/
[remote_config_code]: https://github.com/flutter/plugins/tree/master/packages/firebase_remote_config
[remote_config_badge]: https://img.shields.io/pub/v/firebase_remote_config.svg
[remote_config_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+remote_config%22
[remote_config_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20firebase_remote_config.svg

[storage_pub]: https://pub.dartlang.org/packages/firebase_storage
[storage_product]: https://firebase.google.com/products/storage/
[storage_code]: https://github.com/flutter/plugins/tree/master/packages/firebase_storage
[storage_badge]: https://img.shields.io/pub/v/firebase_storage.svg
[storage_issues]: https://github.com/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22p%3A+firebase_storage%22
[storage_issues_badge]: https://img.shields.io/github/issues-raw/flutter/flutter/p:%20firebase_storage.svg
