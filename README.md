
# Wagr-Assignment
### Author: Steven Andrews

## Description 
This repo houses the take home assignment provided by Wagr.

## Requirements
* iOS 13.0+
* Xcode 12.4+

## Setup
1. Clone the repo
2. Navigate to the root directory in `Terminal`
3. Ensure [Cocoapods is installed](https://guides.cocoapods.org/using/getting-started.html#installation)
4. Run `pod install`
5. Open `Wagr-Assignment.xcworkspace` with Xcode

## Important Note
The app pretends that today's date is Jan 21, 2021. The data provided by the API starts on this date, and ends on Jan 27, 2021. If the real current date is used then no games are ever displayed since they are all in the past. 

# Features
## Multiple Celebration Styles
The app demonstrates two different styles of showing the bet confirmation/celebration screen. When a game cell is selected, an action sheet appears with 2 options:
1. Modal:
    This option displays a more subtle bet confirmation screen that may be a better choice if this screen is frequently shown to the user. If a commonly used screen is too busy it may detract from the experience.
2. Fullscreen:
    This option displays a more elaborate fullscreen celebration screen. This screen includes more information, as well as a confetti particle effect.
    
Note that A/B testing would be required to fully quantify the impact of these different screens.

## Caching
The app caches game information retrieved by the Games API to allow the user to view upcoming games while offline or with poor connectivity. An indicator at the top-right of the game list will show when the user is offline. Tap the indicator for more information.

The network reachability manager will automatically re-sync the games list with the API when the network is restored. 

To test this feature:
1. Open the app with an internet connection, let the games list load
2. Close the app
3. Enable airplane mode on your iPhone
4. Open the app
5. Observe that the app is still fully functional

## Dark Mode
The app supports dark mode. Try switching between light and dark mode to see both app styles.

## Analytics
Firebase analytics has been integrated into the app as an example. Only screen view events are implemented. Crashlytics is also leveraged to alert the developer if a crash occurs, along with enough information to fix the issue. 

## Localization
All static strings in the app have been localized. If the user's phone is set to Spanish, the app will show all static strings (strings not from the API) in Spanish (translated using Google translate). The app's locale could be sent with the API call, if the API had localization support.This would allow all data to come in translated to the appropriate language. In the app's current state, new languages can be added easily and quickly. A copy management service like [Lokalise](https://lokalise.com/) should be leveraged in a production environment.

## Timezones
The app will display the time of games in the timezone the user's phone is set to. Modify your phone's timezone in Settings to see this feature in action.

## Console Logs
The app leverages Apple's logging system to allow app logs to be viewed by anyone with their phone connected to a mac. This allows for anyone to assist with debugging by allowing them to export and send logs to the app's developers.

To Use:
1. Connect you iPhone to your Mac via USB, and unlock the phone. Trust the device on your phone if prompted
2. Press `command` + `space` to open Spotlight
3. In spotlight, type `Console` to open the Console app
4. Select your iPhone from the left menu bar
5. Press `Start` on the top bar
6. In the search bar in the top-right type: `process:wagr` and press enter
7. Open the Wagr app on your iPhone
8. Observe the logs in the Console app

## Third-Party Dependencies
Firebase is the only third-party dependency included in the application. Third-party dependencies should typically be minimized to help make upgrading dev tools/OS support a painless experience.

## Features left out due to time constraints
### Pagination
When retrieving data from an API, there is normally a large amount of data. The retrieval and displaying of this data needs to be optimized for UX, usually via pagination. Pagination on the game list was skipped due to no support for it in the API.

### VoiceOver/Accessibility support
Accessibility was not optimized due to time constraints. Usually no functionality or understanding should be lost when using an app via VoiceOver. VoiceOver will still function, but some components have not been optimized to meet WCAG 2.1 accessibility standards.

### Dynamic Text Sizing
Usually an app will respond to the device's dynamic text size settings. In this case, this feature was skipped due to time constraints.
