# Image Assets Setup Guide

Your app has been updated to use **local bundled assets** instead of Figma URLs. This makes the app:
- ✅ Faster (no network calls for images)
- ✅ Offline-capable 
- ✅ More reliable

## What Changed

All image paths in `lib/constants/app_constants.dart` now point to local files:
```dart
static const String simCard = 'assets/images/sim_card.png';
static const String earthGlobe = 'assets/images/earth_globe.png';
// etc...
```

## How to Complete Setup

### Option 1: Download from Figma (Recommended)
1. Open your Figma file
2. For each asset, export it as PNG:
   - **Sim Card** → Save to: `assets/images/sim_card.png`
   - **Earth Globe** → Save to: `assets/images/earth_globe.png`
   - **Flags** → Save to: `assets/images/flags/flag_xx.png` (xx = country code)
   - **Destinations** → Save to: `assets/images/destinations/dest_xxx.png`

### Option 2: Use Placeholder Images (for testing)
If you don't have the original images yet, I can create placeholder images.
Just ask and I'll generate simple PNG placeholders for testing.

### Option 3: Use Free Stock Images
Find similar images on:
- Unsplash, Pexels, Pixabay (free stock photos)
- Flagpedia API for flag images
- Download and place in the `assets/images/` folder

## File Structure After Setup

```
assets/
├── images/
│   ├── sim_card.png
│   ├── earth_globe.png
│   ├── flags/
│   │   ├── flag_ca.png
│   │   ├── flag_de.png
│   │   ├── flag_mx.png
│   │   └── ... (all other country flags)
│   └── destinations/
│       ├── dest_turkey.png
│       ├── dest_thailand.png
│       └── ... (all destinations)
```

## After Adding Images

1. Run:
   ```bash
   flutter pub get
   flutter run
   ```

2. The app will now load images locally (no internet needed!)

## Why This Is Better

| Aspect | Before (Figma URLs) | After (Local Assets) |
|--------|-----------------|------------------|
| Speed | Slow (network) | Fast (local) |
| Offline | ❌ Requires internet | ✅ Works offline |
| Reliability | 🟠 Depends on API | ✅ Always works |
| APK Size | Smaller | Slightly larger |

Let me know when you have the images, or I can create placeholders for testing!
