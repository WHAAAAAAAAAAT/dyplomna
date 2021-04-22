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

    property int loginfontSize: 16

    Text {
        id: textItem
        text: control.text
        opacity: enabled ? 1 : 0.3
        color: "#111111"
        font.family: ClientLoginConstants.font.family
        font.pixelSize: loginfontSize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        elide: Text.ElideRight
    }

    Rectangle {
        id: buttonBackground
        implicitWidth: 120
        implicitHeight: 40
        opacity: enabled ? 0.75 : 0.3
        border.color: "#7C7C7C"
        border.width: 1
        anchors.fill: parent
        radius: 22
    }

    states: [
        State {
            name: "normal"
            when: !control.down
            PropertyChanges {
                target: buttonBackground
            }
        },
        State {
            name: "down"
            when: control.down
            PropertyChanges {
                target: textItem
                color: "#ffffff"
            }
            PropertyChanges {
                target: buttonBackground
                color: "#9B93EB"
            }
        }
    ]
}
