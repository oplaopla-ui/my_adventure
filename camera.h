#ifndef CAMERA_H
#define CAMERA_H

#include <gb/gb.h>

/* World is 512px wide (32 tiles * 8px), screen is 160px wide.
   camera_x is the left edge of the visible screen in world pixels. */
extern uint16_t camera_x;

/* Call every frame after the character moves */
void camera_update(uint16_t char_world_x);

/* Convert a world X coordinate to a screen X coordinate */
int16_t camera_world_to_screen_x(uint16_t world_x);

#endif
