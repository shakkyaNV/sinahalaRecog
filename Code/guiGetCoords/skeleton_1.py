# import os
# import datetime as dtime
# from pynput import keyboard
from pynput.keyboard import Key,Listener as klistner
from pynput.mouse import Listener as mlistener
# import sqlite3
# import pyautogui
# from time import sleep
from time import monotonic_ns
# import sys
from threading import Event


# from time import monotonic_ns() -> time incremetally in nanosecs (write this instead of dtime.datetime.now())
# class charRecog:

# 	def __init__(self):
# 		print("In class charRecog now")

# scr_w, scr_h = pyautogui.size() #Get screen size
# print('scr_w, scr_h:', scr_w, scr_h)


def keyOnPress(key):
	""""
	Starting and stopping Mouse Listener
	based on keybaord input
	"""
	if key == Key.left:
		# Stopping Listner
		try: 
			print("Stopping mouse Listener")
			mouseListen.stop()
			# get user input where correctly written
			return False
		except Exception as e:
			print("Error in Stopping Mouse Listener" + str(e))
	elif key == Key.right:
		# starting Listner
		try:
			# get user input on what's going to write
			print("Starting Listner")
			mouseListen.start()
		except Exception as e:
			print("Error in starting Mouse Listener" + str(e))

def mouseOnMove(x, y):
	"""
	Recording mouse movements
	"""
	# time = dtime.datetime.now()
	with open('initial_test.csv', 'a') as file:
		file.write(f" {x},{y},{monotonic_ns()}\n")
		# sleep(0.03)
		Event().wait(0.03)

def mouseOnClick(x, y, button, pressed):
	print(f"{'Pressed' if pressed else 'Released'} at {x}, {y}")
	if pressed:
		print("Pressed Insert Action here")
		# insert mouse press actions here
	else:
		print("Released Insert Action here")
		# insert mouse release actions here


keyListen = klistner(
	on_press = keyOnPress)
 

mouseListen = mlistener(
	# on_click = mouseOnClick,
	on_move = mouseOnMove) 

def main():
	# print(sys.executable)
	char = str(input("Input Character: "))
	person = str(input("Input Person ID: "))
	id = int(input("Input unique ID: "))
	with open('initial_test.csv', 'a') as file:
		file.write(f"\n{char},{person},{id}\n")
	keyListen.start() 

	# mouseListen.start()
	keyListen.join()
	#  mouseListen.join() 


if __name__ == "__main__":
	main()
 
 
 

