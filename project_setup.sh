#!/bin/sh

# Check if user only wants to run unit tests
only_test=false
[ "$1" == "only_test" ] && only_test=true

# Check if user wants to create build environment
# and execute the unit tests
with_test=false
[ "$1" == "with_test" ] && with_test=true

# Run fastlane unit tests
unit_test() {
  fastlane test
}

# Run only unit tests
if $only_test 
then
  unit_test
  exit 0
fi

#
# All boostrapping steps
#
command_exists () {
  command -v "$1" > /dev/null 2>&1;
}

echo "🚀 iOS project setup 🚀 \n"

# Check if Homebrew is available
if ! command_exists brew
then
  echo 'Homebrew not found, installing it\n'
  # echo 'https://brew.sh/'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "☕️ Update Homebrew ☕️ \n"
  brew update '2.6.1'
fi

# Check if Ruby is installed
if ! command_exists ruby
then
  # echo 'Ruby not found, please install it:'
  # echo 'https://www.ruby-lang.org/en/downloads/'
  # exit 1
  echo 'Ruby not found, installing it\n'
  brew install ruby
fi

# Install Bundler Gem
if ! command_exists bundle
then
  echo "❓ Bundler not found, installing it ❓ \n"
  gem install bundler -v '2.1.4'
else 
  echo "🔰 Update Bundler 🔰 \n"
  gem update bundler '2.1.4'
fi

# Install Ruby Gems
echo "💎 Install Ruby Gems 💎 \n"
bundle install --verbose

# Install Cocopods dependencies
echo "🍫 Install Cocoapods 🍫 \n"
bundle exec pod install --verbose

# Build xcode
echo "🛠  Build xcode 🛠 \n"
xcodebuild build -workspace Artwork.xcworkspace -scheme Artwork

# Display success message
echo "🥳  Successfully setup project 🥳"

# Opens project
echo "Will open project now..."
open Artwork.xcworkspace

# Run unit tests after project setup
if $with_test
then
  unit_test
fi



