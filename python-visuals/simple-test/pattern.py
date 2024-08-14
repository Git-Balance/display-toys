import pygame
from pygame.math import Vector2
from models import Bullet
from utils import load_sprite

WIDTH = 400
HEIGHT = 400

pygame.init()
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Pattern")
