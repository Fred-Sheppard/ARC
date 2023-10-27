! An implementation of the recursive function f(x) = 2f(x-1) +1, f(1) = 2

.begin
.org 2048

! ---- MACROS ----
.macro push reg
	sub %r14, 4, %r14
	st reg, %r14
.endmacro

.macro pop reg
	ld %r14, reg	
	add %r14, 4, %r14
.endmacro

! ---- MEMORY ----
	x: 3
	out: 0


! ---- REGISTERS ----
! r1 = Address
! r2 = Value

! ---- MAIN ----
main:
	mov 3000, %r14
	mov 3, %r2
	push %r2
	call f1
	pop %r2
	halt

f1:
	! Get value, push pointer
	pop %r2
	push %r15
	! Branch on val = 1
	cmp %r2, 1
	be one

	! Decrease, push and call
	dec %r2
	push %r2
	call f1

	Pop, multiply by 2, add 1
	pop %r2
	sll %r2, 1, %r2
	inc %r2
	! Pop pointer, push val, jump
	pop %r1
	push %r2
	jmpl %r1 + 4, %r0

	
one:
	pop %r1
	mov 2, %r2
	push %r2
	jmpl %r1 + 4, %r0

.end

