;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module hotspot
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _hotspot_count
	.globl _hotspots
	.globl _hotspot_add
	.globl _hotspot_clear
	.globl _hotspot_check
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_hotspots::
	.ds 64
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_hotspot_count::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;hotspot.c:7: uint8_t hotspot_add(uint16_t x, uint8_t y, uint16_t w, uint8_t h, uint8_t id) {
;	---------------------------------
; Function hotspot_add
; ---------------------------------
_hotspot_add::
	dec	sp
	dec	sp
	ldhl	sp,	#1
	ld	(hl), a
;hotspot.c:8: uint8_t idx = hotspot_count;
	ld	a, (#_hotspot_count)
	ldhl	sp,	#0
;hotspot.c:9: if (idx >= MAX_HOTSPOTS) return 255;
	ld	(hl), a
	sub	a, #0x08
	jr	C, 00102$
	ld	a, #0xff
	jr	00103$
00102$:
;hotspot.c:10: hotspots[idx].x      = x;
	ldhl	sp,	#0
	ld	c, (hl)
	xor	a, a
	ld	b, a
	sla	c
	rl	b
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl, #_hotspots
	add	hl, bc
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;hotspot.c:11: hotspots[idx].y      = y;
	ld	hl, #_hotspots
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(de), a
;hotspot.c:12: hotspots[idx].w      = w;
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;hotspot.c:13: hotspots[idx].h      = h;
	ld	hl, #0x0005
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(de), a
;hotspot.c:14: hotspots[idx].id     = id;
	ld	hl, #0x0007
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(de), a
;hotspot.c:15: hotspots[idx].active = 1;
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x01
;hotspot.c:16: hotspot_count++;
	ld	hl, #_hotspot_count
	inc	(hl)
;hotspot.c:17: return idx;
	ldhl	sp,	#0
	ld	a, (hl)
00103$:
;hotspot.c:18: }
	inc	sp
	inc	sp
	pop	hl
	add	sp, #4
	jp	(hl)
;hotspot.c:20: void hotspot_clear(void) {
;	---------------------------------
; Function hotspot_clear
; ---------------------------------
_hotspot_clear::
;hotspot.c:21: hotspot_count = 0;
	xor	a, a
	ld	(#_hotspot_count),a
;hotspot.c:22: }
	ret
;hotspot.c:24: uint8_t hotspot_check(uint16_t cx, uint8_t cy) {
;	---------------------------------
; Function hotspot_check
; ---------------------------------
_hotspot_check::
	add	sp, #-9
	ldhl	sp,	#7
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
	ld	(hl), a
;hotspot.c:26: for (i = 0; i < hotspot_count; i++) {
	ld	c, #0x00
00111$:
	ld	a, c
	ld	hl, #_hotspot_count
	sub	a, (hl)
	jp	NC, 00109$
;hotspot.c:27: if (!hotspots[i].active) continue;
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ld	hl, #_hotspots
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0006
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	or	a, a
	jp	Z, 00108$
;hotspot.c:28: if (cx >= hotspots[i].x &&
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#7
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00108$
;hotspot.c:29: cx <  hotspots[i].x + hotspots[i].w &&
	pop	hl
	push	hl
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	b, (hl)
	ld	e, a
	ld	d, b
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#7
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00108$
;hotspot.c:30: cy >= hotspots[i].y &&
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, b
	jr	C, 00108$
;hotspot.c:31: cy <  hotspots[i].y + hotspots[i].h) {
	dec	hl
	dec	hl
	ld	a, b
	ld	(hl+), a
	ld	(hl), #0x00
	pop	de
	push	de
	ld	hl, #0x0005
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#4
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00108$
;hotspot.c:32: return hotspots[i].id;
	pop	de
	push	de
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	jr	00112$
00108$:
;hotspot.c:26: for (i = 0; i < hotspot_count; i++) {
	inc	c
	jp	00111$
00109$:
;hotspot.c:35: return 255;
	ld	a, #0xff
00112$:
;hotspot.c:36: }
	add	sp, #9
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__hotspot_count:
	.db #0x00	; 0
	.area _CABS (ABS)
