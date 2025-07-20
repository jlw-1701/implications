#!/bin/bash

CONFIG_FILE="config.toml"
cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"

if grep -q "^baseURL" "$CONFIG_FILE"; then
  sed -i 's|^baseURL.*|baseURL = "https://jlw-1701.github.io/implications/"|' "$CONFIG_FILE"
else
  echo 'baseURL = "https://jlw-1701.github.io/implications/"' >> "$CONFIG_FILE"
fi

if ! grep -q "^publishDir" "$CONFIG_FILE"; then
  echo 'publishDir = "public"' >> "$CONFIG_FILE"
fi

hugo --minify

git add .
git commit -m "Fix baseURL for GitHub Pages deployment"
git push origin main

echo "Script finished. Wait a minute or two and then check https://jlw-1701.github.io/implications/"
