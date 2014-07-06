import sys
import os

from PyQt5.QtCore import pyqtProperty, QObject, pyqtSlot
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import qmlRegisterType, QQmlListProperty, QQmlApplicationEngine

import pifou.com


class BaseContent(QObject):

    def __init__(self, parent=None):
        super(BaseContent, self).__init__(parent)
        self._content_path = ''
        self._content_name = ''
        self._depth = 0

    @pyqtProperty(str)
    def content_path(self):
        return self._content_path

    @content_path.setter
    def content_path(self, content_path):
        self._content_path = content_path

    @pyqtProperty(str)
    def content_name(self):
        return self._content_name

    @content_name.setter
    def content_name(self, content_name):
        self._content_name = content_name

    @pyqtProperty(str)
    def depth(self):
        return self._depth

    @depth.setter
    def depth(self, depth):
        self._depth = depth

    def __repr__(self):
        return self._content_name


class MillerLogic(QObject):

    _path = ''
    _contents_list = []

    def __init__(self, parent=None):
        super(MillerLogic, self).__init__(parent)
        self._contents = []
        self._header = ''

    @pyqtProperty(QQmlListProperty)
    def contents(self):
        return QQmlListProperty(BaseContent, self, self._contents)

    @pyqtProperty(str)
    def header(self):
        return self._header

    @header.setter
    def header(self, header):
        self._header = header

    @pyqtSlot(str, int)
    def fill_contents(self, path, depth):

        if depth == -1:
            path = self._path

        # print path , ' : ', depth+1
        self.update_list(depth)
        self.get_children(path, depth+1)
        self._contents_list.append(self._contents)

        # print self._contents_list

    def update_list(self, depth):
        self._contents_list[depth+1:] = []

    def get_children(self, path, depth):
        self._header = os.path.basename(path)
        self._contents = []

        for path in pifou.com.Iterator(path):
            bc = BaseContent()
            basename = os.path.basename(path)
            if os.path.isdir(path):
                bc.content_name = basename
                bc.content_path = path
                bc.depth = str(depth)
                self._contents.append(bc)


if __name__ == '__main__':
    path = os.path.abspath("../fixtures/root_withcquery")
    MillerLogic._path = path
    full_directory = os.path.dirname(os.path.abspath(__file__))
    app = QApplication(sys.argv)
    qmlRegisterType(MillerLogic, 'MillerLogic', 1, 0, 'Miller')
    engine = QQmlApplicationEngine()
    qml_file = os.path.join(full_directory, "dash.qml")
    engine.load(str(qml_file))

    window = engine.rootObjects()[0]
    window.show()
    sys.exit(app.exec_())
