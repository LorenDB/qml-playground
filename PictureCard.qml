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

        Rectangle {
            color: Universal.accent
            width: 100
            height: width / 3
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 20
            radius: 15

            Label {
                id: text

                anchors.centerIn: parent
//                anchors.left: parent.left
//                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
                text: "◊  ◊  ◊  ◊  ◊"
            }
        }
    }
}
