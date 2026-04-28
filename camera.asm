;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module camera
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _camera_x
	.globl _camera_update
	.globl _camera_world_to_screen_x
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
_camera_x::
	.ds 2
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
;camera.c:11: void camera_update(uint16_t char_world_x) {
;	---------------------------------
; Function camera_update
; ---------------------------------
_camera_update::
;camera.c:15: if (char_world_x < SCREEN_W / 2) {
	ld	a, e
	sub	a, #0x50
	ld	a, d
	sbc	a, #0x00
	jr	NC, 00105$
;camera.c:16: target = 0;
	ld	bc, #0x0000
	jr	00106$
00105$:
;camera.c:17: } else if (char_world_x > WORLD_W - SCREEN_W / 2) {
	ld	c, e
	ld	b, d
	ld	a, #0xb0
	cp	a, c
	ld	a, #0x01
	sbc	a, b
	jr	NC, 00102$
;camera.c:18: target = WORLD_W - SCREEN_W;
	ld	bc, #0x0160
	jr	00106$
00102$:
;camera.c:20: target = (int16_t)char_world_x - SCREEN_W / 2;
	ld	a, e
	add	a, #0xb0
	ld	c, a
	ld	a, d
	adc	a, #0xff
	ld	b, a
00106$:
;camera.c:23: if (target < 0) target = 0;
	ld	h, b
	bit	7, h
	jr	Z, 00108$
	ld	bc, #0x0000
00108$:
;camera.c:24: camera_x = (uint16_t)target;
	ld	hl, #_camera_x
	ld	a, c
	ld	(hl+), a
;camera.c:27: SCX_REG = (uint8_t)(camera_x & 0xFF);
	ld	a, b
	ld	(hl-), a
	ld	a, (hl)
	ldh	(_SCX_REG + 0), a
;camera.c:28: }
	ret
;camera.c:30: int16_t camera_world_to_screen_x(uint16_t world_x) {
;	---------------------------------
; Function camera_world_to_screen_x
; ---------------------------------
_camera_world_to_screen_x::
;camera.c:31: return (int16_t)world_x - (int16_t)camera_x;
	ld	a, e
	ld	hl, #_camera_x
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	sub	a, c
	ld	c, a
	ld	a, d
	sbc	a, b
	ld	b, a
;camera.c:32: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__camera_x:
	.dw #0x0000
	.area _CABS (ABS)
