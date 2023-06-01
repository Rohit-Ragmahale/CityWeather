# CityWeather
Search weather of your city

## Features
* Clean Architecture
* API Integration
* Feature Flags - Preprocessor Macros for controlling app flow and features
* Accessibility
* Unit test and UI Test - code coverage for all components
* SwiftLint - Maintaining coading standards
* Localization

## Architecture 
* Application uses **VIPER + Clean Architecture**

<img width="587" alt="Screenshot 2023-05-31 at 14 23 45" src="https://github.com/Rohit-Ragmahale/CityWeather/assets/26670429/c89e25a5-f8d3-4085-8427-853ba9c95373">

## API Integration
https://api.openweathermap.org/data/2.5<br>
searvices:<br>
1: /weather<br>
2: /forecast<br>

## Feature Flags/ Control Flags

Application has 
* **Release-FeatureFlags.xcconfig**  Contains FF for features those are ready for release 
* **Release-FeatureFlags.xcconfig** Contains FF for features in develop also contains some flow control flags

Few of them are important and listed below:<br>

MOCK_ENVIRONMENT : App will use API responses from Mock files after adding this flag to DEBUG_SWIFT_ACTIVE_COMPILATION_CONDITIONS<br>

ENABLE_SNAPSHOT_TEST : Application uses **iOSSnapshotTestCase** Device for snapshot testing is 'IPhone 14', to enable snapshot UI Unit test add this flag to DEBUG_SWIFT_ACTIVE_COMPILATION_CONDITIONS<br>

WEATHER_FORECAST_DETAILS : This is feature under development and won't be available in Release<br>

## Accessibility
Application support Accessibility<br>

1: Application support dynamic fonts<br>
2: Application support voice over

