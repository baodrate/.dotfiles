#!/bin/bash

launchctl unload ~/Library/LaunchAgents/Homebrew.gpg.gpg-agent.plist && launchctl load ~/Library/LaunchAgents/homebrew.gpg.gpg-agent.plist
rm /tmp/homebrew.gpg.gpg-agent.out.log /tmp/homebrew.gpg.gpg-agent.err.log
cat /tmp/homebrew.gpg.gpg-agent.out.log /tmp/homebrew.gpg.gpg-agent.err.log
