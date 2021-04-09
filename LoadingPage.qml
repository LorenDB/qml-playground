import QtQuick 2.12
import QtQuick.Controls 2.12

BlurryPage {
    id: loadingPageRoot

    ProgressBar {
        id: pb

        anchors.centerIn: parent

        states: State {
            name: "go"

            PropertyChanges {
                target: pb
                value: pb.to
            }
        }

        transitions: [
            Transition {
                reversible: true

                SequentialAnimation {
                    PauseAnimation {
                        duration: 500 / 2
                    }

                    NumberAnimation {
                        target: pb
                        properties: "value"
                        duration: 1000 / 2
                        easing.type: Easing.InOutQuad
                        alwaysRunToEnd: true
                    }

                    PauseAnimation {
                        duration: 500 / 2
                    }

                    ScriptAction {
                        script: confettiRoot.showPage(/*loadingPageRoot.itemToLoad*/)
                    }
                }
            }
        ]

        Label {
            text: qsTr("Loading...")
            anchors.bottom: pb.top
            anchors.horizontalCenter: pb.horizontalCenter
            anchors.margins: 5
        }

        Component.onCompleted: pb.state = "go"
    }
}
