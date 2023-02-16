# TranslateMe

TranslateMe is an ios project intended to translate manga, webtoons, or comic images uploaded by the user. 

# Description

The project was built using swiftui, and python in the backend. The user can select any image from the photo picker library and upload them. From there the images are stored in firebase. Once stored, python will recieve the request from swiftui and begin processing the images. After the image is fully processed, it will go back to firebase, from there it will be downloaded back into swift for the user to see. There are about eight languages that the user can select from. 

# Dependencies 
TranslateMe relies on:

Google Firebase
Firebase/Firestore Database
Firebase/Storage

# Getting Started

Download XCODE 
Create a Google Firebase account and follow the steps to configure a database in Firestore and storage. 

# Authors 

Alaere Nekekpemi 