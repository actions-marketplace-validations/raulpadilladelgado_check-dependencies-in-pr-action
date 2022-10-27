#!/bin/sh -l

chmod +x gradlew
./gradlew dependencyUpdates -Drevision=release -DoutputFormatter=json
outdated=$(jq -r '.outdated.dependencies | .[] | "📦 \(.name)","- \(.version)","+ \(.available.release)"' build/dependencyUpdates/report.json)
if [ -z "$outdated" ]; then
  echo "Congratulations, all your dependencies have the latest releases!"
  exit 0
fi

requestBody={"body": "**Dependencies with newer available releases:**\n```diff\n$outdated\n```"}

curl \
  -X POST \
  "$1" \
  -H "Content-Type: application/json" \
  -H "Authorization: token $2" \
  --data $requestBody
