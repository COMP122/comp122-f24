	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 2
	.globl	_f                              ; -- Begin function f
	.p2align	2
_f:                                     ; @f
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	w0, [x29, #-4]
	str	w1, [sp, #8]
	mov	w8, #1
	stur	w8, [x29, #-4]
	mov	w8, #2
	str	w8, [sp, #8]
	mov	w8, #3
	str	w8, [sp, #4]
	mov	w8, #4
	str	w8, [sp]
	ldr	w0, [sp, #4]
	ldr	w1, [sp]
	bl	_f
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	wzr, [x29, #-4]
	mov	w8, #2
	str	w8, [sp, #8]
	mov	w8, #3
	str	w8, [sp, #4]
	ldr	w0, [sp, #8]
	ldr	w1, [sp, #4]
	bl	_f
	str	w0, [sp]
	ldr	w0, [sp]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
