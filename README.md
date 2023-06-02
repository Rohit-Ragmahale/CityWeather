# CityWeather
Search weather of your city

## Features
* Clean Architecture
* API Integration
* API Mock - Test app flow with mock json response
* Data Store - temporary store data to reduce network request
* Feature Flags - Preprocessor Macros for controlling app flow and features
* Accessibility
* Unit test and UI Test - code coverage for all components
* SwiftLint - Maintaining coading standards
* Localization

## Architecture 
* Application uses **VIPER + Clean Architecture**

<img width="835" alt="CleanViper" src="https://github.com/Rohit-Ragmahale/CityWeather/assets/26670429/8347ce8c-cb76-41a9-88a4-e2e5e447d039">

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

WEATHER_FORECAST_DETAILS : This is feature flag control 'Detail Forecast' feature. This flag enabled in Debug, but won't be available in Release as this FF not added in Release-FeatureFlags.xcconfig.<br>

## Accessibility
Application support Accessibility<br>

1: Application support dynamic fonts<br>
2: Application support voice over

