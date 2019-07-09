# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'
inhibit_all_warnings!

def rx_swift
    pod 'RxSwift', '~> 4.5'
end

def rx_cocoa
    pod 'RxCocoa', '~> 4.5'
end

def test_pods
    pod 'RxTest'
    pod 'RxBlocking'
    pod 'Nimble'
end


target 'MBCleanSwiftExample' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_cocoa
  rx_swift
  pod 'QueryKit'
  target 'MBCleanSwiftExampleTests' do
    inherit! :search_paths
    test_pods
  end

end

# target 'CoreDataPlatform' do
#   # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
#   use_frameworks!
#   rx_swift
#   pod 'QueryKit'
#   target 'CoreDataPlatformTests' do
#     inherit! :search_paths
#     test_pods
#   end

# end

target 'MBDomain' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_swift

  target 'MBDomainTests' do
    inherit! :search_paths
    test_pods
  end

end

target 'MBNetworkPlatform' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    rx_swift
    pod 'Alamofire'
    pod 'RxAlamofire'

    target 'MBNetworkPlatformTests' do
        inherit! :search_paths
        test_pods
    end
    
end
