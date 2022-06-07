import QtQuick
import QtQuick.Controls
import Qt.labs.settings


ApplicationWindow {
    id: root
    visible: true
    width: 450
    height: 800
    title: qsTr("小天气 App")

    property string page
    property var weatherData: ({})
    property bool isUpdating: false
    signal updateWeather(int cityId)

    Settings {
        id: settings
        property int cityId
        property var savedWeatherData: ({})
    }

    property alias settings: settings // 全局变量

    background: Image {
        source: "images/background-light.png"
    }

    header: NaviButton {
        id: homeButton

        edge: Qt.TopEdge
        enabled: stackView.depth > 1
        imageSource: "images/home.png"

        onClicked: stackView.pop(null)
    }

    footer: NaviButton {
        id: backButton

        edge: Qt.BottomEdge
        enabled: stackView.depth > 1
        imageSource: "images/back.png"

        onClicked: stackView.pop()
    }

    StackView {
        id: stackView

        focus: true
        anchors.fill: parent


        initialItem: HomePage {
            // Qt6必须以function方式响应signal
            onLaunched: (cityId) => {
                        updateWeather(cityId)
                        console.log('waiting for py update...', JSON.stringify(settings.savedWeatherData))
                        root.isUpdating = true
                        stackView.push("WeatherPage.qml")
                        }
        }
    }

}
