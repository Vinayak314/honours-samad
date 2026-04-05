// Problem statement 3: Array Playlist Manager
// Use an array to store song names. Add, remove, and sort them. 
// Avoid constraints like loops or custom user functions.

var playlist: [String] = ["Shape of You", "Blinding Lights", "Levitating"]

// Add a New Song
playlist.append("Dance Monkey")

// Remove a Song
let songToRemove = "Shape of You"

if playlist.contains(songToRemove) {
    if let index = playlist.firstIndex(of: songToRemove) {
        playlist.remove(at: index)
        print("Successfully removed '\(songToRemove)'.")
    }
} else {
    print("Song '\(songToRemove)' not found in playlist.")
}

// Sort in Alphabetical Order
playlist.sort()

// Display Songs
print("\nPlaylist (Alphabetical Order):")
print(playlist)
