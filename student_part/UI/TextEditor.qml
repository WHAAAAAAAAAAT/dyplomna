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

    /*Shortcut {
        sequence: StandardKey.Open
        onActivated: openDialog.open()
    }
    Shortcut {
        sequence: StandardKey.SaveAs
        onActivated: saveDialog.open()
    }
    Shortcut {
        sequence: StandardKey.Quit
        onActivated: close()
    }
    Shortcut {
        sequence: StandardKey.Copy
        onActivated: textArea.copy()
    }
    Shortcut {
        sequence: StandardKey.Cut
        onActivated: textArea.cut()
    }
    Shortcut {
        sequence: StandardKey.Paste
        onActivated: textArea.paste()
    }
    Shortcut {
        sequence: StandardKey.Bold
        onActivated: document.bold = !document.bold
    }
    Shortcut {
        sequence: StandardKey.Italic
        onActivated: document.italic = !document.italic
    }
    Shortcut {
        sequence: StandardKey.Underline
        onActivated: document.underline = !document.underline
    }
    FileDialog {
        id: openDialog
        fileMode: FileDialog.OpenFile
        selectedNameFilter.index: 1
        nameFilters: ["Text files (*.txt)", "HTML files (*.html *.htm)", "Markdown files (*.md *.markdown)"]
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        onAccepted: document.load(file)
    }
    FileDialog {
        id: saveDialog
        fileMode: FileDialog.SaveFile
        defaultSuffix: document.fileType
        nameFilters: openDialog.nameFilters
        selectedNameFilter.index: document.fileType === "txt" ? 0 : 1
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        onAccepted: document.saveAs(file)
    }
    FontDialog {
        id: fontDialog
        onAccepted: {
            document.fontFamily = font.family;
            document.fontSize = font.pointSize;
        }
    }*/
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
            /*layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                color: "#A4A4A4"
                radius: 15
                samples: 1 + radius * 2
                verticalOffset: 5
                horizontalOffset: 1
            }*/
        }
        /*Flow {
            id: flow
            width: parent.width
            Row {
                id: fileRow
                ToolButton {
                    id: openButton
                    palette.button: "white"
                    text: "\uF115" // icon-folder-open-empty
                    font.family: "fontello"
                    onClicked: openDialog.open()
                }
                ToolSeparator {
                    contentItem.visible: fileRow.y === editRow.y
                }
            }
            Row {
                id: editRow
                ToolButton {
                    id: copyButton
                    palette.button: "white"
                    text: "\uF0C5" // icon-docs
                    font.family: "fontello"
                    focusPolicy: Qt.TabFocus
                    enabled: textArea.selectedText
                    onClicked: textArea.copy()
                }
                ToolButton {
                    id: cutButton
                    palette.button: "white"
                    text: "\uE802" // icon-scissors
                    font.family: "fontello"
                    focusPolicy: Qt.TabFocus
                    enabled: textArea.selectedText
                    onClicked: textArea.cut()
                }
                ToolButton {
                    id: pasteButton
                    palette.button: "white"
                    text: "\uF0EA" // icon-paste
                    font.family: "fontello"
                    focusPolicy: Qt.TabFocus
                    enabled: textArea.canPaste
                    onClicked: textArea.paste()
                }
                ToolSeparator {
                    contentItem.visible: editRow.y === formatRow.y
                }
            }
            Row {
                id: formatRow
                ToolButton {
                    id: boldButton
                    palette.button: "white"
                    text: "\uE800" // icon-bold
                    font.family: "fontello"
                    focusPolicy: Qt.TabFocus
                    checkable: true
                    checked: document.bold
                    onClicked: document.bold = !document.bold
                }
                ToolButton {
                    id: italicButton
                    palette.button: "white"
                    text: "\uE801" // icon-italic
                    font.family: "fontello"
                    focusPolicy: Qt.TabFocus
                    checkable: true
                    checked: document.italic
                    onClicked: document.italic = !document.italic
                }
                ToolButton {
                    id: underlineButton
                    palette.button: "white"
                    text: "\uF0CD" // icon-underline
                    font.family: "fontello"
                    focusPolicy: Qt.TabFocus
                    checkable: true
                    checked: document.underline
                    onClicked: document.underline = !document.underline
                }
                ToolButton {
                    id: fontFamilyToolButton
                    palette.button: "white"
                    text: qsTr("\uE808") // icon-font
                    font.family: "fontello"
                    font.bold: document.bold
                    font.italic: document.italic
                    font.underline: document.underline
                    onClicked: {
                        fontDialog.currentFont.family = document.fontFamily;
                        fontDialog.currentFont.pointSize = document.fontSize;
                        fontDialog.open();
                    }
                }
                ToolButton {
                    id: textColorButton
                    palette.button: "white"
                    text: "\uF1FC" // icon-brush
                    font.family: "fontello"
                    focusPolicy: Qt.TabFocus
                    onClicked: colorDialog.open()

                    Rectangle {
                        width: aFontMetrics.width + 3
                        height: 2
                        color: document.textColor
                        parent: textColorButton.contentItem
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.baseline: parent.baseline
                        anchors.baselineOffset: 6
                        TextMetrics {
                            id: aFontMetrics
                            font: textColorButton.font
                            text: textColorButton.text
                        }
                    }
                }
                ToolSeparator {
                    contentItem.visible: formatRow.y === alignRow.y
                }
            }
            Row {
                id: alignRow
                ToolButton {
                    id: alignLeftButton
                    palette.button: "white"
                    text: "\uE803" // icon-align-left
                    font.family: "fontello"
                    focusPolicy: Qt.TabFocus
                    checkable: true
                    checked: document.alignment == Qt.AlignLeft
                    onClicked: document.alignment = Qt.AlignLeft
                }
                ToolButton {
                    id: alignCenterButton
                    palette.button: "white"
                    text: "\uE804" // icon-align-center
                    font.family: "fontello"
                    focusPolicy: Qt.TabFocus
                    checkable: true
                    checked: document.alignment == Qt.AlignHCenter
                    onClicked: document.alignment = Qt.AlignHCenter
                }
                ToolButton {
                    id: alignRightButton
                    palette.button: "white"
                    text: "\uE805" // icon-align-right
                    font.family: "fontello"
                    focusPolicy: Qt.TabFocus
                    checkable: true
                    checked: document.alignment == Qt.AlignRight
                    onClicked: document.alignment = Qt.AlignRight
                }
                ToolButton {
                    id: alignJustifyButton
                    palette.button: "white"
                    text: "\uE806" // icon-align-justify
                    font.family: "fontello"
                    focusPolicy: Qt.TabFocus
                    checkable: true
                    checked: document.alignment == Qt.AlignJustify
                    onClicked: document.alignment = Qt.AlignJustify
                }
            }
        }*/
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
            //text: "123"
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
            text: qsTr("Copy")
            enabled: textArea.selectedText
            onTriggered: textArea.copy()
        }
        /*MenuItem {
            text: qsTr("Cut")
            enabled: textArea.selectedText
            onTriggered: textArea.cut()
        }
        MenuItem {
            text: qsTr("Paste")
            enabled: textArea.canPaste
            onTriggered: textArea.paste()
        }
        MenuSeparator {}
        MenuItem {
            text: qsTr("Font...")
            onTriggered: fontDialog.open()
        }
        MenuItem {
            text: qsTr("Color...")
            onTriggered: colorDialog.open()
        }*/
    }
}
