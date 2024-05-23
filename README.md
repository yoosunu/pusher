# pusher => An alarming application for Android.

A simple application sending push alarm when new notifications added and can save notifications.
I'm studying in Jeonbuk national university and implemented this app for studying.

## Getting Started

You can simply clone this github and build app for testing with build with "flutter build apk".

# I used Workmanager package for background section

The background logic gonna save the notifications in your own sqlite database every 15 minutes(you can adjust it).
=> in the code, the timer set minutes: 2, but when you build app, the workmanager set the timer minutes: 15(minimum) automatically.

# You should turn off the power saving mode if you wanna get the alarms consistently.

Then, the background logic gonna work consistently.

# Do not use this app for commercial purposes.
