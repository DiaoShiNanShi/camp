platform :ios, ‘7.0’
use_frameworks!

target ‘camp’ do
    pod 'AFNetworking'
    pod 'Masonry'
    pod 'MJExtension'
    pod 'SDWebImage', '~>3.8'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end
