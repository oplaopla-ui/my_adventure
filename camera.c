#include "camera.h"
#include <gb/gb.h>

/* World width in pixels */
#define WORLD_W  512
/* Screen width in pixels */
#define SCREEN_W 160

uint16_t camera_x = 0;

void camera_update(uint16_t char_world_x) {
    /* Try to centre the camera on the character */
    int16_t target;

    if (char_world_x < SCREEN_W / 2) {
        target = 0;
    } else if (char_world_x > WORLD_W - SCREEN_W / 2) {
        target = WORLD_W - SCREEN_W;
    } else {
        target = (int16_t)char_world_x - SCREEN_W / 2;
    }

    if (target < 0) target = 0;
    camera_x = (uint16_t)target;

    /* Tell the GB hardware to scroll the background */
    SCX_REG = (uint8_t)(camera_x & 0xFF);
}

int16_t camera_world_to_screen_x(uint16_t world_x) {
    return (int16_t)world_x - (int16_t)camera_x;
}
