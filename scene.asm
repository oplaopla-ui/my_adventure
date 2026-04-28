;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module scene
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _scene_init
	.globl _scene_draw_box
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
;scene.c:51: void scene_init(void) {
;	---------------------------------
; Function scene_init
; ---------------------------------
_scene_init::
	dec	sp
;scene.c:54: set_bkg_data(TILE_BLANK,  1, tile_blank);
	ld	de, #_tile_blank
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_data
	add	sp, #4
;scene.c:55: set_bkg_data(TILE_TL,     1, tile_tl);
	ld	de, #_tile_tl
	push	de
	ld	hl, #0x101
	push	hl
	call	_set_bkg_data
	add	sp, #4
;scene.c:56: set_bkg_data(TILE_TR,     1, tile_tr);
	ld	de, #_tile_tr
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_data
	add	sp, #4
;scene.c:57: set_bkg_data(TILE_BL,     1, tile_bl);
	ld	de, #_tile_bl
	push	de
	ld	hl, #0x103
	push	hl
	call	_set_bkg_data
	add	sp, #4
;scene.c:58: set_bkg_data(TILE_BR,     1, tile_br);
	ld	de, #_tile_br
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_data
	add	sp, #4
;scene.c:59: set_bkg_data(TILE_H_TOP,  1, tile_h_top);
	ld	de, #_tile_h_top
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_data
	add	sp, #4
;scene.c:60: set_bkg_data(TILE_H_BOT,  1, tile_h_bot);
	ld	de, #_tile_h_bot
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_data
	add	sp, #4
;scene.c:61: set_bkg_data(TILE_V_L,    1, tile_v_l);
	ld	de, #_tile_v_l
	push	de
	ld	hl, #0x107
	push	hl
	call	_set_bkg_data
	add	sp, #4
;scene.c:62: set_bkg_data(TILE_V_R,    1, tile_v_r);
	ld	de, #_tile_v_r
	push	de
	ld	hl, #0x108
	push	hl
	call	_set_bkg_data
	add	sp, #4
;scene.c:65: t = TILE_BLANK;
	ldhl	sp,	#0
	ld	(hl), #0x00
;scene.c:66: for (row = 0; row < 18; row++) {
	ld	c, #0x00
;scene.c:67: for (col = 0; col < 32; col++) {
00109$:
	ld	b, #0x00
00103$:
;scene.c:68: set_bkg_tiles(col, row, 1, 1, &t);
	ldhl	sp,	#0
	push	hl
	ld	hl, #0x101
	push	hl
	ld	a, c
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;scene.c:67: for (col = 0; col < 32; col++) {
	inc	b
	ld	a, b
	sub	a, #0x20
	jr	C, 00103$
;scene.c:66: for (row = 0; row < 18; row++) {
	inc	c
	ld	a, c
	sub	a, #0x12
	jr	C, 00109$
;scene.c:72: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;scene.c:73: }
	inc	sp
	ret
_tile_blank:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_tile_tl:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
_tile_tr:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
_tile_bl:
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
_tile_br:
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
_tile_h_top:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_tile_h_bot:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
_tile_v_l:
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
_tile_v_r:
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
;scene.c:75: void scene_draw_box(uint8_t tx, uint8_t ty, uint8_t tw, uint8_t th) {
;	---------------------------------
; Function scene_draw_box
; ---------------------------------
_scene_draw_box::
	add	sp, #-8
	ldhl	sp,	#6
	ld	(hl-), a
	ld	(hl), e
;scene.c:78: t = TILE_TL; set_bkg_tiles(tx,          ty,          1, 1, &t);
	ldhl	sp,#0
	ld	(hl), #0x01
	push	hl
	ld	hl, #0x101
	push	hl
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;scene.c:79: t = TILE_TR; set_bkg_tiles(tx + tw - 1, ty,          1, 1, &t);
	ldhl	sp,#0
	ld	(hl), #0x02
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#10
	add	a, (hl)
	dec	a
	ldhl	sp,	#1
	ld	(hl), a
	push	bc
	ld	hl, #0x101
	push	hl
	ldhl	sp,	#9
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;scene.c:80: t = TILE_BL; set_bkg_tiles(tx,          ty + th - 1, 1, 1, &t);
	ldhl	sp,#0
	ld	(hl), #0x03
	ld	c, l
	ld	b, h
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	dec	a
	ldhl	sp,	#2
	ld	(hl), a
	push	bc
	ld	de, #0x101
	push	de
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;scene.c:81: t = TILE_BR; set_bkg_tiles(tx + tw - 1, ty + th - 1, 1, 1, &t);
	ldhl	sp,#0
	ld	(hl), #0x04
	push	hl
	ld	hl, #0x101
	push	hl
	ldhl	sp,	#6
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;scene.c:83: for (x = tx + 1; x < tx + tw - 1; x++) {
	ldhl	sp,	#6
	ld	a, (hl+)
	inc	a
	ld	(hl), a
00104$:
	ldhl	sp,	#6
	ld	a, (hl)
	ld	e, #0x00
	ldhl	sp,	#10
	ld	c, (hl)
	ld	b, #0x00
	add	a, c
	ld	c, a
	ld	a, e
	adc	a, b
	ld	b, a
	dec	bc
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00141$
	bit	7, d
	jr	NZ, 00142$
	cp	a, a
	jr	00142$
00141$:
	bit	7, d
	jr	Z, 00142$
	scf
00142$:
	jr	NC, 00101$
;scene.c:84: t = TILE_H_TOP; set_bkg_tiles(x, ty,          1, 1, &t);
	ldhl	sp,	#0
	ld	(hl), #0x05
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	hl, #0x101
	push	hl
	ldhl	sp,	#9
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;scene.c:85: t = TILE_H_BOT; set_bkg_tiles(x, ty + th - 1, 1, 1, &t);
	ldhl	sp,	#0
	ld	(hl), #0x06
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	hl, #0x101
	push	hl
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;scene.c:83: for (x = tx + 1; x < tx + tw - 1; x++) {
	ldhl	sp,	#7
	inc	(hl)
	jr	00104$
00101$:
;scene.c:88: for (y = ty + 1; y < ty + th - 1; y++) {
	ldhl	sp,	#5
	ld	a, (hl+)
	inc	hl
	inc	a
	ld	(hl), a
00107$:
	ldhl	sp,	#5
	ld	a, (hl)
	ld	e, #0x00
	ldhl	sp,	#11
	ld	c, (hl)
	ld	b, #0x00
	add	a, c
	ld	c, a
	ld	a, e
	adc	a, b
	ld	b, a
	dec	bc
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00143$
	bit	7, d
	jr	NZ, 00144$
	cp	a, a
	jr	00144$
00143$:
	bit	7, d
	jr	Z, 00144$
	scf
00144$:
	jr	NC, 00109$
;scene.c:89: t = TILE_V_L; set_bkg_tiles(tx,          y, 1, 1, &t);
	ldhl	sp,	#0
	ld	(hl), #0x07
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	hl, #0x101
	push	hl
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;scene.c:90: t = TILE_V_R; set_bkg_tiles(tx + tw - 1, y, 1, 1, &t);
	ldhl	sp,#0
	ld	(hl), #0x08
	push	hl
	ld	hl, #0x101
	push	hl
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;scene.c:88: for (y = ty + 1; y < ty + th - 1; y++) {
	ldhl	sp,	#7
	inc	(hl)
	jr	00107$
00109$:
;scene.c:92: }
	add	sp, #8
	pop	hl
	pop	af
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
