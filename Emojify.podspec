Pod::Spec.new do |s|
  s.name     = 'Emojify'
  s.version  = '0.1.0'
  s.author   = { 'Chris O\'Neil' => 'cconeil5@gmail.com' }
  s.homepage = 'https://github.com/cconeil/Emojify'
  s.summary  = 'Emojify your app, emojify your life.'
  s.license  = 'MIT'
  s.source   = { :git => 'https://github.com/cconeil/Emojify.git', :tag => s.version.to_s }
  s.source_files = 'Emojify/Source/*{.json,.swift}'
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
end

