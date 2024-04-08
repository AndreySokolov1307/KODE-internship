# Uncomment the next line to define a global platform for your project
# platform :ios, '15.0'

abstract_target 'CommonPods' do

  use_frameworks!
  pod 'SwiftLint', '0.47.0'
  
  target 'AnyApp' do
    pod 'SwinjectAutoregistration', '~> 2.8' # includes Swinject
    pod 'OHHTTPStubs/Swift', '9.1.0', :configurations => ['Dev', 'Internal']

    pod 'Pathfinder-Swift'
    pod 'SwiftGen', '~> 6.6'

    pod 'SnapKit', '~> 5.6'
  end

  target 'Services' do
    pod 'Firebase/Messaging', '~> 10'
    pod 'Firebase/Crashlytics', '~> 10'
    pod 'KeychainAccess', '~> 4.2'
    pod 'Alamofire', '~> 5.5.0'
    pod 'Pathfinder-Swift'
  end

  target 'AppIndependent' do
  end

  target 'Core' do
    pod 'SwiftGen', '~> 6.6'
    pod 'SwinjectAutoregistration', '~> 2.8' # includes Swinject
  end

  target 'UI' do
    pod 'SnapKit', '~> 5.6'
    pod 'SkeletonView', '~> 1.30'
  end

end

# Set zero Pods optimization level in Dev configurations
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # some older pods don't support some architectures, anything over iOS 11 resolves that
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
#    if target.name.include?("Pod")
      target.build_configurations.each do |config|
        if config.name.include?("Dev")
          config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'

          # Add DEBUG to custom configurations containing 'Debug'
          config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)']
          if !config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'].include? 'DEBUG=1'
            config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] << 'DEBUG=1'
          end

          config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'

          config.build_settings['SWIFT_ACTIVE_COMPILATION_CONDITIONS'] = ['DEBUG']
        end
      end
#    end
  end
end
