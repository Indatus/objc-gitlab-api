Pod::Spec.new do |s|
  s.name         = "ObjcGitlabApi"
  s.version      = "0.1.0"
  s.summary      = "An Objective-C library for interacting with the GitLab API."
  s.homepage     = "https://github.com/Indatus/objc-gitlab-api"
  s.license      = 'TBD'
  s.authors          = { "Jon Staff" => "jstaff@indatus.com", "Jeff Trespalacios" => "jtrespalacios@indatus.com" }
  
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/Indatus/objc-gitlab-api.git", :tag => "0.1.0" }
  s.source_files  = 'objc\ gitlab\ api/*.{h,m}', 'objc\ gitlab\ api/**/*.{h,m}'

  s.public_header_files = 'objc\ gitlab\ api/GLGitlab.h', 'objc\ gitlab\ api/models/*.h', 'objc\ gitlab\ api/utilities/*.h', 'objc\ gitlab\ api/utilities/api\ extensions/GLGitlabApi+Commits.h', 'objc\ gitlab\ api/utilities/api\ extensions/GLGitlabApi+Issues.h', 'objc\ gitlab\ api/utilities/api\ extensions/GLGitlabApi+MergeRequest.h', 'objc\ gitlab\ api/utilities/api\ extensions/GLGitlabApi+Milestones.h', 'objc\ gitlab\ api/utilities/api\ extensions/GLGitlabApi+Notes.h', 'objc\ gitlab\ api/utilities/api\ extensions/GLGitlabApi+Repositries.h', 'objc\ gitlab\ api/utilities/api\ extensions/GLGitlabApi+Session.h', 'objc\ gitlab\ api/utilities/api\ extensions/GLGitlabApi+Snippets.h', 'objc\ gitlab\ api/utilities/api\ extensions/GLGitlabApi+Users.h'

  s.requires_arc = true

end
