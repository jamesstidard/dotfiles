#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

defaults write NSGlobalDomain InitialKeyRepeat -int 25

defaults write NSGlobalDomain KeyRepeat -int 2

# Finder
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -int 1

defaults write com.apple.finder ShowRemovableMediaOnDesktop -int 1

defaults write com.apple.finder ShowHardDrivesOnDesktop -int 0

defaults write com.apple.finder ShowMountedServersOnDesktop -int 1

defaults write com.apple.finer WarnOnEmptyTrash -int 0

# Dock
defaults write com.apple.dock autohide -int 0

defaults write com.apple.dock expose-group-apps -int 0

defaults write com.apple.dock largesize -int 44

defaults write com.apple.dock magnification -int 0

defaults write com.apple.dock orientation -string "left"

defaults write com.apple.dock show-recents -int 0

defaults write com.apple.dock tilesize -int 36

defaults write com.apple.dock trash-full -int 1

# Kill affected applications
for app in \
	"Dock" \
	"Finder"; do
	killall "${app}" &> /dev/null
done
