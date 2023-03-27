FLUTTER HOLIDAY APP

This is a Flutter application that displays holidays in the UK. The data is sourced from the gov.uk website.

THE LASTEST AND FINAL CODE IS IN THE "MAIN" BRANCH!

FEATURES:

1. Displays holidays for England and Wales, Scotland, and Northern Ireland.
2. Displays the name and date of each holiday.
3. Displays push notification when user interracts.
4. Displays background push notification.



DESCRIPTION: 

Flutter Holidays App This is a Flutter application that displays holidays in the UK. The data is sourced from the gov.uk website. Also, push notification is implemented here. Firebase Cloud Messaging (FCM) is a messaging platform that allows you to send notifications and messages to devices across different platforms, including Android, iOS, and web. Push notifications are one of the most important features of FCM, which enable you to engage with your users even when they are not actively using your app.

Push notifications can be divided into two categories: background notifications and user interaction notifications.

Background notifications are delivered to the device even when the app is not running in the foreground. These notifications are used to keep the user informed about important events, such as new messages, upcoming appointments, or changes to their account status. To receive background notifications, the app needs to be registered with FCM and have a valid push notification token.

User interaction notifications are delivered when the user is actively using the app. These notifications can be used to provide real-time updates or to prompt the user to take a specific action. For example, a user interaction notification can be used to inform the user that a new message has arrived and provide a button that allows them to open the message directly from the notification.

To implement push notifications in your app, you need to follow these steps:

1. Set up your Firebase project and configure your app to use FCM.
2. Register your app for push notifications and retrieve the push notification token.
3. Create a notification payload that includes the message, title, and any additional data that needs to be passed to the app.
4. Send the notification payload to the FCM server, which will forward it to the appropriate device.
5. Handle the notification on the device by implementing a callback function that is triggered when the notification is received.
For background notifications, you need to implement a service or broadcast receiver that listens for incoming notifications and handles them appropriately. For user interaction notifications, you can use the FCM SDK to display the notification to the user and handle any actions that the user takes.


GETTING STARTED:

1. Clone the repository: git clone https://github.com//sample.git
2. flutter pub get
3. flutter run

*COMING SOON

CONTRIBUTING:

Contributions are welcome! Please submit a pull request if you would like to add a feature or fix a bug.

