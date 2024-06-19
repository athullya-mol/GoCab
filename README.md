# GoCab

GoCab is a mobile application designed to simplify the process of booking cabs. With a user-friendly interface and robust functionality, GoCab provides a seamless ride-hailing experience for users. The app leverages modern authentication mechanisms, including SMS OTP verification, to ensure secure and reliable user authentication.

## Features
### Dual Authentication Methods
- **Google Sign-In:** Allows users to sign in using their Google accounts quickly and securely.
- **Manual Sign-In:** Users can sign in by entering their name and email. The app validates the email format before proceeding.
### OTP Verification
- **SMS OTP Verification:** Sends a one-time password to the user's registered mobile number for secure login. This ensures only the rightful owner of the phone number can access the account.
### Firebase Integration
- **Google Sign-In with Firebase:** Manages user sign-ins using Google credentials.
- **Firestore Integration:** Stores and retrieves user information securely.
### Interactive Map
- **Google Maps Integration:** Allows users to set their starting and ending points.
- **Markers and Polylines:** Users can place draggable markers on the map to set their trip's start and end points, with a polyline showing the route between these points.
### Call Functionality
- **Direct Call Feature:** Allows users to quickly contact the driver or customer support for immediate assistance or queries about their ride.
### Confirm PIN
- **PIN Verification by Driver:** Users receive a PIN that must be confirmed by the driver. This extra step ensures the right driver picks up the right passenger, adding another layer of security to the ride-hailing process.
## Getting Started
To get started with GoCab, clone the repository and follow the instructions below:
***git clone https://github.com/your-repo/gocab.git***
***cd gocab***
- **Set Up Firebase:** Configure Firebase Authentication and Firestore in your Firebase console and update the project settings in the app.
- **Install Dependencies:** Run ***flutter pub get*** to install all required dependencies.
- **Run the App:** Use ***flutter run*** to start the app on your preferred device.
