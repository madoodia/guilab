import os
from guilab.miller import controller

path = os.path.abspath("../fixtures/root_withcquery")
controller.main("../dash/dash.qml", path)

