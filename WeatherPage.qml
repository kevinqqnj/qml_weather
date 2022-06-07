import QtQuick
import QtQuick.Controls

Item {

    SwipeView {
        id: sv
        anchors.fill: parent
        property string cityId: settings.cityId.toString()
        property var data: root.weatherData[sv.cityId] || settings.savedWeatherData[sv.cityId]

        SwipeViewPage {
            id: weatherPage1

            Row {
                anchors.centerIn: parent
                spacing: 2

                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    source: "images/temperature"
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 40
                    Text {
                        text: sv.data && sv.data.type? String(sv.data.type) : "N/A"
                        font.pixelSize: 25
                        font.letterSpacing: 1
                        color: "#09102b"
                    }
                    Text {
                        text: sv.data && sv.data.high? String(sv.data.high) : "N/A"
                        font.pixelSize: 25
                        font.letterSpacing: 1
                        color: "#09102b"
                    }
                    Text {
                        text: sv.data && sv.data.low? String(sv.data.low) : "N/A"
                        font.pixelSize: 25
                        font.letterSpacing: 1
                        color: "#09102b"
                    }
                    Text {
                        text: sv.data && sv.data.notice? String(sv.data.notice) : "N/A"
                        font.pixelSize: 25
                        font.letterSpacing: 1
                        color: "#26a051"
                    }
                }
            }
            Text {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50
                anchors.rightMargin: 10
                anchors.right: parent.right
                text: sv.data && sv.data.UdateTime? "更新于："+String(sv.data.UdateTime) : "N/A"
                font.pixelSize: 10
                font.letterSpacing: 1
                font.italic: true
                color: "#a2a2a2"
            }
        }

        SwipeViewPage {
            id: weatherPage2

            Column {
                spacing: 40
                anchors.centerIn: parent

                Row {
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: wImg
                        anchors.verticalCenter: parent.verticalCenter
                        source: "images/wind"
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: sv.data && sv.data.fx? String(sv.data.fx) : "N/A"
                        font.pixelSize: 25
                        font.letterSpacing: 1
                        color: "#09102b"
                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: sv.data && sv.data.fl? String(sv.data.fl) : "N/A"
                        font.pixelSize: 25
                        font.letterSpacing: 1
                        color: "#09102b"
                    }
                }

            }
        }

        SwipeViewPage {
            id: weatherPage3

            Column {
                spacing: 40
                anchors.centerIn: parent

                Row {
                    spacing: 30
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        source: "images/sunrise"
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: sv.data && sv.data.sunrise? String(sv.data.sunrise) : "N/A"
                        font.pixelSize: 25
                        font.letterSpacing: 1
                        color: "#09102b"
                    }
                }

                Row {
                    spacing: 30
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        source: "images/sunset"
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: sv.data && sv.data.sunset? String(sv.data.sunset) : "N/A"
                        font.pixelSize: 25
                        font.letterSpacing: 1
                        color: "#09102b"
                    }
                }
            }
        }

    }

    PageIndicator {
        id: pgIndicator
            count: sv.count
            currentIndex: sv.currentIndex
            scale: 2
            anchors.bottom: sv.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

    BusyIndicator {
        id: busyIndicator
        anchors.right: parent.right
        anchors.verticalCenter: pgIndicator.verticalCenter
        visible: root.isUpdating
    }

    Component.onCompleted: {
        console.log(`Weather page, cityId:${settings.cityId}, root:${JSON.stringify(root.weatherData)}`)
        settings.savedWeatherData = root.weatherData
    }
}

