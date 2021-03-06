#!/bin/bash -e
set -o pipefail
# set -o errexit

if [ "$TRAVIS_BRANCH" = "master" ] && [ "$TRAVIS_PULL_REQUEST" = "false" ]  && [ "$TRAVIS_NODE_VERSION" = "5.1" ]
then
  build_polymer () {
    echo Bulding with polymer-cli
    polymer build
    cp -r images build/bundled/
    cp -r bower_components build/bundled/
  }

  deploy_firebase () {
    echo Deploying to Firebase
    firebase deploy --token "$FIREBASE_TOKEN" -m "Auto Deployed by Travis CI"
  }

  build_polymer
  deploy_firebase
fi
