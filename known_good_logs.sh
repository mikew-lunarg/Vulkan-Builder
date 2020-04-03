#! /bin/bash
# Print a git log of commits (max 5) that contain known_good files

ivr git log --graph --decorate --oneline -5 -- scripts/known_good.json
