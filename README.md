# NewsAPI

A simple articles news reader app, using [Getx](https://pub.dev/packages/get), [GetX CLI](https://pub.dev/packages/get_cli), [NewsAPI](https://newsapi.org/) and Flutter sdk.

## Features

- **Loading view (splash screen with app logo)**
- **Main view (articles listview, 'REFRESH' button to fetch new data from api)**
- **When fetching new data from the api, the data is stored locally, so the user can read the articles while offline. The arcticles shown in offline mode are the latest fetched articles.***
- **Network sensitive icon (in the right side of the app bar). I achieved this functionality by listening to onConnectivityChanded stream from Connectivity plugin**
- **Automatically detect offline mode on start up, and fetch local stored articles if exists. Listen to connectivity changes - when there is an online connection, fetch new data from api and update view with new articles.**

## Screenshots

<img src="screenshots/screenshot 2.jpg" width="240px"> <img src="screenshots/screenshot 3.jpg" width="240px"/> <img src="screenshots/screenshot 1.jpg" width="240px"/> <img src="screenshots/screenshot 4.jpg" width="240px"/>


## Technologies
 
### Architecture
- **MVC (via GetX CLI MVC design pattern)**

### Front-end
- **Flutter SDK**
- **GetX (for state managment, navigation service, dependencies manager)**

### Back-end
- **SQLite**
- **NewsAPI** 

# Author 🙋

-   **Omer Gamliel** - [LinkedIn](https://www.linkedin.com/in/omer-gamliel-6a813a188/)
