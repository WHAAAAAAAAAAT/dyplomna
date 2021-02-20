import QtQuick 2.15
import QtQuick.Templates 2.1 as T

T.Button {
    id: controlRegistration
    width: 300
    height: 20

    font: LoginConstants.font
    implicitWidth: Math.max(
                       registrationButtonBackground ? registrationButtonBackground.implicitWidth : 0,
                       registrationTextItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        registrationButtonBackground ? registrationButtonBackground.implicitHeight : 0,
                        registrationTextItem.implicitHeight + topPadding + bottomPadding)
    leftPadding: 4
    rightPadding: 4

    background: registrationButtonBackground
    contentItem: registrationTextItem

    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


    Text {
        id: registrationTextItem
        text: controlRegistration.text
        opacity: enabled ? 1 : 0.3
        color: "#000000"
        font.family: LoginConstants.font.family
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        elide: Text.ElideRight
    }

    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


    Rectangle {
        id: registrationButtonBackground
        implicitWidth: 300
        implicitHeight: 20
        opacity: 0
        color: LoginConstants.backgroundColor
        anchors.fill: parent
    }

    states: [
        State {
            name: "normal"
            when: !controlRegistration.down
            PropertyChanges {
                target: registrationButtonBackground
            }
        },
        State {
            name: "down"
            when: controlRegistration.down
            PropertyChanges {
                target: registrationTextItem
                color: "#6218A3"
            }
        }
    ]
}
