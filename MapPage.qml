import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.12
import QtPositioning 5.12
import QtLocation 5.12

BlurryPage {
    Plugin {
        id: mapPlugin

        name: "mapboxgl"
    }

    Map {
        id: map

        plugin: mapPlugin
        anchors.fill: parent
        anchors.margins: 20
        center: QtPositioning.coordinate(51.49993830474201, -0.14260811927323402)
        zoomLevel: 16.112999999999964

        Component {
            id: mapCircle

            MapCircle {
                radius: 20
                center: QtPositioning.coordinate(51.49993830474201, -0.14260811927323402)
                color: "orange"
                border.width: 4
            }
        }

        Component.onCompleted: map.addMapItem(mapCircle.createObject())
    }
}
