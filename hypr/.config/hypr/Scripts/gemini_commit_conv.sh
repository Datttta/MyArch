#!/bin/bash

GEMINI_API_KEY="$(head -n 1 "$HOME/Repos/MyFiles/gemini_api.txt")"

git add -A

# Get the staged diff
diff=$(git diff --staged)
if [ -z "$diff" ]; then
  echo "No changes staged."
  exit 1
fi

echo "🧠 Asking Gemini..."

# Prompt asking for structured JSON
prompt="Analyze this git diff and create a conventional commit message.
Return JSON with two keys:
1. 'title': Conventional commit subject line (e.g. refactor(scope): description)
2. 'body': Brief high-level summary paragraph, followed by a empty line, then bullet points starting with '* ' detailing the exact file/structural changes.

Diff:
$diff"

json_payload=$(jq -n --arg p "$prompt" '{
  contents: [{parts: [{text: $p}]}],
  generationConfig: { response_mime_type: "application/json" }
}')

response=$(curl -s -X POST "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash:generateContent?key=$GEMINI_API_KEY" \
  -H 'Content-Type: application/json' \
  -d "$json_payload")

# Extract title and body from the JSON response
title=$(echo "$response" | jq -r '.candidates[0].content.parts[0].text | fromjson | .title')
body=$(echo "$response" | jq -r '.candidates[0].content.parts[0].text | fromjson | .body')

if [ -n "$title" ] && [ "$title" != "null" ]; then
  echo -e "$title"
  echo -e "\n$body\n"
  
  git commit -m "$title" -m "$body"
  echo "✅ Committed successfully!"
else
  echo "❌ Failed to generate message. Response: $response"
fi
