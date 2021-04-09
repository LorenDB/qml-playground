import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.12
import QtGraphicalEffects 1.0

BlurryPage {
    id: pageRoot

    property int animationDuration: 400

    MouseArea {
        anchors.fill: parent
        onClicked: {
            searchBar.focused = false
            button.down = false
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
        placeholderText: "Search for anything..."
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
        width: 150
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
                    width: 75
                    y: parent.height - 75 - height
                }
            }
        ]

        transitions: [
            Transition {
                from: ""
                to: "down"
                reversible: true

                ParallelAnimation {
                    NumberAnimation {
                        target: button
                        property: "width"
                        duration: pageRoot.animationDuration
                        easing.type: Easing.InOutBack
                    }

                    NumberAnimation {
                        target: button
                        properties: "y"
                        duration: pageRoot.animationDuration
                        easing.type: Easing.InOutBack
                        easing.overshoot: 1
                    }

//                    SpringAnimation {
//                        target: button
//                        properties: "y"
//                        spring: 5
//                        damping: 0.5
//                        duration: pageRoot.animationDuration
//                    }
                }
            }
        ]

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
}
