The folder contains the application. To run this, you need to download flutter.
Instructions for window can be found below:
https://docs.flutter.dev/get-started/install/windows
Instructions for mac can be found below:
https://docs.flutter.dev/get-started/install/macos

To run on an android device.
1. First run flutter doctor. If there are no issues found then continue.
2. Once you have the folder open, if you encounter any build errors run the following commands in order:
Flutter create .
 
include the dot and the space, it is very important
Flutter clean
Flutter pub cache repair
Flutter pub get

To run on an android, connect your android device(you may need to enable USB debugging and
allow installations through USB) or emulator, navigate to the main.dart file and run it.
You may encounter "Note: " messages, however these are fine.
The first run will take a few minutes.
When app is built, press install on your device.

The following instruction allows you to run the application on iOS simulator.

1. You will need to use Mac machine and you will need to install Xcode on your Mac.
2. Create Simulator:
Menu > Xcode > Preferences > Select Components, and then choose the simulator version 
3. Open your IDE, I have used Microsoft Visual Code. Bottom bar you will see simulator if you have successfully started it.
4. In the Visual studio terminal type: flutter pub get && flutter run
5. Wait for the app to run, first run will take few minutes
6. You should now have the app running on iOS

![image](https://user-images.githubusercontent.com/86359268/190518262-b79913b9-80a3-4255-a6a4-882c1d3d49f6.png)

![image](https://user-images.githubusercontent.com/86359268/190518289-0c9d9641-f23f-45c8-bde6-c59431e73a4d.png)

![image](https://user-images.githubusercontent.com/86359268/190518335-4b89070b-464e-44e9-8296-7fe6f6f17af1.png)

![image](https://user-images.githubusercontent.com/86359268/190518360-b52a31ef-3993-4281-af9b-0f13cd3cfa2a.png)

![image](https://user-images.githubusercontent.com/86359268/190518385-99e039c9-d6ae-46d1-94a9-369b97af6486.png)

![image](https://user-images.githubusercontent.com/86359268/190518403-6926dd72-b83f-414d-85bc-88e7e51f8d39.png)

![image](https://user-images.githubusercontent.com/86359268/190518437-fdfb3a1e-8611-44aa-b1f5-c09cb981dc08.png)

