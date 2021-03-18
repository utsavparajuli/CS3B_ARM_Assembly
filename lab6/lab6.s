/* -- Lab6.s -- */
@ Author  : Utsav Parajuli
@ Purpose : Setting up the initial stages for RASM-1.
@	    Will be creating 4 variables and convert 2 of them into integers using ascint32 macro and
@	    retrieve data from memory and add them together then store it in another variable.

	.data

szX:	.asciz "10"
szY:	.asciz "15"

iX:	.word	0
iY:	.word	0

iSum:	.word	0

	.text
	.global _start		@ Provide program starting address to linker

_start:
	
	@ STORING "10" INTO iX
	ldr	r0, =szX	@ load into r0 the address of szX
	mov	r4, r0		@ copy contents of r0 into r4
	bl	ascint32	@ call ascint32 (external fn) to convert szX to a 32 bit integer
	ldr	r1, =iX		@ r1 points to iX
	str	r0, [r1]	@ *r1 = r0

	@ STORING "15" INTO iY
	ldr	r0, =szY	@ load into r0 the address of szY
	mov	r5, r0		@ copy contents of r0 into r5
	bl	ascint32	@ call ascint32 (external fn) to convert szY to a 32 bit integer
	ldr	r2, =iY		@ r2 points to iY
	str	r0, [r2]	@ *r2 = r0

	@ Retreiving values from iX and iY
	ldr	r1, [r1]	@ *r1 = r1 (derefrences r1 as r1 points to iX)
	ldr	r2, [r2]	@ *r2 = r2 (derefrences r2 as r2 points to iY)

	@ Adding the values
	add	r0, r1, r2	@ adds r1 and r2 and stores the result in r0
	
	@ Getting the address of variables iX and iY into r1 and r2
	ldr	r1, =iX		@ r1 points to iX
	ldr	r2, =iY		@ r2 points to iY

	@ STROING the sum into iSum
	ldr	r3, =iSum	@ r3 points to iSum
	str	r0, [r3]	@ *r3 = r0

	mov	r0, #0		@ Set program Exit Status code to 0.
	mov	r7, #1		@ Service command code of 1 to terminate program

	svc	0
	.end
