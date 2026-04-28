#include "cursor.h"
#include <gb/gb.h>

/* Cursor position in WORLD pixels */
uint16_t cursor_world_x = 80;
uint8_t  cursor_world_y = 72;

#define CURSOR_SPEED  2
#define WORLD_W       512
#define SCREEN_H      144

/* Cursor sprite tile — small arrow */
static const uint8_t cursor_tiles[] = {
    0x00, 0x80,
    0x00, 0xC0,
    0x00, 0xE0,
    0x00, 0xF0,
    0x00, 0xF8,
    0x00, 0xC0,
    0x00, 0xA0,
    0x00, 0x00
};

void cursor_init(void) {
    set_sprite_data(0, 1, cursor_tiles);
    set_sprite_tile(0, 0);
    set_sprite_prop(0, 0x00);
    SPRITES_8x8;
    SHOW_SPRITES;
}

void cursor_update(void) {
    uint8_t keys = joypad();

    if (keys & J_RIGHT) {
        if (cursor_world_x < WORLD_W - 8) cursor_world_x += CURSOR_SPEED;
    }
    if (keys & J_LEFT) {
        if (cursor_world_x > 0) {
            if (cursor_world_x >= CURSOR_SPEED)
                cursor_world_x -= CURSOR_SPEED;
            else
                cursor_world_x = 0;
        }
    }
    if (keys & J_DOWN) {
        if (cursor_world_y < SCREEN_H - 8) cursor_world_y += CURSOR_SPEED;
    }
    if (keys & J_UP) {
        if (cursor_world_y > 0) {
            if (cursor_world_y >= CURSOR_SPEED)
                cursor_world_y -= CURSOR_SPEED;
            else
                cursor_world_y = 0;
        }
    }
}

/* Draw cursor sprite — needs camera_x to convert world→screen */
void cursor_draw(uint16_t cam_x) {
    int16_t sx = (int16_t)cursor_world_x - (int16_t)cam_x;
    uint8_t hw_x, hw_y;

    hw_y = cursor_world_y + 16;  /* GB sprite Y offset */

    if (sx >= -8 && sx <= 160) {
        hw_x = (uint8_t)(sx + 8);  /* GB sprite X offset */
        move_sprite(0, hw_x, hw_y);
    } else {
        move_sprite(0, 0, 0);  /* hide if off screen */
    }
}
