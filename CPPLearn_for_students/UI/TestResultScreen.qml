import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

import Models 1.0
import Controllers 1.0

import "qrc:/UI/courses"

Window {
    id: windowTestResultScreen
    width: ClientLoginConstants.width
    height: ClientLoginConstants.height + animation.height - 50

    property LectureController controller: null

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
        text: RecommendationModel.testResults()
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
            visible: false
        }
        ListView {
            id: view
            anchors.top: recommendationTitle.bottom
            anchors.topMargin: 10
            width: parent.width
            height: 300
            spacing: 10
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds
            clip: true
            model: RecommendationModel
            delegate: Item {
                id: rec
                height: 30
                Text {
                    id: recommendationText
                    text: model.question
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
                MouseArea {
                    anchors.fill: recommendationText
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: {
                        controller.selectText(model.linkToText)
                        windowLectures.show()
//                        windowTestResultScreen.hide()
                        windowMenu.hide()
                    }
                }
            }
        }
        Component.onCompleted: {
            if(RecommendationModel.testSize() > 0)
            {
                recommendationTitle.visible = true
            }
        }
    }
}
