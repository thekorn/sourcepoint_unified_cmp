#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'sourcepoint_unified_cmp_ios'
  s.version          = '0.0.1'
  s.summary          = 'An iOS implementation of the sourcepoint_unified_cmp plugin.'
  s.description      = <<-DESC
  An iOS implementation of the sourcepoint_unified_cmp plugin.
                       DESC
  s.homepage         = 'https://github.com/thekorn/sourcepoint_unified_cmp'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { 'Markus Korn' => 'markus.korn@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'ConsentViewController', '7.7.2'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
