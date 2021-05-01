import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

Window {
    id: windowTestResultScreen
    width: ClientLoginConstants.width
    height: ClientLoginConstants.height
    Rectangle {
        id: rectangleBackground
        width: parent.width
        height: parent.height
        opacity: 0.8
        AnimatedImage {
            id: animationBackground
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/loginBackground.gif"
            width: parent.width
            height: parent.height
        }
        visible: true
    }
    visible: true
    ClientLoginController {
        id: controller
        onLoginFail: {
            errorOn.start()
        }
        onLoginSuccess: {
            mainWindow.hide()
            menuWindow.show()
        }
    }
    Text {
        id: pageTitle
        text: qsTr("ВХІД")
        color: "#181818"
        anchors.top: parent.top
        font.pixelSize: 45
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: ClientLoginConstants.font.family
    }
}
