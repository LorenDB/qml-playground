// Inspired by https://dribbble.com/shots/15418757-Radio-App

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.12
import QtGraphicalEffects 1.0

Page {
    Universal.theme: Universal.Light

    Rectangle {
        id: coloredTopBar

        width: parent.width
        height: 250
        anchors.top: parent.top
        color: Qt.lighter("teal", 1.3)
    }

    TextField {
        id: searchBar

        anchors.verticalCenter: coloredTopBar.bottom
        anchors.horizontalCenter: coloredTopBar.horizontalCenter
        height: 50
        width: parent.width * 0.85
//        anchors.fill: parent
//        anchors.margins: 10
        text: "Hello world!"

        background: Rectangle {
            radius: 5
            color: Universal.background
        }
    }

    DropShadow {
        anchors.fill: searchBar
        radius: 5
        source: searchBar
        color: Universal.foreground
    }
}
