import UIKit



// Removing special characters 
var Words = """
    "Back" : {

    },
    "Cancel" : {

    },
    "Create" : {

    },
    "Create Genre" : {

    },
    "Create new Genre" : {

    },
    "Date Added" : {

    },
    "Date Completed" : {

    },
    "Date Started" : {

    },
    "Enter your first book" : {

    },
    "Genres" : {

    },
    "My Manga" : {

    },
    "name" : {

    },
    "New Genre" : {

    },
    "New Manga" : {

    },
    "Page" : {

    },
    "Page: %@" : {

    },
    "Rating" : {

    },
    "Recommended By" : {

    },
    "Search by title or author." : {

    },
    "Set the genre color" : {

    },
    "Sort by %@" : {

    },
    "Status" : {

    },
    "Synopsis" : {

    },
    "Title" : {

    },
    "Update" : {

    },
    "You need to create some genres first." : {

    }
"""

var keyWords: String {
    Words.replacingOccurrences(of: " : {", with: "")
        .replacingOccurrences(of:"    \"", with: "")
        .replacingOccurrences(of: "\"\n\n    },", with: "")
        .replacingOccurrences(of: "\"\n\n    }", with: "")
}


print(keyWords)
