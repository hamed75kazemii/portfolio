#!/bin/bash

# Flutter Portfolio Deployment Script
echo "🚀 Starting Flutter Portfolio Deployment..."

# Set Chinese mirrors for better connectivity
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# Clean and get dependencies
echo "📦 Getting dependencies..."
flutter clean
flutter pub get

# Build for web
echo "🔨 Building for web..."
flutter build web --release

# Check if build was successful
if [ -d "build/web" ]; then
    echo "✅ Build successful!"
    echo "📁 Build files are in: build/web/"
    echo ""
    echo "🌐 To deploy to GitHub Pages:"
    echo "1. Push your code to GitHub"
    echo "2. Enable GitHub Pages in repository settings"
    echo "3. Set source to 'GitHub Actions'"
    echo "4. The workflow will automatically deploy on push to main branch"
    echo ""
    echo "📋 Manual deployment steps:"
    echo "1. Copy contents of build/web/ to your GitHub Pages branch"
    echo "2. Or use: gh-pages -d build/web"
else
    echo "❌ Build failed!"
    exit 1
fi
