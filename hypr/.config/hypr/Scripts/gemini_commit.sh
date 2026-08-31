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

# Format the payload for the Gemini API using jq
prompt="Write a conventional commit message for this diff. Output ONLY the final commit message, no markdown formatting, no quotes, no conversational text. Diff: $diff"
json_payload=$(jq -n --arg p "$prompt" '{contents: [{parts: [{text: $p}]}]}')

# Call Gemini 1.5 Flash
response=$(curl -s -X POST "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash:generateContent?key=$GEMINI_API_KEY" \
  -H 'Content-Type: application/json' \
  -d "$json_payload")
  
# Extract the text
msg=$(echo "$response" | jq -r '.candidates[0].content.parts[0].text // empty' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# Commit if successful
if [ -n "$msg" ] && [ "$msg" != "null" ]; then
  git commit -m "$msg"
  echo "✅ Committed successfully!"
else
  echo "❌ Failed to generate message. Response: $response"
fi
