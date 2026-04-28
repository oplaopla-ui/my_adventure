#include "hotspot.h"
#include <gb/gb.h>

Hotspot hotspots[MAX_HOTSPOTS];
uint8_t hotspot_count = 0;

uint8_t hotspot_add(uint16_t x, uint8_t y, uint16_t w, uint8_t h, uint8_t id) {
    uint8_t idx = hotspot_count;
    if (idx >= MAX_HOTSPOTS) return 255;
    hotspots[idx].x      = x;
    hotspots[idx].y      = y;
    hotspots[idx].w      = w;
    hotspots[idx].h      = h;
    hotspots[idx].id     = id;
    hotspots[idx].active = 1;
    hotspot_count++;
    return idx;
}

void hotspot_clear(void) {
    hotspot_count = 0;
}

uint8_t hotspot_check(uint16_t cx, uint8_t cy) {
    uint8_t i;
    for (i = 0; i < hotspot_count; i++) {
        if (!hotspots[i].active) continue;
        if (cx >= hotspots[i].x &&
            cx <  hotspots[i].x + hotspots[i].w &&
            cy >= hotspots[i].y &&
            cy <  hotspots[i].y + hotspots[i].h) {
            return hotspots[i].id;
        }
    }
    return 255;
}
