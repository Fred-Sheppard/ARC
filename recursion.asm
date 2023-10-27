! An implementation of the recursive function f(x) = 2*f(x-1) + 1, f(1) = 2
! Recursion is implemented using a stack pointer

.begin
.org 2048

! ---- MACROS ----

! Push a register's contents to the stack
.macro push reg
	add %r14, 4, %r14
	st reg, %r14
.endmacro

! Pop from the stack into a register
.macro pop reg
	ld %r14, reg
	sub %r14, 4, %r14
.endmacro

! ---- MEMORY ----
	! User input
	x: 3
	! Displayed output
	out: 0

! ---- MAIN ----

main:
	! Start the stack at location 3000
	mov 3000, %r14
	! Push x to the stack
	ld [x], %r2
	push %r2
	! Call the recursive function f
	call f
	! Pop and display the result
	pop %r2
	st %r2, [out]
	halt

f:
	! Pop x, store function pointer
	pop %r2
	push %r15
	! If x == 1, branch
	cmp %r2, 1
	be one
	! Decrement x, push x, call f
	dec %r2
	push %r2
	call f
	! Pop the result of calling f
	pop %r2
	! Multiply x by 2
	sll %r2, 1, %r2
	! Increment x by 1
	inc %r2
	! Pop function pointer
	pop %r1
	! Push the result
	push %r2
	! Jump to calling function
	jmpl %r1 + 4, %r0

one:
	! Push 2 and jump to calling function
	pop %r1
	mov 2, %r2
	push %r2
	jmpl %r1 + 4, %r0
.end

