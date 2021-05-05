import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.platform 1.0
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.15

import Controllers 1.0

Rectangle {
    id: textEditor
    color: "#FFFFFF"
    width: parent.width
    height: parent.height
    visible: true

    readonly property var textDocument: document.document

    ColorDialog {
        id: colorDialog
        currentColor: "black"
    }
    MessageDialog {
        id: errorDialog
    }
    MessageDialog {
        id : quitDialog
        title: qsTr("Quit?")
        text: qsTr("The file has been modified. Quit anyway?")
        buttons: (MessageDialog.Yes | MessageDialog.No)
        onYesClicked: Qt.quit()
    }
    ToolBar {
        id: toolBarArea
        anchors.top: parent.top
        width: parent.width
        leftPadding: 8
        background: Rectangle {
            anchors.fill: parent
            color: "#FFFFFF"
        }
    }
    DocumentHandler {
        id: document
        document: textArea.textDocument
        cursorPosition: textArea.cursorPosition
        selectionStart: textArea.selectionStart
        selectionEnd: textArea.selectionEnd
        textColor: colorDialog.color
        onLoaded: {
            textArea.textFormat = format
            textArea.text = text
        }
        onError: {
            errorDialog.text = message
            errorDialog.visible = true
        }
    }

    Flickable {
        id: flickable
        flickableDirection: Flickable.VerticalFlick
        anchors.top: toolBarArea.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        width: parent.width
        TextArea.flickable: TextArea {
            id: textArea
            textFormat: Qt.RichText
            wrapMode: TextArea.Wrap
            focus: true
            selectByMouse: true
            persistentSelection: true
            leftPadding: 6
            rightPadding: 6
            topPadding: 6
            bottomPadding: 6
            background: null
            readOnly: true
            MouseArea {
                acceptedButtons: Qt.RightButton
                anchors.fill: parent
                onClicked: contextMenu.open()
            }
            onLinkActivated: Qt.openUrlExternally(link)
        }
        ScrollBar.vertical: ScrollBar {}
    }
    Menu {
        id: contextMenu
        MenuItem {
            text: qsTr("Скопіювати")
            enabled: textArea.selectedText
            onTriggered: textArea.copy()
        }
    }
}
