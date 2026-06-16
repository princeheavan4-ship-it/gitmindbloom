# gitmindbloom

A beautiful iOS GitHub client built with SwiftUI

## Features

- ✅ **GitHub Authentication** - Sign in with your GitHub Personal Access Token
- 🔒 **Secure Token Storage** - Tokens stored securely in Keychain
- 👤 **User Profile** - View your GitHub profile information
- 📚 **Repository Management** - Browse and view your public repositories
- 🌟 **Repository Stats** - See stars, language, and other repo details

## Getting Started

### Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

### Setup

1. Clone the repository
```bash
git clone https://github.com/princeheavan4-ship-it/gitmindbloom.git
cd gitmindbloom
```

2. Open in Xcode
```bash
open gitmindbloom.xcodeproj
```

3. Build and run on simulator or device

## Authentication

The app uses GitHub Personal Access Tokens for authentication:

### Creating a Personal Access Token

1. Go to [GitHub Settings](https://github.com/settings/tokens)
2. Click "Generate new token (classic)"
3. Give it a descriptive name
4. Select scopes:
   - `repo` - Full control of private repositories
   - `user` - Read user profile data
5. Generate and copy the token
6. Paste it into the GitMindBloom sign-in screen

### Security

- Tokens are stored securely using iOS Keychain
- Tokens are never logged or transmitted insecurely
- You can revoke tokens anytime from GitHub settings

## Project Structure

```
Sources/
├── Authentication/
│   ├── AuthenticationManager.swift      # Auth state management
│   ├── KeychainManager.swift            # Secure token storage
│   └── GitHubAPIClient.swift            # API client
├── Views/
│   ├── SignInView.swift                 # Sign-in screen
│   ├── HomeView.swift                   # Home/profile screen
│   └── RepositoriesView.swift           # Repositories list
└── GitMindBloomApp.swift               # App entry point
```

## Architecture

- **MVVM Pattern** - Clean separation of concerns
- **Combine** - Reactive state management
- **SwiftUI** - Modern iOS UI framework
- **Async/Await** - Modern async programming

## License

MIT License - see LICENSE file for details

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.
