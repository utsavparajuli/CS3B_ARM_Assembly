@Author: Utsav Parajuli
@File Functions

@ =========== open_file function =============
@ Opens a file with the given filename
@ ============================================
@ Input:
@	r1: File name string
@	r2: File flags
@ Output:
@ 	r0: Returns file handle
@ ============================================

	.global	open_file

open_file:
	push	{R1,R2,R7}

	mov	R0,R1		@ Move file name into r0
	mov	R1,R2		@ Move file code into r2
	mov	R2,#0666	@ Allow access to all groups
	mov	R7,#5		@ Code # to open file
	svc	0

	pop	{R1,R2,R7}
	bx	LR

@ ============= close_file function ================
@ closes a given file
@ ==================================================
@ Input:
@	r0: File handle
@ Output: None
@ ==================================================

	.global	close_file

close_file:
	push	{R7}

	mov	R7,#6
	svc	0
	
	pop	{R7}
	bx	LR

@ ============ write_to_file function ==================
@ Writes a string out to a specific file
@ ======================================================
@ Input:
@	r0: Contains the File handle
@	r1: Contains the string to be output
@ Output: None
@ ======================================================

	.global	write_to_file

write_to_file:
	push	{R0-R2,R7,LR}

	push	{R0}	@ Save the file handle
	bl	String_length2
	mov	R2, R0

	mov	R7, #4
	pop	{R0}	@ Load back in the file handle
	svc	0

	pop	{R0-R2,R7,LR}
	bx	LR


@ ================== read_char function =================
@ reads a character from a given file
@ =======================================================
@ Input:
@	r0: File handle
@ Output:
@ 	r1: the character that was read
@   r2: Boolean depending if the end of file has been reached
@ =======================================================

	.data
char: .space 1

	.text
	.global read_char

read_char:
	push	{R0,R7}

	ldr	R1, =char	@ Points to where chracter will be stored
	mov	R2, #1		@ # of bytes being read
	mov	R7, #3		@ Read File code #
	svc	0

	cmp	R0, #0		@ Compared bytes read, to 0
	beq	end_of_file 	@ If it equals 0 then we reached end of file

	mov	R2, #0		@ Else, we have not reached the end

	ldrb	R1,[R1]		@ Loads a character from address
	b	rch__return

end_of_file:
	mov	R1, #0		@ Return character is null
	mov	R2, #1		@ Returns true for end of file
	b	rch__return

rch__return:
	pop	{R0,R7}
	bx	LR

@ ===================== read_line ============================
@ reads in a line from a file
@ ============================================================
@ Input:
@	r0: File handle
@ Output:
@ 	r1: String (file line that is read)
@	r2: Boolean if the end of file has been reached
@ ============================================================

	.data
strBuf: .space 256

	.text
	.global read_line

read_line:
	push	{R0,R3-R5,LR}

	ldr	R3, =strBuf		@ Point r3 to strBuf
	mov	R5, #0			@ Store null into r5

readline__loop:
	push	{R3}		@ Store strBuf

	bl	read_char

	cmp	R2, #1
	beq	end_of_file1	@ Checks to see if end of file has been reached

	pop	{R3}		@ Load back in strBuf

	cmp	R1, #'\r'
	beq	carriage_found	@ If char == \r line is done

	cmp	R1, #'\n'
	beq	end_line_found	@ If char == \n line is done

	cmp	R4, #255
	beq	end_line_found	@ If bufCount == 255 line is done

	strb	R1, [R3], #1	@ Store the char into buffer and offset ptr
	add	R4, #1

	b	readline__loop


carriage_found:
	bl	read_char	@ Caridge is always followed by a \n
	b	end_line_found

end_line_found:
	strb	R5, [R3]	@ Store a null terminator to end string
	b	make_string

make_string:
	ldr	R3, =strBuf
	mov	R1, R3
	bl	String_Copy	@ Creates copy of the string
	mov	R1, R0		@ Return copy of string into r1
	b	readline__return

end_of_file1:
	pop	{R3}
	b	readline__return

readline__return:
	pop	{R0,R3-R5,LR}
	bx	LR
	
	
@ ================== load_list_from_file ================
@ loads a list from a given file
@ =======================================================
@ Input:
@	r1: List
@ Output: None
@ =======================================================

	.global load_list_from_file

load_list_from_file:
	push	{R0-R2,LR}

llist__loop:
	push	{R1}		@ Save the list
	bl	read_line

	cmp	R2,#1
	popeq	{R1}		@ If its the end of the file, we load list
	beq	loop_exit	@ If its the end of the file, we exit loop
	
	push	{R0}		@ Save the file handle
	bl	String_Copy	@ Will return string copy into r0
	mov	R2,R0		@ Store the string copy into r2
	pop	{R0}		@ Load back the file handle

	pop	{R1}		@ Load back the list
	mov	R0, R1		@ Move list into r0
	mov	R1, R2		@ Move the string into r1
	@bl	List_addstr	@ Must contain r0 = list, r1 = string
	mov	R2, R1		@ Put string back into r2
	mov	R1, R0		@ Put list back into r1

	b	llist__loop

loop_exit:
	pop	{R0-R2,LR}
	bx	LR
