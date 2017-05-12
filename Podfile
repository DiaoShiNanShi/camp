platform :ios, ‘7.0’
use_frameworks!

target ‘camp’ do
    pod 'AFNetworking'
    pod 'Masonry'
    pod 'MJExtension'
    pod 'SDWebImage', '~>3.8'
    pod 'SDCycleScrollView'
    
    pod 'LBXScan/LBXNative','~> 2.0'
    pod 'LBXScan/LBXZXing','~> 2.0'
    pod 'LBXScan/LBXZBar','~> 2.0'
    pod 'LBXScan/UI','~> 2.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end
