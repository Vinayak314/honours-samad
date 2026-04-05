// ============================================================
// Q12: Type Casting — Upcasting, Downcasting, is, as, as?, as!,
//      Casting with switch
// ============================================================
// Create a media library system:
//   1. Create a base class `MediaItem` with a property `title: String`.
//   2. Create subclasses:
//       - `Movie: MediaItem` with property `director: String`
//       - `Song: MediaItem` with property `artist: String`
//       - `Podcast: MediaItem` with property `host: String` and `episodes: Int`
//   3. Create an array `library: [MediaItem]` containing a mix of Movies,
//      Songs, and Podcasts. (This demonstrates upcasting.)
//   4. Write a function `countMediaTypes` that uses `is` to count how many
//      of each type are in the library.
//   5. Write a function `describeLibrary` that uses `switch` with `as` pattern
//      matching to print details of each item (casting with switch).
//   6. Write a function `findMovies` that uses `as?` (conditional downcast)
//      to extract only Movie objects from the library.
//   7. Demonstrate forced downcast `as!` on a known type (with caution note).
// ============================================================

class MediaItem { var title: String; init(title: String) { self.title = title } }
class Movie: MediaItem { var director: String; init(t: String, d: String) { director = d; super.init(title: t) } }
class Song: MediaItem { var artist: String; init(t: String, a: String) { artist = a; super.init(title: t) } }
class Podcast: MediaItem { var host: String, episodes: Int; init(t: String, h: String, e: Int) { host=h; episodes=e; super.init(title: t) } }

let library: [MediaItem] = [Movie(t: "A", d: "B"), Song(t: "C", a: "D"), Podcast(t: "E", h: "F", e: 10)]

func countMediaTypes(in libs: [MediaItem]) {
    var movies=0, songs=0, podcasts=0
    for l in libs {
        if l is Movie { movies+=1 }
        else if l is Song { songs+=1 }
        else if l is Podcast { podcasts+=1 }
    }
    print("M:\(movies) S:\(songs) P:\(podcasts)")
}

func describeLibrary(_ libs: [MediaItem]) {
    for l in libs {
        switch l {
        case let m as Movie: print("Movie: \(m.title)")
        case let s as Song: print("Song: \(s.title)")
        case let p as Podcast: print("Podcast: \(p.title)")
        default: print("Other")
        }
    }
}

func findMovies(_ libs: [MediaItem]) -> [Movie] {
    return libs.compactMap { $0 as? Movie }
}

countMediaTypes(in: library)
describeLibrary(library)
print(findMovies(library).count)

let forced = library[0] as! Movie
print(forced.director)

/* 
============================================================
CONCEPT EXPLANATION
============================================================
- Type Checking (`is`): Safely determines whether a referenced polymorphic class explicitly represents a designated subclass format.
- Downcasting (`as?` and `as!`): `as?` carefully projects cast viability mapping into a secure Optional value format. `as!` forces immediate translation resulting in forced runtime application crashes should logic invalidate structural types contextually.
*/
