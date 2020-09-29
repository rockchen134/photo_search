# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

def networking_pods
  pod 'Alamofire', '~> 5.2.2'
  pod 'Moya', '~> 14.0.0'
end

def reactive_pods
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'Moya/RxSwift'
  pod 'Moya/ReactiveSwift'
  pod 'RxDataSources', '~> 4.0.1'
end

def indicator_pods
  pod 'MBProgressHUD'
end

def image_pods
  pod 'Kingfisher'
end

def keyboard_pods
  pod 'TPKeyboardAvoidingSwift'
end

def ui_pods
	pod 'SnapKit', '~> 5.0.1'
end

  

target 'photo_search' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for photo_search
  networking_pods
  reactive_pods
  indicator_pods
  image_pods
  keyboard_pods
  ui_pods

  target 'photo_searchTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'photo_searchUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
