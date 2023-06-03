# CityWeather
Wants to stay updated with weather of your or any city?<br>
Then try this App!!<br>
Just enter name of place and you will get weather and forecast for that location...<br>
CityWeather provides up to date weather information for any area in the world.<br>
We are using open source API provided by https://openweathermap.org/api

## Demo

https://github.com/Rohit-Ragmahale/CityWeather/assets/26670429/80de20a4-e147-4cd5-931b-bda028a3aea8


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
Host: https://api.openweathermap.org/data/2.5<br>
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

## Unit testing and code coverage 
Application has 80% of code coverage. UI screens are covered using 'iOSSnapshotTestCase' framework.

<img width="1341" alt="Screenshot 2023-06-02 at 17 49 28" src="https://github.com/Rohit-Ragmahale/CityWeather/assets/26670429/1ec365e7-feb3-4a4a-8fb3-fe6b1065fb8e">


