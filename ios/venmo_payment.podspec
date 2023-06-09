#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint venmo_payment.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'venmo_payment'
  s.version          = '0.0.1'
  s.summary          = 'Flutter Plugin for sending Venmo Requests'
  s.description      = <<-DESC
Flutter Plugin for sending Venmo Requests
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Unofficial-Venmo-iOS-SDK', '1.3.6'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
