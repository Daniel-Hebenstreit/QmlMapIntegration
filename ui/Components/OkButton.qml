import QtQuick 2.15
import QtPositioning
import "Functions.js" as Functions

Rectangle {
    id: okBtn

    width: 50
    height: searchBar.height
    radius: 5

    anchors {
        top: parent.top
        topMargin: 10
        left: searchBar.right
        leftMargin: 10
    }

    color: "lightgrey"

    border {
        color: "grey"
        width: 1

    }

    Text{
        anchors.centerIn: parent

        text: "ok"
        color: "black"

        font.pixelSize: 13
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            console.log("Search: " + searchBar.searchText)

            Functions.search(searchBar.searchText,
                            function(lat, lon) {
                                                                console.log(QtPositioning.coordinate(lat, lon))
                                // Jump to new location
                                mapView.center = QtPositioning.coordinate(lat, lon)
                                mapView.zoomLevel = 19

                                // Show marker at new coordinates
                                mapView.marker.coordinate = QtPositioning.coordinate(lat, lon)


                            })
        }
    }
}
