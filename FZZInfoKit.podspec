Pod::Spec.new do |s|

  s.name         = "FZZInfoKit"
  s.version      = "0.0.34"
  s.summary      = "設定（インフォメーション）画面をかんたんに作成"
  s.homepage     = "http://shtnkgm.github.io/"
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  s.author       = 'Shota Nakagami'
  s.platform     = :ios, "8.0"
  s.requires_arc = true
  s.source       = { :git => "https://shtnkgm@bitbucket.org/shtnkgm/fzzinfokit.git", :tag => s.version }
  s.source_files = "FZZInfoKit/FZZ*.{h,m}", "FZZInfoKit/NSString+FZZInfoKitLocalized.{h,m}"
  s.resources    = ["FZZInfoKit/*.{xib}","FZZInfoKit/*.{png}"]
  s.resource_bundles = { 'FZZInfoKit' => ["FZZInfoKit/*.lproj", "Pods/Target Support Files/Pods/Pods-acknowledgements.plist"]}
  s.framework  = 'Foundation', 'UIKit'
  s.dependency 'SVProgressHUD'
  s.dependency 'ChameleonFramework'

end
