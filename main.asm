;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _scene_draw_box
	.globl _scene_init
	.globl _hotspot_check
	.globl _hotspot_add
	.globl _camera_update
	.globl _character_walk_to
	.globl _character_draw
	.globl _character_update
	.globl _character_init
	.globl _cursor_draw
	.globl _cursor_update
	.globl _cursor_init
	.globl _wait_vbl_done
	.globl _joypad
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
;main.c:16: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
	dec	sp
;main.c:18: uint8_t keys      = 0;
	ldhl	sp,	#0
	ld	(hl), #0x00
;main.c:21: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:22: BGP_REG  = 0xE4;   /* background palette: 00=white 01=lgrey 10=dgrey 11=black */
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;main.c:23: OBP0_REG = 0xE4;   /* sprite palette */
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;main.c:26: scene_init();
	call	_scene_init
;main.c:29: scene_draw_box(1, 1, 4, 5);
	ld	hl, #0x504
	push	hl
	ld	a,#0x01
	ld	e,a
	call	_scene_draw_box
;main.c:30: hotspot_add(8, 8, 32, 40, HS_DOOR);
	ld	hl, #0x128
	push	hl
	ld	de, #0x0020
	push	de
	ld	a, #0x08
	ld	de, #0x0008
	call	_hotspot_add
;main.c:33: scene_draw_box(44, 11, 5, 4);
	ld	hl, #0x405
	push	hl
	ld	e, #0x0b
	ld	a, #0x2c
	call	_scene_draw_box
;main.c:34: hotspot_add(352, 88, 40, 32, HS_CHEST);
	ld	hl, #0x220
	push	hl
	ld	de, #0x0028
	push	de
	ld	a, #0x58
	ld	de, #0x0160
	call	_hotspot_add
;main.c:37: character_init();
	call	_character_init
;main.c:38: cursor_init();
	call	_cursor_init
;main.c:40: while(1) {
00111$:
;main.c:41: prev_keys = keys;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(hl), a
;main.c:42: keys = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), a
;main.c:45: cursor_update();
	call	_cursor_update
;main.c:48: if ((keys & J_A) && !(prev_keys & J_A)) {
	push	hl
	ldhl	sp,	#2
	bit	4, (hl)
	pop	hl
	jr	Z, 00108$
	push	hl
	ldhl	sp,	#3
	bit	4, (hl)
	pop	hl
	jr	NZ, 00108$
;main.c:49: hit = hotspot_check(cursor_world_x, cursor_world_y);
	ld	a, (_cursor_world_y)
	ld	hl, #_cursor_world_x
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_hotspot_check
;main.c:51: if (hit == HS_DOOR) {
	cp	a, #0x01
	jr	NZ, 00105$
;main.c:53: character_walk_to(DOOR_WALK_X, WALK_Y);
	ld	a, #0x64
	ld	de, #0x0018
	call	_character_walk_to
	jr	00108$
00105$:
;main.c:54: } else if (hit == HS_CHEST) {
	sub	a, #0x02
	jr	NZ, 00102$
;main.c:56: character_walk_to(CHEST_WALK_X, WALK_Y);
	ld	a, #0x64
	ld	de, #0x0168
	call	_character_walk_to
	jr	00108$
00102$:
;main.c:59: character_walk_to(cursor_world_x, cursor_world_y);
	ld	a, (_cursor_world_y)
	ld	hl, #_cursor_world_x
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_character_walk_to
00108$:
;main.c:64: character_update();
	call	_character_update
;main.c:65: camera_update(char_world_x);
	ld	a, (_char_world_x)
	ld	e, a
	ld	hl, #_char_world_x + 1
	ld	d, (hl)
	call	_camera_update
;main.c:68: character_draw(camera_x);
	ld	a, (_camera_x)
	ld	e, a
	ld	hl, #_camera_x + 1
	ld	d, (hl)
	call	_character_draw
;main.c:69: cursor_draw(camera_x);
	ld	a, (_camera_x)
	ld	e, a
	ld	hl, #_camera_x + 1
	ld	d, (hl)
	call	_cursor_draw
;main.c:71: wait_vbl_done();
	call	_wait_vbl_done
	jr	00111$
;main.c:73: }
	inc	sp
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
