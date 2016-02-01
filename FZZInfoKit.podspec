Pod::Spec.new do |s|

  s.name         = "FZZInfoKit"
  s.version      = "0.0.1"
  s.summary      = "設定（インフォメーション）画面をかんたんに作成"

  s.description  = "FZZInfoKitの概要（作成中）文章..............................................................."

  s.homepage     = "http://shtnkgm.github.io/"

  s.license      = { :type => "MIT", :file => "LICENSE.txt" }

  s.author       = 'Shota Nakagami'

  s.platform     = :ios, "8.0"

  s.requires_arc = true

  s.source       = { :git => "https://shtnkgm@bitbucket.org/shtnkgm/fzzinfokit.git", :tag => "0.0.1" }

  s.source_files  = "FZZInfoKit/FZZInfoViewController.{h,m}", "FZZInfoKit/FZZInfoCell.{h,m}"

  s.resources  = "FZZInfoKit/FZZInfoCell.xib", "FZZInfoKit/FZZInfoViewController.xib", "FZZInfoKit/en.lproj/FZZInfoViewControllerLocalizable.strings", "FZZInfoKit/ja.lproj/FZZInfoViewControllerLocalizable.strings"

  s.framework  = 'StoreKit', 'Foundation', 'UIKit'

  s.dependency 'AFNetworking'
  s.dependency 'RMUniversalAlert'
  s.dependency 'SVProgressHUD'

end
