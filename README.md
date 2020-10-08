# NewsAPI

A simple articles news reader app, using [Getx](https://pub.dev/packages/get), [GetX CLI](https://pub.dev/packages/get_cli), [NewsAPI](https://newsapi.org/) and Flutter sdk.

## Features

- **Loading view (splash screen with app logo)**
- **Main view (articles view, 'REFRESH' button to load new data from the api)**
- **When fetching new data from the api, the data is stored locally, so the user can read the articles while offline. The articles shown in offline mode are the latest fetched articles.**
- **Network sensitive icon (in the right side of the app bar). I achieved this functionality by listening to onConnectivityChanded stream from Connectivity plugin**
- **'REFRESH' botton functionality - show error message when the user try to load new data while offline, or feth new data from api ends with failure'**
- **fetch articles functionality - return with either data (articles), or feilure (http error, empty data, offline state). Update view according to the value returned from the function**
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
