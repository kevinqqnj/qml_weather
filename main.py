# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys

from PySide6.QtGui import QGuiApplication
from PySide6.QtCore import QCoreApplication
from PySide6.QtQml import QQmlApplicationEngine


if __name__ == "__main__":
    os.environ["QML_XHR_ALLOW_FILE_READ"] = "1"
    QCoreApplication.setApplicationName("Wearable");
    QCoreApplication.setOrganizationName("QtProject");

    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(os.fspath(Path(__file__).resolve().parent / "main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
