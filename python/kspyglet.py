#!/usr/bin/python

import pyglet
import time

window = pyglet.window.Window()

time_label = pyglet.text.Label(
    text = '', 
    font_name = 'Dejavu Sans',
    font_size = 36,
    x = window.width // 2,
    y = window.height // 2,
    anchor_x = 'center',
    anchor_y = 'center'
    )

def get_time():
    t = time.localtime()
    ti = (t.tm_hour*3600+t.tm_min*60+t.tm_sec)/1000.0
    return ti

def update_time(dt):
    window.clear()
    time_label.text = '%.3f' % get_time()
    time_label.draw()

@window.event
def on_key_press(symbol, modifiers):
    if symbol == pyglet.window.key.Q:
        pyglet.app.exit()

if __name__ == '__main__':
    update_time(get_time())
    pyglet.clock.schedule_interval(update_time, 0.5)
    pyglet.app.run()
