import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15
import QtCharts 2.15

import Models 1.0

Window {
    id: windowMenu
    width: 1280
    height: 720
    signal exitMenuWindow

    property string newUsername: UserInfoModel.username
    property string newName: UserInfoModel.name
    property string newSurname: UserInfoModel.surname
    property string newGroup: UserInfoModel.group

    Rectangle {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: 50
        color: '#F0F0F0'
        visible: true
        ClientRegistrationButton {
            id: menuButton
            anchors.verticalCenter: header.verticalCenter
            anchors.right: header.right
            anchors.rightMargin: 15
            width: header.width * 0.08
            fontSize: 20
            text: qsTr("Меню")
            font.bold: true

            Connections {
                target: menuButton
                function onClicked() {
                    windowMenu.hide()
                    menuWindow.show()
                }
            }
        }
    }
    Rectangle {
        id: profileRect
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        color: "#FEFCFE"
        Rectangle {
            id: userInfo
            color: "transparent"
            width: parent.width
            height: parent.height * 0.25
            anchors.top: parent.top
            anchors.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            Row {
                id: userInfoRow
                anchors.left: parent.left
                anchors.leftMargin: 15
                spacing: 25
                Image {
                    id: profilePicture
                    width: height
                    height: parent.height
                    source: "qrc:/" + qsTr(newName) + "_" + qsTr(newSurname) + "_profile.png"
                }
                Column {
                    id: userInfoColumn
                    spacing: 7
                    Text {
                        id: username
                        text: newUsername
                        color: "#0A0A0A"
                        font.pixelSize: 35
                        font.family: ClientLoginConstants.font.family
                    }
                    Text {
                        id: name
                        text: "Ім'я: " + newName
                        color: "#181818"
                        font.pixelSize: 20
                        font.family: ClientLoginConstants.font.family
                    }
                    Text {
                        id: surname
                        text: "Прізвище: " + newSurname
                        color: "#181818"
                        font.pixelSize: 20
                        font.family: ClientLoginConstants.font.family
                    }
                    Text {
                        id: group
                        text: "Група: " + newGroup
                        color: "#181818"
                        font.pixelSize: 20
                        font.family: ClientLoginConstants.font.family
                    }
                }
            }
        }

        Item {
            id: userStatistics
            anchors.top: userInfo.bottom
            height: parent.height * 0.75
            width: parent.width
            antialiasing: true
            Text {
                id: chartTitle
                text: qsTr("Результати тестів (%)")
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#181818"
                font.pixelSize: 25
                font.family: ClientLoginConstants.font.family
            }
            ChartView {
                id: chart
                //                title: "Результати тестів"
                titleFont: group.font
                antialiasing: true
                anchors.top: chartTitle.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                height: parent.height * 0.9
                width: parent.width * 0.8
                legend.visible: false
                BarSeries {
                    id: bar
                    axisX: BarCategoryAxis {
                        id: categoryAxis
                    }
                    axisY: ValueAxis {
                        id: yAxis
                        min: 0
                        max: 100
                    }
                }
                Component.onCompleted: {
                    ChartModel.updateBar(categoryAxis)
                    ChartModel.update(bar)
                }
            }
        }

        Rectangle {
            id: userRecommendations
            anchors.top: userStatistics.bottom
            anchors.bottom: parent.bottom
            width: parent.width
            color: "#FFFFFF"
        }
    }
}

