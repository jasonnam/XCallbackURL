Pod::Spec.new do |spec|
  spec.name     = 'XCallbackURL'
  spec.version  = '0.1.0'
  spec.authors  = { 'Jason Nam' => 'contact@jasonnam.com' }
  spec.license  = 'MIT'
  spec.homepage = 'https://github.com/jasonnam/XCallbackURL'
  spec.summary  = 'Swift implementation of x-callback-url.'
  spec.source   = { :git => 'https://github.com/jasonnam/XCallbackURL.git',
                    :tag => spec.version.to_s }
  spec.swift_version = '5.0'
  spec.ios.deployment_target = '8.0'
  spec.osx.deployment_target = '10.10'
  spec.source_files = 'Sources/XCallbackURL/**/*.{swift}'
end
