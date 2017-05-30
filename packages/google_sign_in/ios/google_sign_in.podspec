#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'google_sign_in'
  s.version          = '0.0.1'
  s.summary          = 'Google Sign-In plugin for Flutter'
  s.description      = <<-DESC
Enables Google Sign-In in Flutter apps.
                       DESC
  s.homepage         = 'https://github.com/flutter/plugins/tree/master/packages/google_sign_in'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Flutter Team' => 'flutter-dev@googlegroups.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.pod_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PODS_ROOT)/GoogleSignIn/Frameworks' }
  # s.module_map = "Pods/GoogleSignIn/Frameworks/GoogleSignIn.framework/Modules/module.modulemap"
  s.ios.deployment_target = '8.0'
  s.frameworks = 'GoogleSignIn'
  s.dependency 'Flutter'
  s.dependency 'GoogleSignIn', '~> 4.0'
end
