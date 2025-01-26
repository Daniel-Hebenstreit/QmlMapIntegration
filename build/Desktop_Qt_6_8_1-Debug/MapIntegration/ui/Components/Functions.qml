import QtQuick 2.15

Item {
    id: functions

    function search(query) {
        if (query.trim() == "") {
            return
        }

        var url = "https://nominatim.openstreetmap.org/search?q=" + encodeURIComponent(query) + "&format=json"

        var request = new XMLHttpRequest()
        request.open("GET", url)
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === 200) {
                    var response = JSON.parse(request.responseText)

                    if (response.length > 0) {
                        var result = response[0]
                        console.log("Search result: " + result)
                        mapView.center = QtPositioning.coordinate(result.lat, result.lon)
                        mapView.zoomLevel = 19
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

}
