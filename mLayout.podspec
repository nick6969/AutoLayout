#
# Be sure to run `pod lib lint mLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'mLayout'
  s.version          = '1.0.0'
  s.summary          = 'Quick using AutoLayout tools.'
  s.description      = ""

  s.homepage         = 'https://github.com/nick6969/AutoLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CHIH HAO LIN' => 'hawhaw.ya@gmail.com' }
  s.source           = { :git => 'https://github.com/nick6969/AutoLayout.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.swift_version    = '5.0'

  s.source_files = 'mLayout/Classes/**/*'
  
end
