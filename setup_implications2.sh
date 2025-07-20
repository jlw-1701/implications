#!/bin/bash

set -e

echo "🛠️ Setting up GitHub Actions for Hugo deployment..."

mkdir -p .github/workflows

cat > .github/workflows/deploy.yml << 'EOF'
name: Build and Deploy Hugo Site to GitHub Pages

on:
  push:
    branches:
      - main

permissions:
  contents: write

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v3
        with:
          hugo-version: '0.110.0'  # Known stable version

      - name: Build
        run: hugo --minify

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
EOF

git add .github/workflows/deploy.yml
git commit -m "✅ Add stable GitHub Actions workflow for Hugo deploy"
git push -u origin main

echo "🎉 Workflow pushed! Check the Actions tab on GitHub for status."
