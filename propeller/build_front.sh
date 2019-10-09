#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

cd ~/IdeaProjects/nativator/js/node_modules/ && rm -rf .cache && yarn install && yarn build
