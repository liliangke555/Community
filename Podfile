source 'git@github.com:liliangke555/LookDoorSpecs.git'
source 'https://github.com/CocoaPods/Specs.git'



platform :ios, '9.0'

use_frameworks!

flutter_application_path = '../flutter_module_com/'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'Community' do
  
  install_all_flutter_pods(flutter_application_path)

pod 'ReactiveObjC', '~> 3.1.0'
pod 'YBImageBrowser', '~> 3.0.9'
pod 'YBImageBrowser/Video'
pod 'LDImagePickerContrller'
pod 'LDWKWebView'

end
