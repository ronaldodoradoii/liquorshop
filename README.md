# Setup the project
### 1. Install Bundler for easier ruby gems versioning
```
sudo gem install bundler
```

### 2. Download gem files using bundler
```
bundle install
```
# Useful command lines
- ### Run all test
```
bundle exec fastlane test
```

- ### Run unit test
```
bundle exec fastlane unit-test
```

- ### Run UI test
```
bundle exec fastlane ui-test
```

- ### Organise files and directories
```
bundle exec fastlane organise
#or
bundle exec synx SpikeEDG.xcodeproj
```

- ### To see all fastlane commands
```
bundle exec fastlane
```


# Swift Package manger issues?
Showing Recent Issues
Resolving Package Graph Failed

In Xcode, click File > Packages -> Reset Package Caches from the menu and then build again.
If that does not do it, first try to restart Xcode and then also try cleaning the build folder as well and try again.
