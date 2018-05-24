#
#  Be sure to run `pod spec lint HKHttpManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

# ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  These will help people to find your library, and whilst it
#  can feel like a chore to fill in it's definitely to your advantage. The
#  summary should be tweet-length, and the description more in depth.
#

s.name         = "HKHttpManager"
s.version      = "0.0.3"
s.summary      = "对AFNetworking的二次封装，支持App复杂的网络处理."


s.description  = <<-DESC
对AFNetworking的二次封装，支持App复杂的网络处理,类似于YTKNetworking，但是要简介一些
DESC

s.homepage     = "https://github.com/baoshanf/HKHttpManager.git"


s.license      = "MIT (HKHttpManager)"


s.author             = { "hans" => "baoshanf@163.com" }

s.platform     = :ios, "8.0"


s.source       = { :git => "https://github.com/baoshanf/HKHttpManager.git", :tag => "#{s.version}" }



s.source_files  = "HKHttpManager/Sources/**/**/*.{h,m}"
# s.exclude_files = "Classes/*.h"

 s.public_header_files = "HKHttpManager/Sources/**/*.h"



s.dependency "AFNetworking"

end
