import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id: windowChat
    width: 540
    height: 680
    signal exitWindowChat

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: ContactPage {}
    }
}

