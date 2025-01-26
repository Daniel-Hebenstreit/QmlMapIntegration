import QtQuick 2.15
import QtLocation
import QtPositioning

Map {
    id: mapView

    anchors.fill: parent
    plugin: osmMapView
    center: QtPositioning.coordinate(window.latitude, window.longitude)
    zoomLevel: 14

    property alias marker: marker

    WheelHandler {
        id: wheel
        // workaround for QTBUG-87646 / QTBUG-112394 / QTBUG-112432:
        // Magic Mouse pretends to be a trackpad but doesn't work with PinchHandler
        // and we don't yet distinguish mice and trackpads on Wayland either
        acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                         ? PointerDevice.Mouse | PointerDevice.TouchPad
                         : PointerDevice.Mouse
        rotationScale: 1/120
        property: "zoomLevel"
    }

    DragHandler {
        id: drag
        target: null
        onTranslationChanged: (delta) => mapView.pan(-delta.x, -delta.y)
    }

    // Ctrl +
    Shortcut {
        enabled: mapView.zoomLevel < mapView.maximumZoomLevel
        sequence: StandardKey.ZoomIn
        onActivated: mapView.zoomLevel = Math.round(mapView.zoomLevel + 1)
    }

    // Ctrl -
    Shortcut {
        enabled: mapView.zoomLevel > mapView.minimumZoomLevel
        sequence: StandardKey.ZoomOut
        onActivated: mapView.zoomLevel = Math.round(mapView.zoomLevel - 1)
    }

    MouseArea {
        anchors.fill: parent

        // Capture coordinates of clicked position
        onClicked: {
            var clickPos = mapView.toCoordinate(Qt.point(mouse.x, mouse.y))
            marker.coordinate = clickPos

            console.log(clickPos)

        }
    }

    // Marker integration
    MapQuickItem {
        id: marker

        // Defines which part of the image points to the coordinates (top of the marker)
        anchorPoint.x: image.width/2
        anchorPoint.y: image.height

        coordinate: {
            mapView.center
        }

        sourceItem: Image {
            id: image
            width: 48
            height: 48
            source: "qrc:/ui/assets/marker.png"
        }

        // HoverHandler {
        //     id: hoverHandler
        // }
        // TapHandler {
        //     id: tapHandler
        //     acceptedButtons: Qt.RightButton
        //     gesturePolicy: TapHandler.WithinBounds
        //     onTapped: {
        //         mapView.currentMarker = -1
        //         for (var i = 0; i< mapview.markers.length; i++){
        //             if (marker == mapview.markers[i]){
        //                 mapview.currentMarker = i
        //                 break
        //             }
        //         }
        //         mapview.showMarkerMenu(marker.coordinate)
        //     }
        // }
        // DragHandler {
        //     id: dragHandler
        //     grabPermissions: PointerHandler.CanTakeOverFromItems | PointerHandler.CanTakeOverFromHandlersOfDifferentType
        // }

    }
}
