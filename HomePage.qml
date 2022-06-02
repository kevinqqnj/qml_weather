import QtQuick
import QtQuick.Controls


PathView {
    id: circularView

    signal launched(int cityId)

    readonly property int cX: width / 2
    readonly property int cY: height / 2
    readonly property int itemSize: size / 3
    readonly property int size: Math.min(width-80, height)
    readonly property int radius: size / 2.4 //画Path圆的半径，越大图标离得越远

    snapMode: PathView.SnapToItem
    anchors.fill: parent
    model: ListModel {
        ListElement {
            name: qsTr("南京")
            icon: "images/nanjing.png"
            cityId: 1
        }
        ListElement {
            name: "西安"
            icon: "images/xi'an.png"
            cityId: 2
        }
        ListElement {
            name: "天津"
            icon: "images/tianjin.png"
            cityId: 3
        }
        ListElement {
            name: "武汉"
            icon: "images/wuhan.png"
            cityId: 4
        }
        ListElement {
            name: "成都"
            icon: "images/chengdu.png"
            cityId: 5
        }
        ListElement {
            name: "北京"
            icon: "images/beijing.png"
            cityId: 6
        }
        ListElement {
            name: "香港"
            icon: "images/hongkong.png"
            cityId: 7
        }
    }
    delegate: RoundButton {
        width: itemSize
        height: itemSize

        property string name: model.name //必须要设置prop，不然其它Component不能访问currentItem.xxx
        property string cityId: model.cityId

        icon.width: width*.7
        icon.height: width*.7
        icon.source: model.icon
        opacity: PathView.itemOpacity

        background: Rectangle {
            radius: width / 2
            border.width: 3
            border.color: parent.PathView.isCurrentItem ? "#41cd52" : "#aaaaaa"
        }

        onClicked: {
            console.log(`currIndex=${circularView.currentIndex}, index=${index}, id: ${name}`)
            if (PathView.isCurrentItem){
                settings.cityId = cityId
                circularView.launched(cityId) }
            else
                circularView.currentIndex = index
        }
    }


    path: Path {
        startX: cX; startY: cY
        PathAttribute {name: "itemOpacity"; value: 1.0}
        PathLine { x: cX/5; y: cY}
//        PathQuad { x: cX*.56; y: cY*.8; controlX: cX/2; controlY: cY/2 }
        PathAttribute {name: "itemOpacity"; value: .2}
        PathArc {
            x: cX*1.8
            y: cY
            radiusX: cX/1.2
            radiusY: circularView.radius/1.5
            useLargeArc: true
            direction: PathArc.Clockwise
        }
//        PathQuad { x: cX*1.66; y: cY/4; controlX: cX*1.1; controlY: cX*2 }
        PathAttribute {name: "itemOpacity"; value: .2}
        PathLine { x: cX; y: cY }
        PathAttribute {name: "itemOpacity"; value: .1}
      }


    Text {
        id: nameText
        property Item currentItem: circularView.currentItem

        visible: currentItem ? currentItem.PathView.itemOpacity === 1.0 : 0

        text: currentItem ? currentItem.name : ""
        anchors.centerIn: parent
        anchors.verticalCenterOffset: itemSize

        font.bold: true
        font.pixelSize: itemSize / 3
        font.letterSpacing: 3
        color: "#39102b"
    }
    onDragStarted: {
        console.log(`Dragging: currIndex=${circularView.currentIndex}, ${currentItem.name}`)
    }

}
