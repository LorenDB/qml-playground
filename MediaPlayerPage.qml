import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.12
import QtQuick.Layouts 1.12
import QtMultimedia 5.12
import QtGraphicalEffects 1.0

BlurryPage {
    source: player.metaData.coverArtUrlLarge ? player.metaData.coverArtUrlLarge : "qrc:/bw5.jpg"

    Image {
        id: albumArt

        source: player.metaData.coverArtUrlLarge // "qrc:/AlbumArt.jpg"
        anchors.horizontalCenter: parent.horizontalCenter
        y: (songTitle.y - height) / 2
        width: Math.min(parent.width, parent.height) * 0.5
        height: width
        fillMode: Image.PreserveAspectFit
    }

    Label {
        id: songTitle

        text: player.metaData.title
        anchors.bottom: musicProgressBar.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        width: parent.width * 0.85
    }

    Slider {
        id: musicProgressBar

        anchors.bottom: button.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        width: parent.width * 0.85
        from: 0
        to: player.duration
        value: player.position
        handle.opacity: 0.0

        states: [
            State {
                name: "hovered"

                PropertyChanges {
                    target: musicProgressBar.handle
                    opacity: 1.0
                }
            }
        ]

        transitions: [
            Transition {
                from: ""
                to: "hovered"
                reversible: true

                NumberAnimation {
                    target: musicProgressBar.handle
                    property: "opacity"
                    duration: 500
                    easing.type: Easing.InOutQuad
                    alwaysRunToEnd: true
                }
            }
        ]

        onMoved: player.seek(value)

        HoverHandler {
            id: hh

            onHoveredChanged: {
                if (hovered)
                {
                    musicProgressBar.state = "hovered"
                    handleVisibleTimer.stop()
                }
                else
                    handleVisibleTimer.start()
            }
        }

        Timer {
            id: handleVisibleTimer

            interval: 3000
            repeat: false
            running: false
            onTriggered: musicProgressBar.state = ""
        }
    }

    Rectangle {
        id: button

        property bool wantsToPlay: false
        property bool playing: !musicProgressBar.pressed && wantsToPlay

        color: "white"
        visible: true
        width: 75
        height: width
        radius: width / 2
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height - height * 3 / 2

        onPlayingChanged: {
            if (!playing)
                player.pause()
            else
                player.play()
        }

        LinearGradient {
            anchors.fill: parent
            source: parent
            start: Qt.point(0, 0)
            end: Qt.point(parent.width, parent.height)

            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#008a00" // Qt.lighter(Universal.accent, 1.2)
                }

                GradientStop {
                    position: 1.0
                    color: "#00aba9" // Qt.darker(Universal.accent, 1.2)
                }
            }
        }

        Image {
            anchors.fill: parent
            anchors.margins: parent.width * 0.25
            source: button.wantsToPlay ? "qrc:/pause.png" : "qrc:/play.png"
            smooth: true
            fillMode: Image.PreserveAspectFit

            Colorize {
                anchors.fill: parent
                source: parent
                lightness: 1
            }
        }

        TapHandler {
            onTapped: button.wantsToPlay = !button.wantsToPlay
        }

        Shortcut {
            sequences: [Qt.Key_MediaTogglePlayPause, "Space"]
            onActivated: button.wantsToPlay = !button.wantsToPlay
        }

        MediaPlayer {
            id: player

            source: "qrc:/music.mp3"

            onStopped: button.wantsToPlay = false
//            onPositionChanged: if (position == duration) button.wantsToPlay = false
        }
    }
}
