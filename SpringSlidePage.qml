import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.12
import QtGraphicalEffects 1.0
import confetti 1.0

BlurryPage {
    id: pageRoot

    property int animationDuration: 400

//    AudioLevels {
//        id: al
//        onInputLevelChanged: console.log(inputLevel)
//    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            button.down = false
            searchBar.focused = false
        }
    }

    TextField {
        id: searchBar

        property bool focused: false

        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.2
        width: 0
        opacity: 0
        visible: false
        placeholderText: "Ask me anything..."
        state: focused ? "focused" : ""

        states: [
            State {
                name: "focused"
                PropertyChanges {
                    target: searchBar
                    visible: true
                    width: parent.width * 0.8
                    opacity: 1
                }
            }
        ]

        transitions: [
            Transition {
                from: ""
                to: "focused"
                reversible: true

                SequentialAnimation {
                    PropertyAction {
                        target: searchBar
                        properties: "visible"
                    }

                    NumberAnimation {
                        target: searchBar
                        properties: "opacity,width"
                        duration: pageRoot.animationDuration
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        ]
    }

    Rectangle {
        id: button

        property bool down: false

        color: "white"
        visible: true
        width: 85
        height: width
        radius: width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        y: (parent.height - height) / 2
        state: down ? "down" : ""

        states: [
            State {
                name: "down"

                PropertyChanges {
                    target: button
                    y: parent.height - 75 - height
                }
            }
        ]

        transitions: [
            Transition {
                from: ""
                to: "down"

                SpringAnimation {
                    target: button
                    properties: "y"
                    spring: 5
                    damping: 0.3
                }
            },
            Transition {
                from: "down"
                to: ""

                SpringAnimation {
                    target: button
                    properties: "y"
                    spring: 5
                    damping: 0.5
                }
            }
        ]

//        onDownChanged: {
//            if (!down)
//                pulsingOverlay.width = 0
//            else
//                pulsingOverlay.width = width * 2
//        }

        Image {
            anchors.fill: parent
            anchors.margins: parent.width * 0.25
            source: "qrc:/microphone.png"
            fillMode: Image.PreserveAspectFit

            LinearGradient {
                anchors.fill: parent
                source: parent
//                lightness: 1
                start: Qt.point(0, 0)
                end: Qt.point(parent.width, parent.height)
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: Qt.lighter(Universal.accent, 1.4)
                    }

                    GradientStop {
                        position: 1.0
                        color: Qt.darker(Universal.accent, 1.4)
                    }
                }
            }
        }

        TapHandler {
            onTapped: {
                button.down = !button.down
                searchBar.focused = !searchBar.focused
            }
        }
    }

    Rectangle {
        color: Universal.accent
        opacity: 0.5
        z: button.z - 2
        anchors.centerIn: button
        width: button.down ? button.width * 3 : 0
        height: width
        radius: width / 2

        Behavior on width {
            SpringAnimation {
                spring: 2
                damping: 0.1
            }
        }
    }

    Rectangle {
        id: pulsingOverlay

        property double smallWidthFactor: 1.75

        color: Qt.lighter(Universal.accent, 1.1)
        opacity: 0.3
        z: button.z - 1
        anchors.centerIn: button
        width: button.width * smallWidthFactor
        visible: button.down
        height: width
        radius: width / 2

        Behavior on width {
            NumberAnimation {
                easing.type: Easing.InOutQuad
                duration: circleWidthTimer.interval
            }
        }
    }

    Timer {
        id: circleWidthTimer

        interval: 2000
        repeat: true
        running: button.down
        triggeredOnStart: true

        onTriggered: {
            if (pulsingOverlay.width == button.width * pulsingOverlay.smallWidthFactor)
                pulsingOverlay.width = button.width * 3 //Math.abs((Math.random() * 3))
            else
                pulsingOverlay.width = button.width * pulsingOverlay.smallWidthFactor
        }
    }
}
