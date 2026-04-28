#ifndef HOTSPOT_H
#define HOTSPOT_H

#include <gb/gb.h>

#define MAX_HOTSPOTS 8

typedef struct {
    uint16_t x;      /* world pixel X */
    uint8_t  y;      /* world pixel Y */
    uint16_t w;      /* width in pixels */
    uint8_t  h;      /* height in pixels */
    uint8_t  active;
    uint8_t  id;
} Hotspot;

extern Hotspot hotspots[MAX_HOTSPOTS];
extern uint8_t hotspot_count;

uint8_t hotspot_add(uint16_t x, uint8_t y, uint16_t w, uint8_t h, uint8_t id);
void    hotspot_clear(void);
uint8_t hotspot_check(uint16_t cx, uint8_t cy);  /* world coords */

#endif
