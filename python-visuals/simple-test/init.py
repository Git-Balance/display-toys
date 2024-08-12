import pygame
from pygame.math import Vector2
import models
import utils

pygame.init()
screen = pygame.display.set_mode((400,400))
background = utils.load_sprite("space", False)
pygame.display.set_caption("Random Stuff")

test_object = models.GameObject(Vector2(30,30),utils.load_sprite("asteroid"))
screen.blit(background, (0, 0))
test_object.draw(screen)
bullet = models.GameObject(Vector2(120, 120), utils.load_sprite("bullet"))
bullet.draw(screen)



pygame.display.flip()

print(test_object)

input("Press enter to close")