;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module character
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_sprite_data
	.globl _char_walking
	.globl _char_target_y
	.globl _char_target_x
	.globl _char_world_y
	.globl _char_world_x
	.globl _character_init
	.globl _character_update
	.globl _character_draw
	.globl _character_walk_to
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
_char_world_x::
	.ds 2
_char_world_y::
	.ds 1
_char_target_x::
	.ds 2
_char_target_y::
	.ds 1
_char_walking::
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
;character.c:34: void character_init(void) {
;	---------------------------------
; Function character_init
; ---------------------------------
_character_init::
;character.c:36: set_sprite_data(CHAR_TILE_L, 1, char_tile);
	ld	bc, #_char_tile+0
	push	bc
	ld	hl, #0x101
	push	hl
	call	_set_sprite_data
	add	sp, #4
;character.c:37: set_sprite_data(CHAR_TILE_R, 1, char_tile);
	push	bc
	ld	hl, #0x102
	push	hl
	call	_set_sprite_data
	add	sp, #4
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x01
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x02
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1946: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 7)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 11)
	ld	(hl), #0x00
;character.c:43: set_sprite_prop(CHAR_SPRITE_R, 0x00);
;character.c:44: }
	ret
_char_tile:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
;character.c:46: void character_update(void) {
;	---------------------------------
; Function character_update
; ---------------------------------
_character_update::
	dec	sp
	dec	sp
;character.c:47: if (!char_walking) return;
	ld	a, (#_char_walking)
	or	a, a
	jp	Z, 00122$
;character.c:52: char_world_x = char_target_x;
	ld	a, (_char_target_x)
	ld	c, a
	ld	hl, #_char_target_x + 1
	ld	b, (hl)
;character.c:54: char_world_x += CHAR_SPEED;
	ld	a, (#_char_world_x)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#_char_world_x + 1)
	ldhl	sp,	#1
	ld	(hl), a
;character.c:50: if (char_world_x < char_target_x) {
	ld	de, #_char_world_x
	ld	hl, #_char_target_x
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00112$
;character.c:51: if (char_target_x - char_world_x <= CHAR_SPEED) {
	ld	a, (#_char_target_x)
	ld	hl, #_char_world_x
	sub	a, (hl)
	ld	e, a
	ld	a, (#_char_target_x + 1)
	ld	hl, #_char_world_x + 1
	sbc	a, (hl)
	ld	d, a
	ld	a, #0x01
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	C, 00104$
;character.c:52: char_world_x = char_target_x;
	dec	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00113$
00104$:
;character.c:54: char_world_x += CHAR_SPEED;
	pop	bc
	push	bc
	inc	bc
	ld	hl, #_char_world_x
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00113$
00112$:
;character.c:56: } else if (char_world_x > char_target_x) {
	ld	de, #_char_target_x
	ld	hl, #_char_world_x
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00113$
;character.c:57: if (char_world_x - char_target_x <= CHAR_SPEED) {
	ld	a, (#_char_world_x)
	ld	hl, #_char_target_x
	sub	a, (hl)
	ld	e, a
	ld	a, (#_char_world_x + 1)
	ld	hl, #_char_target_x + 1
	sbc	a, (hl)
	ld	d, a
	ld	a, #0x01
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	C, 00107$
;character.c:58: char_world_x = char_target_x;
	ld	hl, #_char_world_x
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00113$
00107$:
;character.c:60: char_world_x -= CHAR_SPEED;
	pop	bc
	push	bc
	dec	bc
	ld	hl, #_char_world_x
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00113$:
;character.c:65: if (char_world_y < char_target_y) {
	ld	a, (#_char_world_y)
	ld	hl, #_char_target_y
	sub	a, (hl)
	jr	NC, 00117$
;character.c:66: char_world_y++;
	ld	hl, #_char_world_y
	inc	(hl)
	jr	00118$
00117$:
;character.c:67: } else if (char_world_y > char_target_y) {
	ld	a, (#_char_target_y)
	ld	hl, #_char_world_y
	sub	a, (hl)
	jr	NC, 00118$
;character.c:68: char_world_y--;
	dec	(hl)
00118$:
;character.c:72: if (char_world_x == char_target_x && char_world_y == char_target_y) {
	ld	a, (#_char_world_x)
	ld	hl, #_char_target_x
	sub	a, (hl)
	jr	NZ, 00122$
	ld	a, (#_char_world_x + 1)
	ld	hl, #_char_target_x + 1
	sub	a, (hl)
	jr	NZ, 00122$
	ld	a, (#_char_world_y)
	ld	hl, #_char_target_y
	sub	a, (hl)
	jr	NZ, 00122$
;character.c:73: char_walking = 0;
	xor	a, a
	ld	(#_char_walking),a
00122$:
;character.c:75: }
	inc	sp
	inc	sp
	ret
;character.c:77: void character_draw(uint16_t cam_x) {
;	---------------------------------
; Function character_draw
; ---------------------------------
_character_draw::
	dec	sp
;character.c:82: sx = (int16_t)char_world_x - (int16_t)cam_x;
	ld	a, (_char_world_x)
	ld	hl, #_char_world_x + 1
	ld	b, (hl)
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
;character.c:85: hw_y   = char_world_y + 16;
	ld	a, (_char_world_y)
	add	a, #0x10
	ldhl	sp,	#0
	ld	(hl), a
;character.c:87: if (sx >= -8 && sx <= 160) {
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
	jr	Z, 00125$
	bit	7, d
	jr	NZ, 00126$
	cp	a, a
	jr	00126$
00125$:
	bit	7, d
	jr	Z, 00126$
	scf
00126$:
	jr	C, 00102$
;character.c:89: hw_x_l = (uint8_t)(sx + 8);
	ld	a, c
	add	a, #0x08
	ld	d, a
;character.c:90: hw_x_r = (uint8_t)(sx + 16);
	ld	a, c
	add	a, #0x10
	ld	e, a
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #(_shadow_OAM + 4)
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+8
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	a, e
	ld	(bc), a
;character.c:93: move_sprite(CHAR_SPRITE_R, hw_x_r, hw_y);
	jr	00109$
00102$:
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;/Users/johanthornqvist/Desktop/gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;character.c:97: move_sprite(CHAR_SPRITE_R, 0, 0);
00109$:
;character.c:99: }
	inc	sp
	ret
;character.c:101: void character_walk_to(uint16_t wx, uint8_t wy) {
;	---------------------------------
; Function character_walk_to
; ---------------------------------
_character_walk_to::
	ld	hl, #_char_target_x
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	(#_char_target_y),a
;character.c:104: char_walking  = 1;
	ld	hl, #_char_walking
	ld	(hl), #0x01
;character.c:105: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__char_world_x:
	.dw #0x0050
__xinit__char_world_y:
	.db #0x64	; 100	'd'
__xinit__char_target_x:
	.dw #0x0050
__xinit__char_target_y:
	.db #0x64	; 100	'd'
__xinit__char_walking:
	.db #0x00	; 0
	.area _CABS (ABS)
