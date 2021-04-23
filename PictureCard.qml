// Inspired by https://dribbble.com/shots/15408670-Explore-Places-App

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.12
import QtGraphicalEffects 1.0

BlurryPage {
    source: img.source

    Image {
        id: img

        width: 300
        height: 450
        source: "qrc:/bw19.jpg"
        fillMode: Image.PreserveAspectCrop
        visible: false
    }

    OpacityMask {
        anchors.centerIn: parent
        width: 300
        height: 450
        source: img
        maskSource: Rectangle {
            width: 300
            height: 450
            radius: 25
        }

        Label {
            id: text

            color: "white"
//                anchors.fill: parent
//                anchors.left: parent.left
//                anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.rightMargin: 30
//            anchors.margins: 10
            text: "◊  4.9"

            Rectangle {
                color: Universal.accent
                anchors.centerIn: parent
                z: parent.z - 1
                width: parent.width + 20
                height: 33
                radius: 15
            }
        }
    }
}
