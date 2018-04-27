#
# Be sure to run `pod lib lint AnyCodable.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AnyCodable'
  s.version          = '0.1.0'
  s.summary          = 'Encodable, Decodable, and Codable'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Type-erased wrappers for Encodable, Decodable, and Codable values.
  DESC

  s.homepage         = 'https://github.com/Flight-School/AnyCodable'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mattt' => 'mattt' }
  s.source           = { :git => 'https://github.com/dulingkang/AnyCodable.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '4.1'
  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/AnyCodable/*.swift'
  
end
