Pod::Spec.new do |s|
  s.name         = 'AnyCodable-FlightSchool'
  s.module_name  = 'AnyCodable'
  s.version      = '0.6.7'
  s.summary      = 'Type-erased wrappers for Encodable, Decodable, and Codable values.'

  s.description  = <<-DESC
    This functionality is discussed in Chapter 3 of Flight School Guide to Swift Codable.
  DESC

  s.homepage     = 'https://flight.school/books/codable/'

  s.license      = { type: 'MIT', file: 'LICENSE.md' }

  s.author = { 'Mattt' => 'mattt@flight.school' }

  s.social_media_url   = 'https://twitter.com/mattt'

  s.framework = 'Foundation'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.source = { git: 'https://github.com/Flight-School/AnyCodable.git', tag: s.version.to_s }

  s.source_files = 'Sources/**/*.swift'

  s.swift_version = '5.1'
end
