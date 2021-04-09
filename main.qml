import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Particles 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Universal 2.12

Window {
    id: confettiRoot

    visible: true
    width: 500
    height: 840
    title: qsTr("Hello World")

    property string itemToShow

    function loadPage(pageToLoad) {
        loader.sourceComponent = loadingPage
        itemToShow = pageToLoad
    }

    function showPage() {
        loader.source = itemToShow
    }

    Loader {
        id: loader

        anchors.fill: parent
        sourceComponent: navPage
    }

    Component {
        id: navPage

        NavPage {
            anchors.fill: parent

            model: ListModel {
                ListElement {
                    name: "Media Player"
                    file: "MediaPlayerPage.qml"
                }
                ListElement {
                    name: "Map"
                    file: "MapPage.qml"
                }
                ListElement {
                    name: "Microphone Page"
                    file: "SlideButtonPage.qml"
                }
                ListElement {
                    name: "Spring Animation"
                    file: "SpringSlidePage.qml"
                }
                ListElement {
                    name: "Card with embed"
                    file: "PictureCard.qml"
                }
                ListElement {
                    name: "Bordering colors"
                    file: "ControlOnBorder.qml"
                }
            }
        }
    }

    Component {
        id: loadingPage

        LoadingPage {
            id: lp

            anchors.fill: parent
        }
    }
}
