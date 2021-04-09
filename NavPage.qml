import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

BlurryPage {
    property alias model: list.model

    ColumnLayout {
        spacing: 10
        anchors.centerIn: parent
        anchors.margins: 10
        width: parent.width * 0.33
        height: parent.height

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Repeater {
            id: list

            delegate: Button {
                Layout.fillWidth: true
                width: parent.width
                anchors.margins: 5
                text: model.name
                onClicked: confettiRoot.loadPage(model.file)
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
