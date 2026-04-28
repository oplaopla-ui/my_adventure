#ifndef CURSOR_H
#define CURSOR_H

#include <gb/gb.h>

/* Cursor position in WORLD pixels */
extern uint16_t cursor_world_x;
extern uint8_t  cursor_world_y;

void cursor_init(void);
void cursor_update(void);
void cursor_draw(uint16_t cam_x);  /* needs camera_x to place sprite */

#endif
