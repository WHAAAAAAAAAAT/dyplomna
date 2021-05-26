import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Button {
    id: control
    width: 100
    height: 40

    font: ClientLoginConstants.font
    implicitWidth: Math.max(
                       buttonBackground ? buttonBackground.implicitWidth : 0,
                       textItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        buttonBackground ? buttonBackground.implicitHeight : 0,
                        textItem.implicitHeight + topPadding + bottomPadding)
    leftPadding: 4
    rightPadding: 4

    background: buttonBackground
    contentItem: textItem

    property int answerFontSize: 23
    property color buttonColor: "#A078F1"

    Text {
        id: textItem
        text: control.text
        opacity: enabled ? 1 : 0.3
        color: "#F9F9F9"
        font.family: "Candara"
        font.pixelSize: answerFontSize
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        elide: Text.ElideRight
    }

    Rectangle {
        id: buttonBackground
        color: buttonColor
        anchors.fill: parent
        opacity: 1
        radius: 10
    }

    Rectangle {
        id: answersButtonClicked
        anchors.fill: parent
        opacity: 0
        radius: 10
        color: "#F0F0F0"
    }

    states: [
        State {
            name: "normal"
            when: !control.down
            PropertyChanges {
                target: answersButtonClicked
            }
        },
        State {
            name: "down"
            when: control.down
            PropertyChanges {
                target: answersButtonClicked
                opacity: 0.3
            }
        }
    ]
}
