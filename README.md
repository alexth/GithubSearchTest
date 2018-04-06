# GithubSearchTest

#General
Hello, reviewers!

First of all I want to say that project was built under high time pressure, as I'm totally busy on a current project. It's not matching my personal definition of ideal, but unfortunately I can't invest more time now. Would be glad to go through all places which can be improved and explain in details in a private chatting.


##Specs
- Swift 4.1
- Xcode 9.3
- Cocoapods
- Storyboards


#Project structure
All files located to related folders. Separated Network and Data layers, Design etc. All folders and files are placed in alphabetical order. Flows flder constains separation of an app by flow. Usually I keep all files related to flow in one folder (like ViewControllers, Views, Storyboards etc.)


##Architecture
I selected MVC as a default, but because I like to cover my code with unit-tests, I usually prefer something better separated. At least MVVM, or (depends on project needs) MVP/VIPER. Haven't used TDD on a real project, but will do that with interest. Also, I never used reactive programming, but interested to try. In general I had experience with elements of reactive programming as Promises


##Testing
No unit or UI tests added, because lack of free time. Usually I try to cover at least most importat business logic. Like to use Fastlane tools for local automation.


##Networking
Plain URLSession, added access point NetworkManager, and currently protocol with extension added (Protocol Oriented Programming concept used)


##Dependencies
I added Cocoapods to use Oauth lib called [OauthSwift](https://github.com/OAuthSwift/OAuthSwift) - one of few which was not broken by Swift 4.1 update. Usually I'm trying to limit my choice by well covered with tests, MIT-licensed libs if it makes more sense to add the dependency, then to build by myself. Form the other hand trying to keep list of dependencies short


##UI
I had an experience with all kinds of UI implementation (code, libraries like[Snapkit](https://github.com/SnapKit), xibs, Storyboards). In this test project I used Soryboards with autolayout. I believe that there is no silver bullet, and every instrument should be used depends on situation, as all of them have pros and cons


##Data
I never worked with Realm (though would try with a pleasure), but for this one I added Core Data, which is familiar to me. Now it's not connected and data models are going directly to view controller's data source. If we would want to make some edits on that data, then models should be converted into Core Data objects, and then read from storage to ViewControllers, to setup one source of access to data. From this point of view app is fully ready to be expanded to use local data storage.


##Control System and flow
I used git and it's branching. I prefer to use rebase over merge to keep history tree clean. Also I like to use Code Reviews via github's pull requests and review instruments. I also like pair coding and continuous integration in teams, because they usually make code quality better, and keep project in a consistent and maintainable state


##NOT READY
In some places I saved the time and put TODO's, sometime with explanation of what is missing - usually it's an errors or edge cases handling. No force unwrapinng in a project (at least I don't remember one :))

Auth is need to be setup properly to show login web view only once, which is only a matter of additional time. Would also discuss that on a chat