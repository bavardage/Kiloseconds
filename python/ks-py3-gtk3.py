#!/usr/bin/env python3


from gi.repository import Gtk, GObject
import time


def kstime():
    tl = time.localtime()
    to = (tl.tm_hour*3600 + tl.tm_min*60 + tl.tm_sec)/1000.0
    return to


class KsWindow(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Kiloseconds")

        self.label = Gtk.Label()
        self.add(self.label)

        self.timeout_id = GObject.timeout_add(50, self.on_timeout, None)

    def on_timeout(self, user_data):
        self.label.set_markup('<span size="xx-large">{0}</span>'.format(kstime()))
        return True # continue


win = KsWindow()
win.connect("delete-event", Gtk.main_quit)
win.show_all()
Gtk.main()
