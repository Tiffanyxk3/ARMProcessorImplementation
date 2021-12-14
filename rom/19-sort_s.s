main:
	mov sp, #1
	lsl sp, sp, #10    @ 1024 byte stack
	sub sp, sp, #20
	mov r0, #11
	str r0, [sp]
	mov r0, #99
	str r0, [sp, #4]
	mov r0, #77
	str r0, [sp, #8]
	mov r0, #3
	str r0, [sp, #12]
	mov r0, #15
	str r0, [sp, #16]  @ original array: 11 99 77 3 15
	mov r0, sp
	mov r1, #5         @ len: 5
	bl sort_s
	add r0, r0, #0     @ should be 99 77 15 11 3

@ r0: int *array
@ r1: int len

@ r2: int i
@ r3: int max
@ r5: int index
find_max_index_s:
	sub sp, sp, #12
	str lr, [sp]
	str r4, [sp, #4]          @ store r4 at #4 */
	str r5, [sp, #8]          @ store r5 at #8 */
	mov r5, #0
	ldr r3, [r0, r5, LSL #2]  @ r3 = array + (index * 4) */
	mov r2, #1
	
find_max_loop:
	cmp r2, r1
	bge find_max_endloop      @ checking for the loop condition
	ldr r4, [r0, r2, LSL #2]  @ r4 = array + (i * 4)
	cmp r4, r3                @ checking if the current value is the new maximum
	bgt find_max_greater
	b find_max_loop_increment

find_max_greater:
@ updating values of max and index
	mov r3, r4
	mov r5, r2

find_max_loop_increment:
@ repeated tracker incrementing block
	add r2, r2, #1
	b find_max_loop

find_max_endloop:
	mov r0, r5
	ldr r4, [sp, #4]
	ldr r5, [sp, #8]
	ldr lr, [sp]
	add sp, sp, #12
	bx lr


@ r0: int *array
@ r1: int len

@ r2: int i
@ r3: int max_index
sort_s:
	sub sp, sp, #16
	str lr, [sp]
	mov r2, #0

sort_s_loop:
	cmp r2, r1
	bge sort_s_end

	str r0, [sp, #4]    @ store array at #4
	str r1, [sp, #8]    @ store len at #8
	str r2, [sp, #12]   @ store i at #12
	sub r1, r1, r2
	add r0, r0, r2, LSL #2
	bl find_max_index_s
	ldr r2, [sp, #12]
	add r3, r0, r2

	ldr r0, [sp, #4]
	cmp r3, r2
	bne sort_s_not_equal_i

	b sort_s_increment

sort_s_not_equal_i:
	ldr r12, [r0, r2, LSL #2]
	ldr r1, [r0, r3, LSL #2]
	str r1, [r0, r2, LSL #2]
	str r12, [r0, r3, LSL #2]

sort_s_increment:
	ldr r1, [sp, #8]
	add r2, r2, #1
	b sort_s_loop	

sort_s_end:
	mov r0, r1
	ldr lr, [sp]
	add sp, sp, #16
	bx lr