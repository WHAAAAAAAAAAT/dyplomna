import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

Window {
    id: windowTestResultScreen
    width: ClientLoginConstants.width
    height: ClientLoginConstants.height + animation.height - 50
    Rectangle {
        id: rectangleBackground
        width: parent.width
        height: parent.height
        opacity: 0.8
        color: "#FFFFFF"
    }
    Text {
        id: testResultTitle
        text: qsTr("Тест завершено!")
        color: "#181818"
        anchors.top: parent.top
        font.pixelSize: 30
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: ClientLoginConstants.font.family
    }
    Text {
        id: testResultTitle2
        text: qsTr("Ваш результат:")
        color: "#181818"
        anchors.top: testResultTitle.bottom
        font.pixelSize: 30
        anchors.topMargin: 3
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: ClientLoginConstants.font.family
    }
    Text {
        id: result
        text: "4/5"
        color: "#218C0E"
        anchors.top: testResultTitle2.bottom
        font.pixelSize: 105
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: ClientLoginConstants.font.family
    }
    AnimatedImage {
        id: animation
        anchors.top: result.bottom
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        source: "images/testResultScreen.gif"
        width: parent.width * 0.45
        height: ClientLoginConstants.height * 0.55
    }
    Rectangle {
        id: recommendationRect
        width: parent.width
        anchors.top: animation.bottom
        anchors.topMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 20
        color: "transparent"
        Text {
            id: recommendationTitle
            anchors.top: parent.top
            text: qsTr("Рекомендації:")
            font.pixelSize: 27
            font.family: ClientLoginConstants.font.family
        }
        Text {
            id: recommendationText
            anchors.top: recommendationTitle.bottom
            anchors.topMargin: 10
            text: qsTr("С++ - це...")
            font.pixelSize: 25
            font.family: ClientLoginConstants.font.family
            color: "#D31717"
        }
        DropShadow {
            anchors.fill: recommendationText
            source: recommendationText
            verticalOffset: 1
            color: "#D14747"
            opacity: 0.8
            radius: 3
            samples: 5
        }
    }
}
