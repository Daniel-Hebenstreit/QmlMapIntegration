import QtQuick 2.15
import QtPositioning
import "Functions.js" as Functions

Rectangle {
    id: searchBar

    property string searchText: searchInput.text

    width: 200
    height: 30
    radius: 5

    anchors {
        top: parent.top
        topMargin: 10
        left: parent.left
        leftMargin: 10
    }

    color: "lightgrey"

    border {
         color: "grey"
         width: 1
    }

    Text {
        visible: searchInput.text === ""

        anchors{
            left: parent.left
            leftMargin: 15
            verticalCenter: parent.verticalCenter
        }


        font.pixelSize: 13
        font.bold: true
        color: "black"
        text: "Search"
    }

    TextInput {
        id: searchInput

        anchors{
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: parent.left
            leftMargin: 15
        }

        verticalAlignment: Text.AlignVCenter

        clip: true
        color: "black"
        font.pixelSize: 13
        font.bold: true

        Keys.onReturnPressed: {
            console.log("Search: " + searchBar.searchText)
            Functions.search(searchBar.searchText,
                            function(lat, lon) {
                                // Jump to new location
                                mapView.center = QtPositioning.coordinate(lat, lon)
                                mapView.zoomLevel = 19

                                // Show marker at new coordinates
                                mapView.marker.coordinate = QtPositioning.coordinate(lat, lon)
                            })
        }
    }
}

// TextField {
//     id: searchBar

//     width: 250
//     anchors {
//         top: parent.top
//         left: parent.left
//         topMargin: 10
//         leftMargin: 10
//     }
//     placeholderText: "Search"

//     font.pixelSize: 13
//     font.bold: true
// }
