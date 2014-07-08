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

    def __init__(self, index=None, parent=None):
        super(List, self).__init__(parent)
        self.index = index
        self.model = None

        # Private members
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

    def populate(self, index=None):
        self._delegates = []
        index = index or self.index

        for model_item in self.model.children(index=index):
            index = model_item.index
            label = self.model.data(index, 'display')

            self._header = label
            bc = BaseDelegate()
            if self.model.data(index, 'group'):
                bc.name = label
                bc.index = index
                self._delegates.append(bc)

    def set_model(self, model):
        self.model = model
        model.model_reset.connect(self.model_reset_event)

    def model_reset_event(self):
        if not self.index:
            self.index = self.model.root_item.index
        self.populate()

    @pyqtSlot()
    def init(self):
        root = os.path.abspath("../fixtures/root_withcquery")
        model = dash.model.Model()
        self.set_model(model)

        model.setup(root)


if __name__ == '__main__':
    # listview = List()
    # model = dash.model.Model()
    # listview.set_model(model)
    # model.setup(os.path.abspath("../fixtures/root_withcquery"))

    path = os.path.expanduser("E:\Madoodia\_Abstract_Factory")
    List._path = path
    full_directory = os.path.dirname(os.path.abspath(__file__))
    app = QApplication(sys.argv)
    qmlRegisterType(List, 'List', 1, 0, 'List')
    engine = QQmlApplicationEngine()
    qml_file = os.path.join(full_directory, "miller.qml")
    engine.load(str(qml_file))

    window = engine.rootObjects()[0]
    window.show()
    sys.exit(app.exec_())
