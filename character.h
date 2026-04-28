#ifndef CHARACTER_H
#define CHARACTER_H

#include <gb/gb.h>

/* Character position in WORLD pixels */
extern uint16_t char_world_x;
extern uint8_t  char_world_y;

/* Target position the character is walking toward */
extern uint16_t char_target_x;
extern uint8_t  char_target_y;

/* 1 if the character is currently walking, 0 if idle */
extern uint8_t char_walking;

/* Set up character sprites */
void character_init(void);

/* Call every frame — moves character toward target */
void character_update(void);

/* Draw character at correct screen position given camera */
void character_draw(uint16_t cam_x);

/* Tell the character to walk to a world position */
void character_walk_to(uint16_t wx, uint8_t wy);

#endif
