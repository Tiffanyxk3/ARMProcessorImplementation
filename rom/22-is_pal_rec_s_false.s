main:
	mov sp, #1
	lsl sp, sp, #10    @ 1024 byte stack
	sub sp, sp, #28
	mov r0, #99
	str r0, [sp]
	mov r0, #115
	str r0, [sp, #4]
	mov r0, #51
	str r0, [sp, #8]
	mov r0, #49
	str r0, [sp, #12]
	mov r0, #53
	str r0, [sp, #16]
	mov r0, #115
	str r0, [sp, #20]
	mov r0, #99
	str r0, [sp, #24]  @ text: cs315sc
	mov r0, sp
	mov r1, #0         @ start: 0
	mov r2, #6         @ end: 6
	bl is_pal_rec_s
	add r0, r0, #0     @ r0 should be 0

@ r0: *str
@ r1: start
@ r2: end
is_pal_rec_s:
	sub sp, sp, #4
	str lr, [sp]

	cmp r1, r2         @ checking if we are at the end of the array
	bge is_pal_rec_greater_equal
	ldrb r3, [r0, r1]
	ldrb r4, [r0, r2]
	cmp r3, r4
	bne is_pal_rec_not_equal
	b is_pal_rec_recursion

is_pal_rec_greater_equal:
	mov r0, #1         @ set r0 to true
	b is_pal_rec_end

is_pal_rec_not_equal:
	mov r0, #0         @ set r0 to false
	b is_pal_rec_end

is_pal_rec_recursion:
	add r1, r1, #1
	sub r2, r2, #1
	bl is_pal_rec_s

is_pal_rec_end:
	ldr lr, [sp]
	add sp, sp, #4
	bx lr
