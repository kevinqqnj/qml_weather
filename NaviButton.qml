import QtQuick
import QtQuick.Controls


AbstractButton {
    id: button

    property int edge: Qt.TopEdge
    property alias imageSource: image.source

    contentItem: Image {
        id: image
        fillMode: Image.Pad
        sourceSize { width: 40; height: 40 } // ### TODO: resize the image
    }

    background: Rectangle {
        height: button.height * 4
        width: height
        radius: width / 2

        anchors.horizontalCenter: button.horizontalCenter
        anchors.top: edge === Qt.BottomEdge ? button.top : undefined
        anchors.bottom: edge === Qt.TopEdge ? button.bottom : undefined

//        color: settings.darkTheme ? UIStyle.colorQtGray3 : UIStyle.colorQtGray9
    }

    transform: Translate {
        Behavior on y { NumberAnimation { } }
        y: enabled ? 0 : edge === Qt.TopEdge ? -button.height : button.height
    }
}
