# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

use_frameworks!

target 'sh8email' do
  pod 'Alamofire'
  pod 'ObjectMapper'
  pod 'AlamofireObjectMapper'
  pod 'Kanna'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'Digits'
end

# migrating to Swift 3
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.2'
    end
  end
end
