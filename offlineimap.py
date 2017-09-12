#!/usr/bin/python3

from __future__ import print_function

try:
    from Tkinter import *
except:
    from tkinter import *

def get_password():
    root = Tk()
    pwdbox = Entry(root, show = '*')
    def onpwdentry(evt):
        get_password.password = pwdbox.get()
        root.destroy()
    def onokclick():
        get_password.password = pwdbox.get()
        root.destroy()
    Label(root, text = 'Password').pack(side = 'top')

    pwdbox.pack(side = 'top')
    pwdbox.bind('<Return>', onpwdentry)
    Button(root, command=onokclick, text = 'OK').pack(side = 'top')
    pwdbox.focus_set()

    root.mainloop()
    return get_password.password

if __name__ == '__main__':
    print(get_password())
