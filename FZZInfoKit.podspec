Pod::Spec.new do |s|

  s.name         = "FZZInfoKit"
  s.version      = "0.0.6"
  s.summary      = "設定（インフォメーション）画面をかんたんに作成"
  s.homepage     = "http://shtnkgm.github.io/"
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  s.author       = 'Shota Nakagami'
  s.platform     = :ios, "8.0"
  s.requires_arc = true
  s.source       = { :git => "https://shtnkgm@bitbucket.org/shtnkgm/fzzinfokit.git", :tag => s.version }
  s.source_files  = "FZZInfoKit/FZZInfoViewController.{h,m}", "FZZInfoKit/FZZInfoCell.{h,m}"
  s.ios.resource_bundle = { 'FZZInfoKit-iOS' => ['FZZInfoKit/Resources/*']}
  s.framework  = 'StoreKit', 'Foundation', 'UIKit'
  s.dependency 'AFNetworking'
  s.dependency 'RMUniversalAlert'
  s.dependency 'SVProgressHUD'

  s.xcconfig = { "APPLY_RULES_IN_COPY_FILES" => "YES", "STRINGS_FILE_OUTPUT_ENCODING" => "binary" }

end
