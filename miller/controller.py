import sys
import os

from PyQt5 import QtCore
from PyQt5 import QtWidgets
from PyQt5 import QtQml

import dash.model


class Delegate(QtCore.QObject):
    def __init__(self, parent=None):
        super(Delegate, self).__init__(parent)
        self._index = ''
        self._name = ''
        # self._depth = 0

    @QtCore.pyqtProperty(str)
    def index(self):
        return self._index

    @index.setter
    def index(self, index):
        self._index = index

    @QtCore.pyqtProperty(str)
    def name(self):
        return self._name

    @name.setter
    def name(self, name):
        self._name = name

    # @QtCore.pyqtProperty(str)
    # def depth(self):
    #     return self._depth

    # @depth.setter
    # def depth(self, depth):
    #     self._depth = depth

    def __repr__(self):
        return self._name


class List(QtCore.QObject):
    _root = ''

    def __init__(self, index=None, parent=None):
        super(List, self).__init__(parent)
        self.index = index
        self.model = None

        # Private members
        self._delegates = []
        self._header = ''
        self._indexes = dict()

    @QtCore.pyqtProperty(QtQml.QQmlListProperty)
    def delegates(self):
        return QtQml.QQmlListProperty(Delegate, self, self._delegates)

    @QtCore.pyqtProperty(str)
    def header(self):
        return self._header

    @header.setter
    def header(self, header):
        self._header = header

    def populate(self, index=None):
        # self._delegates = []
        index = index or self.index

        for model_item in self.model.children(index=index):
            index = model_item.index
            label = self.model.data(index, 'display')

            _delegate = Delegate()
            # self._header = label
            if self.model.data(index, 'group'):
                _delegate.name = label
                _delegate.index = index
                self._delegates.append(_delegate)
                self._indexes[index] = _delegate

    def set_model(self, model):
        self.model = model
        model.model_reset.connect(self.model_reset_event)

    def model_reset_event(self):
        if not self.index:
            self.index = self.model.root_item.index
        self.populate()

    @QtCore.pyqtSlot()
    def init(self):
        # root = os.path.abspath("E:\Madoodia\_Abstract_Factory")
        model = dash.model.Model()
        basename = os.path.basename(List._root)
        self._header = basename

        model.setup(List._root)
        self.set_model(model)

        index = model.root_item.index
        self.populate(index)

    def __repr__(self):
        return self._header


class Miller(QtCore.QObject):

    def __init__(self, index=None, parent=None):
        super(Miller, self).__init__(parent)
        self.index = index
        # self.light = 0
        self.model = None

        # Private members
        self._lists = []
        self._indexes = dict()

    @QtCore.pyqtProperty(QtQml.QQmlListProperty)
    def lists(self):
        return QtQml.QQmlListProperty(List, self, self._lists)

    def add_list(self, index=None):
        # self._lists = []
        index = index or self.index
        label = self.model.data(index, 'display')

        _list = List(index)
        _list.set_model(self.model)
        _list.populate()
        _list._header = label
        # if .meta is in folder:
        #     self.light = 1
        self._lists.append(_list)
        self._indexes[index] = _list

        # print self._indexes
        # print self._lists
        # print _list._delegates

    def set_model(self, model):
        self.model = model
        model.model_reset.connect(self.model_reset_event)

    def model_reset_event(self):
        if not self.index:
            self.index = self.model.root_item.index
        self.add_list()

    @QtCore.pyqtSlot()
    def init(self):
        # root = os.path.abspath("E:\Madoodia\_Abstract_Factory")
        model = dash.model.Model()
        # basename = os.path.basename(List._root)
        # self._header = basename

        model.setup(List._root)
        self.set_model(model)

        index = model.root_item.index
        self.add_list(index)

    @QtCore.pyqtSlot(str)
    def send_index(self, index):
        for i1, list_ in self._indexes.items():
            for i2, delegate_ in list_._indexes.items():
                if i2 == index:
                    list_depth = self._lists.index(list_)
                    self._lists[list_depth+1:] = []
                    self.add_list(index)
                    return


def main(qml_file="millerLauncher.qml", path=""):
    List._root = os.path.abspath(path)
    # Show QML Window
    full_directory = os.path.dirname(os.path.abspath(__file__))
    app = QtWidgets.QApplication(sys.argv)
    QtQml.qmlRegisterType(List, 'List', 1, 0, 'List')
    QtQml.qmlRegisterType(Miller, 'Miller', 1, 0, 'Miller')
    engine = QtQml.QQmlApplicationEngine()
    qml_file = os.path.join(full_directory, qml_file)
    engine.load(str(qml_file))

    window = engine.rootObjects()[0]
    window.show()
    sys.exit(app.exec_())

if __name__ == '__main__':
    main(path='../fixtures/root_withcquery')
