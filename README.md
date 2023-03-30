# News App

This is a news app build with Flutter Framework for 'FLUTTER CODING EXERCISE' of Xcenter Technologies.

## API Used
In this project, I have used the free news API provided by the newsapi.org.

## Packages and Plugins Used

In order to build this app I have used following plugins and packages:

- get

    This package has been used on this project for state management.

- dio
 
    This flutter package has been used to handle the network requests.

- go_router
 
    Go Router package has been used for route handling.

- shared_preferences
 
    Shared Preferences plugin has been used for user session handling.

- cached_network_image
 
    Cached Network Image plugin has been used to load and cache network images.

- connectivity_plus
 
    Connectivity Plus plugin has been used to observe the internet connectivity of the device.

- webview_flutter
 
    WebView plugin has been used to load the news details from the given url.

- firebase_core
 
    This plugin has been used here to connect the app with firebase.

- firebase_messaging
 
    This plugin has been used for Firebase Cloud Messaging for notification.

- flutter_local_notifications
 
    This plugin has been used here to show the message come from the FCM as a Notification.
    
## Screens
This app has four screens-
1. Splash Screens

    This screen contains the app name at the center of screen. This screen has been shown for a few seconds whenever app is opened.
 
 2. Sources Screen
 
    This screen is the landing page for this app. This screen shows the list of news sources that the newsapi provided. You can navigate to the news screen by clicking on any news source.
    
 3. News Screen

    This screen shows the as per the sources that you have been selected on sources screen. You can see the list of news witha acover image and title here.
    
 4. Details Screen
    
    This screen include a webview that will be responsible to load the news url.
