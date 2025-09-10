# Event Countdown App

A SwiftUI-based iOS application for managing and tracking important events with visual countdown timers.

## Features

### 📅 **Event Management**
- Add new events with custom titles and dates
- Edit existing events with tap-to-edit functionality
- Delete events with swipe gestures or delete actions
- Events automatically sorted chronologically

### 🎨 **Customization**
- **Custom Colors**: Choose personalized colors for event titles
- **Image Attachments**: Add photos from your photo library to events
- **Visual Preview**: See selected images before saving

### ⏰ **Smart Countdown Display**
- **Real-time Updates**: Shows relative time like "in 2 days" or "5 minutes ago"
- **Past & Future Events**: Handles both upcoming and past events
- **Live Formatting**: Updates automatically as time passes

### 💾 **Data Persistence**
- **Automatic Saving**: All events persist between app launches
- **UserDefaults Storage**: Lightweight, reliable data storage
- **Image Persistence**: Photos are saved with events

### 📱 **Modern iOS Interface**
- **NavigationStack**: Native iOS navigation with push/pop animations
- **Form Validation**: Prevents saving events with empty titles
- **PhotosPicker Integration**: Modern iOS 16+ photo selection
- **Responsive Design**: Works on all iOS device sizes

## Usage

### Adding Events
1. Tap the **"+"** button in the navigation bar
2. Enter event title, select date, and choose text color
3. Optionally attach an image by tapping "Select Image"
4. Tap **"Save"** to create the event

### Editing Events
1. Tap any event in the list
2. Modify title, date, color, or image
3. Tap **"Save"** to update

### Deleting Events
- **Swipe left** on any event and tap "Delete"
- Or use the delete action in swipe actions

## Technical Details

- **Platform**: iOS 18.5+
- **Framework**: SwiftUI
- **Data Storage**: UserDefaults with JSON encoding
- **Image Handling**: PhotosPicker with Data persistence
- **Architecture**: MVVM pattern with SwiftUI's declarative approach

## Project Structure

```
Event Countdown/
├── Event.swift              # Data model with Codable support
├── EventsView.swift         # Main list view with navigation
├── EventRow.swift           # Individual event display component
├── EventForm.swift          # Add/edit form with validation
├── ImagePicker.swift        # Photo selection component
├── ContentView.swift        # Root view
└── Event_CountdownApp.swift # App entry point
```

## Requirements

- iOS 18.5 or later
- Xcode 16.0 or later
- Swift 5.0 or later

---

*Built with SwiftUI for a modern, native iOS experience.*