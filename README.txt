Readme

platform :ios, ‘8.0’
pod ‘FZZInfoKit’, :git => 'git@bitbucket.org:shtnkgm/fzzinfokit.git'

    FZZInfoViewController *vc = [FZZInfoViewController new];
    vc.appIDString = @"480099135";
    vc.developerIDString = @"457011383";
    vc.supportSiteURLString = @"http://shtnkgm.github.io";
    
    vc.delegate = self;
    [self presentViewController:vc
                       animated:YES
                     completion:nil];