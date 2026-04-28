;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module cursor
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_sprite_data
	.globl _joypad
	.globl _cursor_world_y
	.globl _cursor_world_x
	.globl _cursor_init
	.globl _cursor_update
	.globl _cursor_draw
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_cursor_world_x::
	.ds 2
_cursor_world_y::
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
;cursor.c:24: void cursor_init(void) {
;	---------------------------------
; Function cursor_init
; ---------------------------------
_cursor_init::
;cursor.c:25: set_sprite_data(0, 1, cursor_tiles);
	ld	de, #_cursor_tiles
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_data
	add	sp, #4
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1946: shadow_OAM[nb].prop=prop;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;cursor.c:28: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;cursor.c:29: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;cursor.c:30: }
	ret
_cursor_tiles:
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0x00	; 0
;cursor.c:32: void cursor_update(void) {
;	---------------------------------
; Function cursor_update
; ---------------------------------
_cursor_update::
;cursor.c:33: uint8_t keys = joypad();
	call	_joypad
	ld	c, a
;cursor.c:35: if (keys & J_RIGHT) {
	bit	0, c
	jr	Z, 00104$
;cursor.c:36: if (cursor_world_x < WORLD_W - 8) cursor_world_x += CURSOR_SPEED;
	ld	a, (_cursor_world_x)
	ld	e, a
	ld	hl, #_cursor_world_x + 1
	ld	d, (hl)
	ld	a, e
	sub	a, #0xf8
	ld	a, d
	sbc	a, #0x01
	jr	NC, 00104$
	dec	hl
	inc	de
	inc	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00104$:
;cursor.c:38: if (keys & J_LEFT) {
	bit	1, c
	jr	Z, 00111$
;cursor.c:39: if (cursor_world_x > 0) {
	ld	hl, #_cursor_world_x + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00111$
;cursor.c:40: if (cursor_world_x >= CURSOR_SPEED)
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, #0x02
	ld	a, d
	sbc	a, #0x00
	jr	C, 00106$
;cursor.c:41: cursor_world_x -= CURSOR_SPEED;
	dec	hl
	dec	de
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	jr	00111$
00106$:
;cursor.c:43: cursor_world_x = 0;
	xor	a, a
	ld	hl, #_cursor_world_x
	ld	(hl+), a
	ld	(hl), a
00111$:
;cursor.c:46: if (keys & J_DOWN) {
	bit	3, c
	jr	Z, 00115$
;cursor.c:47: if (cursor_world_y < SCREEN_H - 8) cursor_world_y += CURSOR_SPEED;
	ld	hl, #_cursor_world_y
	ld	a,(hl)
	cp	a,#0x88
	jr	NC, 00115$
	add	a, #0x02
	ld	(hl), a
00115$:
;cursor.c:49: if (keys & J_UP) {
	bit	2, c
	ret	Z
;cursor.c:50: if (cursor_world_y > 0) {
	ld	hl, #_cursor_world_y
	ld	a, (hl)
	or	a, a
	ret	Z
;cursor.c:51: if (cursor_world_y >= CURSOR_SPEED)
;cursor.c:52: cursor_world_y -= CURSOR_SPEED;
	ld	a,(hl)
	cp	a,#0x02
	jr	C, 00117$
	add	a, #0xfe
	ld	(hl), a
	ret
00117$:
;cursor.c:54: cursor_world_y = 0;
	xor	a, a
	ld	(#_cursor_world_y),a
;cursor.c:57: }
	ret
;cursor.c:60: void cursor_draw(uint16_t cam_x) {
;	---------------------------------
; Function cursor_draw
; ---------------------------------
_cursor_draw::
	dec	sp
;cursor.c:61: int16_t sx = (int16_t)cursor_world_x - (int16_t)cam_x;
	ld	a, (_cursor_world_x)
	ld	hl, #_cursor_world_x + 1
	ld	b, (hl)
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
;cursor.c:64: hw_y = cursor_world_y + 16;  /* GB sprite Y offset */
	ld	a, (_cursor_world_y)
	add	a, #0x10
	ldhl	sp,	#0
	ld	(hl), a
;cursor.c:66: if (sx >= -8 && sx <= 160) {
	ld	a, c
	sub	a, #0xf8
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	C, 00102$
	ld	l, c
	ld	h, b
	ld	e, h
	ld	d, #0x00
	ld	a, #0xa0
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	bit	7, e
	jr	Z, 00123$
	bit	7, d
	jr	NZ, 00124$
	cp	a, a
	jr	00124$
00123$:
	bit	7, d
	jr	Z, 00124$
	scf
00124$:
	jr	C, 00102$
;cursor.c:67: hw_x = (uint8_t)(sx + 8);  /* GB sprite X offset */
	ld	a, c
	add	a, #0x08
	ld	c, a
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;cursor.c:68: move_sprite(0, hw_x, hw_y);
	jr	00107$
00102$:
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;cursor.c:70: move_sprite(0, 0, 0);  /* hide if off screen */
00107$:
;cursor.c:72: }
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__cursor_world_x:
	.dw #0x0050
__xinit__cursor_world_y:
	.db #0x48	; 72	'H'
	.area _CABS (ABS)
