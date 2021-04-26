import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import "qrc:/UI"

Rectangle {
    id: courseListRect
    anchors.fill: parent
    Item {
        id: courseListItem
        anchors.fill: parent

        ListModel {
            id: courseListModel
            ListElement {
                name: qsTr("PRRRR DDDD")
                type: qsTr("Cats")
                aVisible: false
            }
            ListElement {
                name: qsTr("dsadadad")
                type: qsTr("Cats")
                aVisible: false
            }
            ListElement {
                name: qsTr("Puss in Boots")
                type: qsTr("Dogs")
                aVisible: false
            }
            ListElement {
                name: qsTr("BBBBB")
                type: qsTr("Dogs")
                aVisible: false
            }
            ListElement {
                name: qsTr("ФІ")
                type: qsTr("Ї")
                aVisible: false
            }
            ListElement {
                name: qsTr("BBBBB")
                type: qsTr("Ї")
                aVisible: false
            }
        }

        Component {
            id: sectionHeader
            Rectangle {
                id: sectionHeaderRect
                width: courseListRect.width * 0.9
                color: "transparent"
                height: courseListRect.height * 0.08
                property bool isExpanded: false
                property string currentExpandedSection: ListView.view.expandedSection
                onCurrentExpandedSectionChanged: {
                    if(currentExpandedSection === section)
                        isExpanded = true;
                    else
                        isExpanded = false;
                }
                onIsExpandedChanged: {
                    if(isExpanded){
                        sectionHeaderText.color = "#4D0973";
                        ListView.view.expandedSection = section;
                    }
                    else
                        sectionHeaderText.color = "#FFFFFF";
                    for(var i=0; i<courseListModel.count; i++) {
                        var course = courseListModel.get(i);
                        if(section === course.type)
                            course.aVisible = sectionHeaderRect.isExpanded;
                    }
                }
                Text {
                    id: sectionHeaderText
                    text: qsTr("⬤  " + section)
                    anchors.left: parent.left
                    anchors.leftMargin: courseListRect.width * 0.05
                    font.pixelSize: parent.width * 0.11
                    font.bold: true
                    color: "#FFFFFF"
                    font.family: LoginConstants.font.family
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: {
                        sectionHeaderRect.isExpanded = !sectionHeaderRect.isExpanded;
                    }
                }
            }
        }

        ListView {
            id: listing
            width: courseListRect.width * 0.9
            height: courseListRect.height
            model: courseListModel
            property string expandedSection: ""
            delegate: listdelegate
            section.property: "type"
            section.criteria: ViewSection.FullString
            section.delegate: sectionHeader
            interactive: false
        }

        Component {
            id: listdelegate
            Rectangle {
                property bool listCurrentItem: ListView.isCurrentItem
                id: menuItem
                width: courseListRect.width * 0.85
                height: 0
                color: "transparent"
                anchors.left: parent.left
                anchors.leftMargin: courseListRect.width * 0.15
                visible: aVisible
                onVisibleChanged: {
                    if(visible) {
                        height = courseListRect.height * 0.08;
                    }
                    else {
                        height = 0;
                    }
                }
                Behavior on height {
                    NumberAnimation {
                        duration: 500
                    }
                }
                Text {
                    id: text
                    text: qsTr("◯  " + name)
                    color: listCurrentItem ? "#4D0973" : "#FFFFFF";
                    anchors.left: parent.left
                    font.pixelSize: parent.width * 0.1
                    font.bold: true
                    font.family: LoginConstants.font.family
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: {
                        listing.currentIndex = index;
                    }
                }
            }
        }
    }
}
