import pygame

from pygame.math import Vector2

class GameObject:
    def __init__(self, position, sprite) -> None:
        self.position = Vector2(position)
        self.sprite = sprite
        self.radius = sprite.get_width() / 2
    def draw(self, surface):
        surface.blit(self.sprite, (200, 200))
