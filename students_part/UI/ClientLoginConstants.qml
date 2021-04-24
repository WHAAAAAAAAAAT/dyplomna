pragma Singleton
import QtQuick 2.15

QtObject {
    readonly property int width: 640
    readonly property int height: 480
    readonly property FontLoader mySystemFont: FontLoader { name: "Candara Light" }
    readonly property font font: Qt.font({
                                             family: mySystemFont.name,
                                             pointSize: Qt.application.font.pixelSize
                                         })
    readonly property font largeFont: Qt.font({
                                                  family: mySystemFont.name,
                                                  pointSize: Qt.application.font.pixelSize * 1.6
                                              })
    readonly property color backgroundColor: "#F9F9F9"
}

