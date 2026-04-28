#include "character.h"
#include <gb/gb.h>

/* Character uses sprite slots 1 and 2 (slot 0 is the cursor).
   We use two 8x8 sprites side by side to make a 16x16 character. */
#define CHAR_SPRITE_L  1   /* left half  */
#define CHAR_SPRITE_R  2   /* right half */

/* Tile slots for the character (after cursor tile at slot 0) */
#define CHAR_TILE_L    1
#define CHAR_TILE_R    2

/* Walking speed in pixels per frame */
#define CHAR_SPEED     1

uint16_t char_world_x = 80;   /* start near left of world */
uint8_t  char_world_y = 100;  /* fixed ground line for now */
uint16_t char_target_x = 80;
uint8_t  char_target_y = 100;
uint8_t  char_walking = 0;

/* 8x8 placeholder tile: solid filled square (color 3 = darkest) */
static const uint8_t char_tile[16] = {
    0xFF,0xFF,
    0xFF,0xFF,
    0xFF,0xFF,
    0xFF,0xFF,
    0xFF,0xFF,
    0xFF,0xFF,
    0xFF,0xFF,
    0xFF,0xFF
};

void character_init(void) {
    /* Load the same solid tile into both sprite tile slots */
    set_sprite_data(CHAR_TILE_L, 1, char_tile);
    set_sprite_data(CHAR_TILE_R, 1, char_tile);

    set_sprite_tile(CHAR_SPRITE_L, CHAR_TILE_L);
    set_sprite_tile(CHAR_SPRITE_R, CHAR_TILE_R);

    set_sprite_prop(CHAR_SPRITE_L, 0x00);
    set_sprite_prop(CHAR_SPRITE_R, 0x00);
}

void character_update(void) {
    if (!char_walking) return;

    /* Move horizontally toward target */
    if (char_world_x < char_target_x) {
        if (char_target_x - char_world_x <= CHAR_SPEED) {
            char_world_x = char_target_x;
        } else {
            char_world_x += CHAR_SPEED;
        }
    } else if (char_world_x > char_target_x) {
        if (char_world_x - char_target_x <= CHAR_SPEED) {
            char_world_x = char_target_x;
        } else {
            char_world_x -= CHAR_SPEED;
        }
    }

    /* Move vertically toward target */
    if (char_world_y < char_target_y) {
        char_world_y++;
    } else if (char_world_y > char_target_y) {
        char_world_y--;
    }

    /* Arrived? */
    if (char_world_x == char_target_x && char_world_y == char_target_y) {
        char_walking = 0;
    }
}

void character_draw(uint16_t cam_x) {
    int16_t sx;
    uint8_t hw_x_l, hw_x_r, hw_y;

    /* Convert world position to screen position */
    sx = (int16_t)char_world_x - (int16_t)cam_x;

    /* GB sprite hardware offset: add 8 for X, 16 for Y */
    hw_y   = char_world_y + 16;

    if (sx >= -8 && sx <= 160) {
        /* Left half of character */
        hw_x_l = (uint8_t)(sx + 8);
        hw_x_r = (uint8_t)(sx + 16);

        move_sprite(CHAR_SPRITE_L, hw_x_l, hw_y);
        move_sprite(CHAR_SPRITE_R, hw_x_r, hw_y);
    } else {
        /* Hide off screen */
        move_sprite(CHAR_SPRITE_L, 0, 0);
        move_sprite(CHAR_SPRITE_R, 0, 0);
    }
}

void character_walk_to(uint16_t wx, uint8_t wy) {
    char_target_x = wx;
    char_target_y = wy;
    char_walking  = 1;
}
