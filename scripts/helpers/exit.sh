#!/bin/bash

function exitingSetup() {
  logError "\n\nExiting Setup...try to fix the issue and try again."
  while :; do logText '\nHit CTRL+C'; sleep 60; done
}
