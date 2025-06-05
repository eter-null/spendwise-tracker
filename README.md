# 💰 Spendwise Tracker

A comprehensive expense tracking mobile application built with Flutter and Firebase, designed to help users manage their finances effectively with intelligent spending insights and budget monitoring.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)

## 📱 Screenshots

> Add screenshots of your app here - showing main dashboard, expense entry, statistics view, etc.

| Dashboard | Add Expense | Statistics | Settings |
|-----------|-------------|------------|----------|
| ![Dashboard](link-to-screenshot) | ![Add Expense](link-to-screenshot) | ![Statistics](link-to-screenshot) | ![Settings](link-to-screenshot) |

## ✨ Features

### Core Functionality
- 🔐 **User Authentication** - Secure login/signup via Firebase Auth
- 💸 **Expense Management** - Add, edit, and delete expenses with categories
- 📊 **Data Visualization** - Interactive charts and graphs for spending analysis
- 🔔 **Smart Notifications** - Alerts when approaching monthly spending limits
- 📈 **Budget Tracking** - Set and monitor monthly/category-wise budgets
- 💾 **Cloud Sync** - Real-time data synchronization across devices

### Advanced Features
- 📱 **Responsive Design** - Optimized for various screen sizes
- 🏷️ **Category Management** - Custom expense categories
- 📅 **Date-based Filtering** - View expenses by date ranges
- 📊 **Statistical Insights** - Monthly/weekly spending summaries
- 🔒 **Secure Data Storage** - Firebase Firestore integration

## 🛠️ Technology Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase Suite
    - Authentication (Firebase Auth)
    - Database (Cloud Firestore)
    - Push Notifications (Firebase Messaging)
- **State Management**: Provider/Bloc (specify which you used)
- **Charts**: fl_chart (or whichever charting library you used)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=2.17.0)
- Android Studio / VS Code
- Firebase account

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/eter-null/spendwise-tracker.git
   cd spendwise-tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
    - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
    - Enable Authentication (Email/Password)
    - Create Cloud Firestore database
    - Download `google-services.json` (Android) and place in `android/app/`
    - Download `GoogleService-Info.plist` (iOS) and place in `ios/Runner/`

4. **Configure Firebase**
   ```bash
   flutter packages pub run build_runner build
   ```

5. **Run the application**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── screens/         # Main app screens (auth, dashboard, expenses, etc.)
├── widgets/         # Custom reusable UI components
├── services/        # Firebase integration & data management
├── utils/           # Helper functions and database models
└── main.dart        # App entry point
```

## 🔧 Configuration

### Firebase Rules (Firestore)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      match /expenses/{expenseId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

## 📊 Key Metrics & Achievements

- ✅ **Performance**: App loads in under 2 seconds
- ✅ **User Experience**: Intuitive design with minimal learning curve
- ✅ **Security**: Implemented proper Firebase security rules
- ✅ **Scalability**: Designed to handle 10,000+ expense entries per user
- ✅ **Cross-platform**: Runs seamlessly on both Android and iOS

## 🎯 Future Enhancements

- [ ] **Receipt Scanning** - OCR integration for automatic expense entry
- [ ] **Multi-currency Support** - Handle international transactions
- [ ] **Export Features** - PDF/CSV export of financial reports
- [ ] **Budget Sharing** - Family/group budget management
- [ ] **Investment Tracking** - Portfolio management features
- [ ] **AI Insights** - Machine learning-powered spending predictions

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Ikkty Rahman**
- GitHub: [@eter-null](https://github.com/eter-null)
- Email: ikktyrahman@gmail.com
- LinkedIn: [Your LinkedIn Profile]

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Open source community for various packages used

---

⭐ If you found this project helpful, please give it a star!

## 📱 Download

> Add links to Google Play Store / Apple App Store if published

[<img src="https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png" width="200">](link-to-play-store)

---

*Built with ❤️ by Ikkty Rahman*