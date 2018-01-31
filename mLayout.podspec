#
# Be sure to run `pod lib lint mLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'mLayout'
  s.version          = '0.1.2'
  s.summary          = 'Quick using AutoLayout tools.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/nick6969/AutoLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hawhaw.ya@gmail.com' => 'hawhaw.ya@gmail.com' }
  s.source           = { :git => 'https://github.com/nick6969/AutoLayout.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.swift_version    = "3.2"

  s.source_files = 'mLayout/Classes/**/*'
  
end