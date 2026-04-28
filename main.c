#include <gb/gb.h>
#include "cursor.h"
#include "character.h"
#include "camera.h"
#include "hotspot.h"
#include "scene.h"

#define HS_DOOR  1
#define HS_CHEST 2

/* Walk destination marker for a hotspot — where the character stops */
#define DOOR_WALK_X   24u   /* world pixel X to stand at for door  */
#define CHEST_WALK_X  360u  /* world pixel X to stand at for chest */
#define WALK_Y        100u  /* ground line Y                        */

void main(void) {
    uint8_t prev_keys = 0;
    uint8_t keys      = 0;
    uint8_t hit       = 0;

    DISPLAY_ON;
    BGP_REG  = 0xE4;   /* background palette: 00=white 01=lgrey 10=dgrey 11=black */
    OBP0_REG = 0xE4;   /* sprite palette */

    /* Build the scene background */
    scene_init();

    /* Door: world tile (1,1) = world pixel (8,8), 4 tiles wide x 5 tall */
    scene_draw_box(1, 1, 4, 5);
    hotspot_add(8, 8, 32, 40, HS_DOOR);

    /* Chest: world tile (44,11) — well to the right in the scrollable world */
    scene_draw_box(44, 11, 5, 4);
    hotspot_add(352, 88, 40, 32, HS_CHEST);

    /* Init character and cursor */
    character_init();
    cursor_init();

    while(1) {
        prev_keys = keys;
        keys = joypad();

        /* ── Input ─────────────────────────────────────────────────── */
        cursor_update();

        /* A pressed: walk character to cursor world position */
        if ((keys & J_A) && !(prev_keys & J_A)) {
            hit = hotspot_check(cursor_world_x, cursor_world_y);

            if (hit == HS_DOOR) {
                /* Walk to the door's stand position */
                character_walk_to(DOOR_WALK_X, WALK_Y);
            } else if (hit == HS_CHEST) {
                /* Walk to the chest's stand position */
                character_walk_to(CHEST_WALK_X, WALK_Y);
            } else {
                /* Walk directly to wherever the cursor is */
                character_walk_to(cursor_world_x, cursor_world_y);
            }
        }

        /* ── Update ────────────────────────────────────────────────── */
        character_update();
        camera_update(char_world_x);

        /* ── Draw ──────────────────────────────────────────────────── */
        character_draw(camera_x);
        cursor_draw(camera_x);

        wait_vbl_done();
    }
}
