import pygame
from pygame.math import Vector2
import models
import utils

def handle_input():
    for event in pygame.event.get():
        if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_ESCAPE):
            quit()

pygame.init()
screen = pygame.display.set_mode((400,400))
utils.show_path()
background = utils.load_sprite("space", False)
pygame.display.set_caption("Random Stuff")

test_object = models.GameObject(Vector2(30,30),utils.load_sprite("asteroid"))
screen.blit(background, (0, 0))
test_object.draw(screen)
bullet = models.GameObject(Vector2(120, 120), utils.load_sprite("bullet"))
bullet.draw(screen)
surface_object = pygame.Surface((30,30))
surface_object.fill((255,0,0))
surface_test = models.GameObject(Vector2(200, 60), surface_object)
surface_test.draw(screen)
surface_object.fill((0,255,0))
zero_test = models.GameObject((10, 10), utils.load_sprite("spaceship"))
zero_test.draw(screen)

pygame.display.flip()

print(test_object)

while True:
    handle_input()