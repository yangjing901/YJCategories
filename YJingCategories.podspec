#
# Be sure to run `pod lib lint YJCategories.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YJingCategories'
  s.version          = '1.0.2'
  s.summary          = 'A short description of YJCategories.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        一些常用的并与业务脱离的Categories
                       DESC

  s.homepage         = 'https://github.com/yangjing901/YJCategories'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yangjing901' => 'yangjing901@qq.com' }
  s.source           = { :git => 'https://github.com/yangjing901/YJCategories.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.subspec 'Category' do |category|
      category.subspec 'NSObject' do |obj|
          obj.source_files = 'YJCategories/Classes/Category/NSObject/*'
      end
      
      category.subspec 'NSDictionary' do |dic|
          dic.source_files = 'YJCategories/Classes/Category/NSDictionary/*'
      end
      
      category.subspec 'NSString' do |str|
          str.source_files = 'YJCategories/Classes/Category/NSString/*'
      end
      
      category.subspec 'UIButton' do |btn|
          btn.source_files = 'YJCategories/Classes/Category/UIButton/*'
      end
      
      category.subspec 'UIColor' do |color|
          color.source_files = 'YJCategories/Classes/Category/UIColor/*'
      end
      
      category.subspec 'UIImage' do |image|
          image.source_files = 'YJCategories/Classes/Category/UIImage/*'
      end
      
      category.subspec 'UIResponder' do |responder|
          responder.source_files = 'YJCategories/Classes/Category/UIResponder/*'
      end
      
      category.subspec 'UIView' do |view|
          view.source_files = 'YJCategories/Classes/Category/UIView/*'
      end
  end
  
  s.subspec 'Core' do |core|
      core.source_files = 'YJCategories/Classes/Core/*'
      core.dependency 'YJingCategories/Category'
  end
  
end
