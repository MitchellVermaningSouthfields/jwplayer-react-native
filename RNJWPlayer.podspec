require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = 'RNJWPlayer'
  s.version      = package['version']
  s.summary      = package['description']
  s.license      = package['license']
  s.authors      = package['author']
  s.homepage     = package['homepage']
  s.platforms    = { :ios => "13.0", :tvos => "13.0" }
  s.source       = { :git => "https://github.com/jwplayer/jwplayer-react-native.git", :tag => "v#{s.version}" }
  s.source_files  = "ios/RNJWPlayer/*.{h,m,swift}"
  s.dependency   'JWPlayerKit', '4.21.3'
  s.dependency   'JWPlayerTVKit', '1.0.1'
  s.dependency   'React-Core'
  s.static_framework = true
  s.info_plist = {
    'NSBluetoothAlwaysUsageDescription' => 'We will use your Bluetooth for media casting.',
    'NSBluetoothPeripheralUsageDescription' => 'We will use your Bluetooth for media casting.',
    'NSLocalNetworkUsageDescription' => 'We will use the local network to discover Cast-enabled devices on your WiFi network.',
    'Privacy - Local Network Usage Description' => 'We will use the local network to discover Cast-enabled devices on your WiFi network.',
    'NSMicrophoneUsageDescription' => 'We will use your Microphone for media casting.'
  }
  s.xcconfig = {
    'OTHER_LDFLAGS': '-ObjC',
  }

  if defined?($RNJWPlayerUseGoogleCast)
    Pod::UI.puts "RNJWPlayer: enable Google Cast"
    s.dependency 'google-cast-sdk', '4.8.1'
    s.pod_target_xcconfig = {
      'OTHER_SWIFT_FLAGS' => '$(inherited) -D USE_GOOGLE_CAST'
    }
  end
  if defined?($RNJWPlayerUseGoogleIMA)
    Pod::UI.puts "RNJWPlayer: enable IMA SDK"
    s.ios.dependency 'GoogleAds-IMA-iOS-SDK', '~> 3.22.1'
    s.tvos.dependency 'GoogleAds-IMA-tvOS-SDK', '~> 4.2'
    s.pod_target_xcconfig = {
      'OTHER_SWIFT_FLAGS' => '$(inherited) -D USE_GOOGLE_IMA'
    }
  end
  
end
