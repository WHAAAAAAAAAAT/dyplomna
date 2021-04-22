import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: mainWindow
    visible: true
    width: ClientLoginConstants.width
    height: ClientLoginConstants.height
    title: qsTr("CPPLearn")

    StackView {
        id: stackView
        anchors.fill: parent
        focus: true
        initialItem: loginScreenStackComponent

        Component {
            id: loginScreenStackComponent
            ClientLoginScreen {
                id: loginScreen
                enabled: stackView.status === stackView.Active
            }
        }

        Component {
            id: registrationScreenStackComponent
            ClientRegistrationScreen {
                id: registrationScreen
                enabled: stackView.status === stackView.Active
            }
        }

        Keys.onReleased: {
            if (event.key === Qt.Key_Back)
                pageBack(event);
        }

        Keys.onPressed: {
            if (event.key === Qt.Key_Escape)
                pageBack(event);
        }

        function pageBack(event) {
            if( stackView.depth > 1 ) {
                stackView.pop()
                event.accepted = true
            }
        }

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 400
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 400
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 400
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 400
            }
        }
    }
}
