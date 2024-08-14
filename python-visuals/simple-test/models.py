import pygame

from pygame.math import Vector2
from utils import load_sprite

class GameObject:
    def __init__(self, position, sprite) -> None:
        self.position = Vector2(position)
        # this var may have to be renamed
        # it can be a regular sprite (load_sprite()) or surface object
        # is there a word that works well with these two types of objects
        self.position = position
        self.sprite = sprite
        self.radius = sprite.get_width() / 2
    def draw(self, surface):
        surface.blit(self.sprite, self.position)

class Bullet(GameObject):
    # going up
    speed = Vector2(0, 5)
    def __init__(self, direction) -> None:
        super().__init__((0,0), load_sprite("bullet"))
        self.direction = Vector2(direction)
        self.velocity = self.speed.rotate(direction)
    def move(self):
        self.position = self.position + self.velocity

