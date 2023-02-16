# TranslateMe

TranslateMe is an ios project intended to translate manga, webtoons, or comic images uploaded by the user. 

# Description

The project was built using swiftui, and python in the backend. The user can select any image from the photo picker library and upload them. From there the images are stored in firebase. Once stored, python will recieve the request from swiftui and begin processing the images. After the image is fully processed, it will go back to firebase, from there it will be downloaded back into swift for the user to see. There are about eight languages that the user can select from. 

# Dependencies 
TranslateMe relies on:

Python backend Api 

Google Firebase:
* Firebase/FirestoreDatabase
* Firebase/Storage

# Getting Started

# Xcode Installation

Download Xcode from the app store, the download is free and should be updated to the latest version. Xcode is the developer toolkit that allows users to create apps for IOS systems Mac, iPhone, iPad, Apple Watch, and Apple TV. 

# Google Firebase


1. Create an iOS app and select Firestore Database and Storage.
2. Follow the specific configurations necessary for both, as detailed in Firebase.
3. Save a GoogleService.plist file into the project root directory as it is a mandatory requirement to connect the app to Firebase.
4. Hide the GoogleService.plist in .gitignore as it is unique to your project.
5. Add the Firebase SDK to your project.
6. Begin working with Firebase.

# Authors 

Alaere Nekekpemi 


