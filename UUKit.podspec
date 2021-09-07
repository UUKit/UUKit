#
# Be sure to run `pod lib lint UUKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                  = 'UUKit'
  s.version               = '0.0.10'
  s.summary               = 'iOS基础库.'
  s.homepage              = 'https://github.com/UUKit/UUKit'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'uxiu.me' => 'mail@uxiu.me' }
  s.platform              = :ios
  s.swift_versions        = ['5.0', '5.1', '5.2', '5.3', '5.4']
  s.source                = { :git => 'https://github.com/UUKit/UUKit.git',
                              :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files          = 'UUKit/Classes/**/*'
  
  
  # s.resource_bundles = {
  #   'UUKit' => ['UUKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
