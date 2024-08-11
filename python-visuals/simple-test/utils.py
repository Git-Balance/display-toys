#!/usr/bin/python3

from cmath import rect
import random

from pygame import Color
from pygame.image import load
from pygame.math import Vector2
from pygame.mixer import Sound

import os

cwd = os.getcwd()

def wrap_position(position, surface):
    x, y = position
    w, h = surface.get_size()
    return Vector2(x % w, y % h)

def get_random_position(surface):
    return Vector2(
        random.randrange(surface.get_width()),
        random.randrange(surface.get_height()),
    )

def get_random_velocity(min_speed, max_speed):
    speed = random.randint(min_speed,max_speed)
    angle = random.randint(0, 360)
    return Vector2(speed, 0).rotate(angle)

def print_text(surface, text, font, color=Color("tomato")):
    text_surface = font.render(text, True, color)

    rect = text_surface.get_rect()
    rect.center = Vector2(surface.get_size()) / 2

    surface.blit(text_surface, rect)

def load_sprite(name, with_alpha=True):
    path = ""
    input = "class"
    if input == "class":
        #path = f"/home/balance/Documents/Scripts/Tests/Python Tests/astroids/game_project/assets/sprites/{name}.png"
        path = os.path.join(cwd, "assets", "sprites", name + ".png")
    elif input == "home":
        path = f"/home/balance/Documents/Scripts/PyGame/astroids/game_project/assets/sprites/{name}.png"
    loaded_sprite = load(path)

    if with_alpha:
        return loaded_sprite.convert_alpha()
    else:
        return loaded_sprite.convert()

def load_sound(name):
    path = ""
    input = "class"
    if input == "class":
        #path = f"/home/balance/Documents/Scripts/Tests/Python Tests/astroids/game_project/assets/sounds/{name}.wav"
        path = os.path.join(cwd, "assets", "sounds", name + ".wav")
    elif input == "home":
        path = f"/home/balance/Documents/Scripts/PyGame/astroids/game_project/assets/sounds/{name}.wav"
    
    return Sound(path)

def show_path():
    return os.getcwd()
