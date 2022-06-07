# This Python file uses the following encoding: utf-8
import os, sys, time
from pathlib import Path
import json
import threading
import urllib.request

from PySide6.QtGui import QGuiApplication
from PySide6.QtCore import QCoreApplication
from PySide6.QtQml import QQmlApplicationEngine

class MyThread(threading.Thread):
    def __init__(self, func, args=()):
        super(MyThread, self).__init__()
        self.func = func
        self.args = args
    def run(self):
        self.result = self.func(*self.args)
    def get_result(self):
        threading.Thread.join(self)  # 等待线程执行完毕
        try:
            return self.result
        except Exception:
            return None

def update_weather(cityId):
    print('python: updating...', cityId)
    task = threading.Thread(target=getData, args=(cityId,))
    task.start()
#    return task.get_result()

def getData(cityId):
    global root, weatherdata
    try:
        url = f"http://t.weather.sojson.com/api/weather/city/{cityId}"
        print('start downloading... ', url)
        response = urllib.request.urlopen(url)
        data = json.loads(response.read().decode('utf-8'))
        weatherdata[str(cityId)] = data['data']['forecast'][0]
        weatherdata[str(cityId)]['cityInfo'] = data['cityInfo']
        weatherdata[str(cityId)]['UdateTime'] = data['time']

#       {'date': '07', 'high': '高温 29℃', 'low': '低温 17℃', 'ymd': '2022-06-07', 'week': '星期二',
#        'sunrise': '04:58', 'sunset': '19:09', 'aqi': 18, 'fx': '东北风', 'fl': '2级', 'type': '多云',
#        'notice': '阴晴之间，谨防紫外线侵扰', 'UdateTime': '2022-06-07 19:12:55'}
         # must have some delay, either urlopen or time.sleep, otherwize QML cannot update property
        time.sleep(1)
        print('downloaded, data len:', len(str(data)), weatherdata)
        root.setProperty('weatherData',  weatherdata)

    except Exception as e:
        print(e)

    root.setProperty('isUpdating', False)


if __name__ == "__main__":
    os.environ["QML_XHR_ALLOW_FILE_READ"] = "1"
    QCoreApplication.setApplicationName("Wearable");
    QCoreApplication.setOrganizationName("QtProject");

    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(os.fspath(Path(__file__).resolve().parent / "main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    weatherdata = {}
    root = engine.rootObjects()[0]
    root.updateWeather.connect(update_weather)
    sys.exit(app.exec())
