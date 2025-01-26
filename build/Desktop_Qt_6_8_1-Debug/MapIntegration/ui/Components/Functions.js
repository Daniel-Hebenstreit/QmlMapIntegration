// Declare file as QML library
.pragma library

// Search integration for map component
function search(query, callback) {
    // Check if query is empty
    if (query.trim() == "") {
        return
    }

    // URL Nominatim API request + answer as JSON
    var url = "https://nominatim.openstreetmap.org/search?q=" + encodeURIComponent(query) + "&format=json"
    // New XMLHttpRequest object
    var request = new XMLHttpRequest()
    request.open("GET", url)

    // Define onreadystatechange event handler
    // readystate has 5 states:
    // 0 - UNSENT, 1 - OPENED, 2 - HEADERS_RECEIVED, 3 - LOADING, 4 - DONE
    request.onreadystatechange = function() {

        // Check if request is complete
        if (request.readyState === XMLHttpRequest.DONE) {
            // Check if request was successful
            if (request.status === 200) {
                var response = JSON.parse(request.responseText)

                // Call callback in case there are results
                if (response.length > 0) {
                    var result = response[0]
                    console.log("Search result: " + result.display_name + " (Lat: " + result.lat + ", Lon: " + result.lon + ")");
                    callback(result.lat, result.lon)
                } else {
                    console.log("No results found")
                }
            } else {
                console.log("Error: " + request.statusText)
            }
        }
    }
    request.send()
}

