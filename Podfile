# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end

target 'Artwork' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!


  # Pods for Artwork

  pod 'Fakery'
  pod 'IQKeyboardManagerSwift'
  pod 'Moya/ReactiveSwift', '~> 14.0'
  pod 'ReactiveCocoa', '~> 10.1'
  pod 'ReactiveSwift', '~> 6.1'
  pod 'SDWebImage', '~> 4.0'
  pod 'SnapKit', '~> 5.0.0'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'SwiftyUserDefaults'

  target 'ArtworkTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ArtworkUITests' do
    # Pods for testing
  end

end
