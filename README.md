# RandomUser.me iOS Application

This app simply retrives randomly generated user information from RandomUser API and fetch them on the screen.

## Getting Started

You can build and run the project by fork or downloading the master branch.

You need Xcode to build it. and It supports Swift 4 but recommend using Swift 5.  
And becuase I used muted map on the detail scene, It requires iOS 11 or after.

## Running the tests

I wrote some test cases for parsing the variables from JSON which is coming from API.  
You can run it from Xcode unit tests.

## Built With

* Pure Swift with internal networking libraries
* Used MapKit to show the map on the screen (Which is also an internal library)

## Author

* **Jun Jung** - *Initial work* - [CheeseStick](https://github.com/CheeseStick)

## Digressions

* It's simple app that shows basic routine of server communication.
* There have lots of networking libraries for Swift but I used internal one because It's simple to use.
* I should made some start-up screen and loading scene. Now I remembered what I forgot.
