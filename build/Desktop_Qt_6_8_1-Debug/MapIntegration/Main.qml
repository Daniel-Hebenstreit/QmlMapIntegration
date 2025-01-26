import QtQuick
import QtLocation
import "ui/Components"

Window {
    width: 1024
    height: 720
    visible: true
    title: qsTr("Map Integration")



    Rectangle {
        id: window
        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        property double latitude: 51.07
        property double longitude: 13.73

        Plugin {
            id: osmMapView
            name: "osm"
        }

        MapComponent {
            id: mapView
        }

        SearchBar {
            id: searchBar
        }

        OkButton {
            id: okBtn
        }
    }


}


