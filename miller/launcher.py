import sys
import os

from PyQt5.QtCore import pyqtProperty, QObject, pyqtSlot
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import qmlRegisterType, QQmlListProperty, QQmlApplicationEngine

import pifou.com


import dash.model

class BaseDelegate(QObject):

    def __init__(self, parent=None):
        super(BaseDelegate, self).__init__(parent)
        self._index = ''
        self._name = ''
        # self._depth = 0

    @pyqtProperty(str)
    def index(self):
        return self._index

    @index.setter
    def index(self, index):
        self._index = index

    @pyqtProperty(str)
    def name(self):
        return self._name

    @name.setter
    def name(self, name):
        self._name = name

    # @pyqtProperty(str)
    # def depth(self):
    #     return self._depth

    # @depth.setter
    # def depth(self, depth):
    #     self._depth = depth

    def __repr__(self):
        return self._delegate_name


class List(QObject):

    _path = ''
    _delegates_list = []

    def __init__(self, parent=None):
        super(List, self).__init__(parent)
        self._delegates = []
        self._header = ''

    @pyqtProperty(QQmlListProperty)
    def delegates(self):
        return QQmlListProperty(BaseDelegate, self, self._delegates)

    @pyqtProperty(str)
    def header(self):
        return self._header

    @header.setter
    def header(self, header):
        self._header = header

    @pyqtSlot(str, int)
    def fill_delegates(self, path, depth):

        if depth == -1:
            path = self._path

        # print path , ' : ', depth+1
        self.update_list(depth)
        self.get_children(path, depth+1)
        self._delegates_list.append(self._delegates)

        # print self._delegates_list

    # def update_list(self, depth):
    #     self._delegates_list[depth+1:] = []

    def populate(self, index=None):
        self._delegates = []
        self.model = dash.model.Model()
        self.model.setup(r'E:\Madoodia\_GitHub\guilab\fixtures\root_withcquery')

        index = self.model.root_item.index

        for model_item in self.model.children(index=index):
            index = model_item.index
            label = self.model.data(index, 'display')

            self._header = label
            bc = BaseDelegate()
            if model.data(index, 'group'):
                bc.name = label
                bc.index = index
                self._delegates.append(bc)


if __name__ == '__main__':
    path = os.path.expanduser("E:\Madoodia\_Abstract_Factory")
    List._path = path
    full_directory = os.path.dirname(os.path.abspath(__file__))
    app = QApplication(sys.argv)
    qmlRegisterType(List, 'List', 1, 0, 'Miller')
    engine = QQmlApplicationEngine()
    qml_file = os.path.join(full_directory, "miller.qml")
    engine.load(str(qml_file))

    window = engine.rootObjects()[0]
    window.show()
    sys.exit(app.exec_())
