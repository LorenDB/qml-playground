import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Page {
    property alias source: backgroundImage.source

    Image {
        id: backgroundImage

        property var pics: ["pic.jpg", "bw5.jpg", "bw10.jpg", "bw15.jpg", "bw18.jpg", "bw19.jpg"]

        anchors.fill: parent
        source: "qrc:/" + pics[Math.floor((Math.random() * 100)) % pics.length]
        fillMode: Image.PreserveAspectCrop
        visible: false
    }

    FastBlur {
        source: backgroundImage
        anchors.fill: parent
        radius: 144
        opacity: 0.15
    }
}
