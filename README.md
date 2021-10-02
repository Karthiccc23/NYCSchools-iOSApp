# NYCSchools-iOSApp

# Project Overview : 

  This is a sample project developed in Swift 5 Xcode 13. App displays information from https://data.cityofnewyork.us/resource/s3k6-pzi2.json. 
  Implemented using MVVM-C design pattern
  
  1) MVVM - Model-View-ViewModel - decouple business logic and view. Therefore, it becomes possible to write a simpler test for the presentational logic 
     without knowing the implementation of the View.
  2) Coordinator pattern - Used this pattern to further decouple the navigation between viewControllers. 
     This pattern helps in implementing deeplinks or other navigation with ease.
     
  3) SchoolApiService is mocked and tested in unit Tests.
  4) Network Monitor is implemented as singleton to check connection state anywhere in the app.
 
  # Improvements:
  
  1) nyc schools api call returns huge number of results. Paging can be done for better performance. I have already added paging attributes to fetch only 10 results.
     Above api supports pagination.
  2) Can create and inherit BaseViewController for all view controllers and add common functionalities to reduce boilerplate code.
  3) Cache results using core Data - sqlite.
