Pod::Spec.new do |s|
s.name         = 'SignInView'
s.version      = '1.0.5'
s.summary      = '自定义打卡view＋震动＋动画'
s.homepage     = 'https://github.com/liyaozhong/SignInView'
s.license      = 'MIT'
s.author       = { 'liyaozhong' => 'yun.zhongyue@163.com' }
s.source       = { :git => 'https://github.com/liyaozhong/SignInView.git', :tag => s.version.to_s}
s.resource     = 'SignInView/*.png'
s.platform     = :ios
s.requires_arc = true
s.source_files = 'SignInView/SignInView.{h,m}'
s.ios.deployment_target = '8.0'
s.ios.frameworks = 'AudioToolbox'
end