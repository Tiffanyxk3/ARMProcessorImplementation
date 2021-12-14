main:
	mov sp, #1
	lsl sp, sp, #10    @ 1024 byte stack
	sub sp, sp, #28
	mov r0, #70
	str r0, [sp]
	mov r0, #111
	str r0, [sp, #4]
	mov r0, #111
	str r0, [sp, #8]
	mov r0, #66
	str r0, [sp, #12]
	mov r0, #97
	str r0, [sp, #16]
	mov r0, #114
	str r0, [sp, #20]
	mov r0, #49
	str r0, [sp, #24]  @ text: FooBar1
	mov r0, sp
	bl to_upper_s
	add r0, r0, #0     @ should be 70 79 79 66 65 82 49

@ r0: char *word
to_upper_s:
	ldrb r1, [r0]
	cmp r1, #0
	beq to_upper_s_exit
	cmp r1, #97         @ checking if r1 is already an uppercase letter
	blt to_upper_s_loop_increment
	sub r1, r1, #32
	strb r1, [r0]

to_upper_s_loop_increment:
	add r0, r0, #4
	b to_upper_s

to_upper_s_exit:
	bx lr
