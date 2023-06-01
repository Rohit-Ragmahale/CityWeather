# CityWeather
Search weather of your city

# Features
* Clean Architecture
* API Integration - https://api.openweathermap.org
* Localization
* Unit test code coverage for all components except UI
* SwiftLint used for maintaining coading standards

# Architecture 
* Application Used **VIPER + Clean Architecture**

<img width="587" alt="Screenshot 2023-05-31 at 14 23 45" src="https://github.com/Rohit-Ragmahale/CityWeather/assets/26670429/c89e25a5-f8d3-4085-8427-853ba9c95373">


# Feature Flags/ Control Flags

Application has 
* **Release-FeatureFlags.xcconfig**  Contains FF for features those are ready for release 
* **Release-FeatureFlags.xcconfig** Contains FF for features in develop also contains some flow control flags

Few of them are important and listed below
* MOCK_ENVIRONMENT => App will use API responses from Mock files after adding this flag to DEBUG_SWIFT_ACTIVE_COMPILATION_CONDITIONS, 
* ENABLE_SNAPSHOT_TEST => Application uses **iOSSnapshotTestCase** Device for snapshot testing is 'IPhone 14',  to enable snapshot UI Unit test add this flag to DEBUG_SWIFT_ACTIVE_COMPILATION_CONDITIONS




