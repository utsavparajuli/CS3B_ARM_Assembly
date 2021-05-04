@ Author: Utsav Parajuli
@ Class:  CS3B
@ RASM4
@ Creating a simple text editor as we can add texts through keyboard, or a file. Have a list of menu options for the user

	.data

	.equ	MIN, 		1
	.equ	MAX, 		7
	.equ	SIZE,	 	512
	.equ	MIN_CHAR,	'a'
	.equ	MAX_CHAR,	'b'

@Name Output
szName:		.asciz	"\nName:  Utsav Parajuli & Omar Cruz\nClass: CS3B\nLab:   RASM4\nDate:  04/26/2021\n\n"

@Menu Output
szMenu1:	.asciz	"		RASM4 TEXT EDITOR\n"
szMenu2:	.asciz	"	Data Structure Heap Memory Consumption: "
szBytes:	.asciz	" bytes\n"
szMenu3:	.asciz	"	Number of Nodes: "

@Menu options
szOption1:	.asciz	"\n<1> View all strings\n\n"
szOption2:	.asciz	"<2> Add string\n"
szOption2a:	.asciz	"	<a> from Keyboard\n"
szOption2b:	.asciz	"	<b> from File.\n\n"
szOption3:	.asciz	"<3> Delete string\n\n"
szOption4:	.asciz	"<4> Edit string\n\n"
szOption5:	.asciz	"<5> String search\n\n"
szOption6:	.asciz	"<6> Save File\n\n"
szOption7:	.asciz	"<7> Quit\n\n"

@Invalid messages
szInvalidInput:	.asciz	"ERROR: Enter a valid option\n"		@ Error when option is invalid
szNumIP:	.asciz	"Enter a number (1-7): "		@ Prompt for input
szOp2IP:	.asciz	"Enter a character (a or b): "		@ Prompt for 2nd part input
szOp2aIP:	.asciz	"Enter a string to add to the list: "	@ Prompt for part 2 a
szOp2bIP:	.asciz	"Enter the name of the file: "		@ Prompt for part 2 b
szEnterTC:	.asciz	"PRESS ENTER TO CONTINUE..."
szOp2aMsg:	.asciz	"String added!\n\n"			@ Confirmation message
szOp2bMsg:	.asciz	"Strings added from "			@ Confirmation message
szIndex:	.asciz	"Enter an Index #: "			@ prompt for index enter
szDeleteMsg:	.asciz	"String deleted!"			@ message for string deletion
szReplaceMsg:	.asciz	"String replaced!"			@ message for string replace
szReplaceIP:	.asciz	"Enter the new string: "		@ Prompt for replacing
szSearchIP:	.asciz	"Enter a string to search for: "	@ Prompt for string search
szOp6Msg:	.asciz	"List saved to "		@ message for output saved

outputFile:	.skip	12					@ output file name

clearCmd:	.asciz	"clear"					@ System call for c++ clear command
inputFileCheck:	.asciz	"input.txt"
inputFile:	.skip	12					@ input file name
szIndexPrint:	.skip	12

@Storage
opBuffer:	.word	0
stringList:	.word	0
dataUse:	.word	0
nodeUse:	.word	0
userIndex:	.word	0
currentFH:	.word	0
indexPrint:	.word	0

@ Buffers
inputBuffer:	.skip	SIZE
szBuffer:	.skip	SIZE		@used for input
szUserStr:	.skip	SIZE
pauseBuffer:	.skip	SIZE		@while paused user input is stored in this buffer
szMemory:	.skip	12		@Memory consumption
szNode:		.skip	12	
strInput:	.skip	SIZE		@String input

inpInvalid:	.asciz	"INVALID NUMERIC STRING. RE-ENTER VALUE\n"
inpOverflow:	.asciz	"OVERFLOW OCCURRED. RE-ENTER VALUE\n"

chB:		.byte	0x29
chS:		.byte	0x20
chLF:		.byte	0x0A

	.text
	.global _start
	.extern malloc
	.extern free
	.extern system


_start:
//construct empty linked list
	bl	List

	ldr	r4, =stringList		@ Load the address of stringList into r4. The pointer will be stored here
	str	r0, [r4]

menu:

@======	Clearing screen:======
	ldr	r0, =clearCmd		@ Load the address of clearCmd into r0
	bl	system			@ branch to system

@====== Outputting name:=======
	ldr	r0, =szName		@ Load address of name into r0
	bl	putstring

@======	Outputting menu:======
	ldr	r0, =szMenu1
	bl	putstring
	ldr	r0, =szMenu2
	bl	putstring

@====== Printing the data consumption ======
	bl	data_use		@ r0 will contain the number of bytes
	ldr	r1, =szMemory		@ Load address of szMemory into r1
	bl	intasc32

	ldr	r0, =szMemory
	bl	putstring		@ prints to screen

	ldr	r0, =szBytes
	bl	putstring

@====== Printing nodes:=======
	ldr	r0, =szMenu3
	bl	putstring

	ldr	r1, =szNode		@ Load into r1 the address of szNode
	ldr	r0, =nodeUse
	ldr	r0, [r0]		@ get the contents in r0
	bl	intasc32

	ldr	r0, =szNode		@ Load into r0 the address of szNode
	bl	putstring

@====== Displaying options:====
	ldr	r0, =szOption1
	bl	putstring

	ldr	r0, =szOption2
	bl	putstring

	ldr	r0, =szOption2a
	bl	putstring

	ldr	r0, =szOption2b
	bl	putstring

	ldr	r0, =szOption3
	bl	putstring

	ldr	r0, =szOption4
	bl	putstring

	ldr	r0, =szOption5
	bl	putstring

	ldr	r0, =szOption6
	bl	putstring

	ldr	r0, =szOption7
	bl	putstring

@====== Checking for input and getting the option: =====
	mov	r0, #MIN
	mov	r1, #MAX
	ldr	r2, =GetIntInput	@Gets user input
	bl	GetValue		@Gets the actual option input
	mov	r4, r0

@====== Option: 7 Exit Program ==================
	cmp	r4, #MAX		@ compare the user option input with the max
	beq	endOfProgram		@ branch to the end of program and quit


@====== Option: 1 View All Strings ==============
	cmp	r4, #1
	beq	option1
	bal	endOption1

	option1:			@ Display the list
	ldr	r0, =stringList
	ldr	r0, [r0]
	bl	DisplayList

	endOption1:
	cmp	r4, #1			@ Branching out of the switch
	beq	optionEnd


@====== Option: 2 Adding String ==========
	cmp	r4, #2			@ Comparing if the option entered is 2
	beq	option2
	bal	endOption2

	option2:
	ldr	r0, =stringList		@ Loads the address of string list the pointer
	ldr	r0, [r0]
	bl	AddToList

	endOption2:
	cmp	r4, #2
	beq	optionEnd		@ Branch out and ask for user input again


@====== Option: 3 Deleting String ==============
	cmp	r4, #3			@ Comparing the option entered to #3
	beq	option3
	bal	endOption3

	option3:
	ldr	r0, =szIndex		@ Load address of szIndex into r0
	bl	putstring

	ldr	r0, =szBuffer		@ Load address of szBuffer into r0
	mov	r1, #SIZE
	bl	getstring		@ get the index number

	ldr	r0, =szBuffer
	bl	ascint32		@ Converting user entry into int

	ldr	r1, =userIndex
	str	r0, [r1]		@ Stores the index num into the userIndex variable

	ldr	r0, =stringList		@ Load contents of the ptr into r0
	ldr	r0, [r0]
	ldr	r1, =userIndex
	ldr	r1, [r1]
	sub 	r1, #1			@ Aligns index for user
	bl	List_remove		@ Calling List_remove function to delete node from list

	ldr	r0, =szDeleteMsg	@ Load address of szDeleteMsg into r0
	bl	putstring		@ Prints the string

	ldr	r0, =chLF
	bl	putch
	ldr	r0, =chLF
	bl	putch			@ prints 2 endline

	endOption3:
	cmp	r4, #3			@ comparing r4 to 3
	beq	optionEnd
	

@====== Option: 4 Edit String =========================
	cmp	r4, #4			@ Checking if user entry was 4
	beq	option4
	bal	endOption4

	option4:
	ldr	r0, =szIndex		@ Gets the index from user
	bl	putstring

	ldr	r0, =szBuffer
	mov	r1, #SIZE
	bl	getstring		@ gets the string from user

	ldr	r0, =szBuffer
	bl	ascint32		@ converts the int to ascii

	ldr	r1, =userIndex
	str	r0, [r1]		@ Stores the user index

	ldr	r0, =szReplaceIP	@ Prompt the user to enter new string
	bl	putstring

	ldr	r0, =szUserStr		@ contains the string to be replaced with
	mov	r1, #SIZE
	bl	getstring		@ gets the string

	mov	r3, r0
	ldr	r0, =stringList
	ldr	r0, [r0]
	ldr	r1, =userIndex
	ldr	r1, [r1]
	sub	r1, #1
	ldr	r2, =szUserStr
	bl	List_setstr

	ldr	r0, =szReplaceMsg	@ Displays the replace message
	bl	putstring

	ldr	r0, =chLF
	bl	putch
	ldr	r0, =chLF
	bl	putch			@ prints new line


	endOption4:
	cmp	r4, #4			@ branch out of the switch
	beq	optionEnd

@====== Option: 5 Search String =========================
	cmp	r4, #5			@ check if user entry was a 5
	beq	option5
	bal	endOption5

	option5:
	ldr	r0, =szSearchIP		@ Ask the user to enter the string to search for
	bl	putstring

	ldr	r0, =szUserStr
	mov	r1, #SIZE
	bl	getstring		@ gets the string from user

	ldr	r0, =stringList		@ get the address of head
	ldr	r0, [r0]
	ldr	r1, =szUserStr
	ldr	r2, =String_containsIgnoreCase
	bl	List_printMatch

	endOption5:
	cmp	r4, #5			@ Branch out of the switch
	beq	optionEnd



@====== Option: 6 Save to File =========================
	cmp	r4, #6
	beq	option6
	bal	endOption6

	option6:
	ldr	r0, =szOp2bIP		@ Load address of szOp2bIP
	bl	putstring

	ldr	r0, =outputFile		@ r0 will have the address of outputfile
	mov	r1, #SIZE		@ bytes read in
	bl	getstring		@ get the name of file

	ldr	r0, =stringList		@ pointer to the head
	ldr	r0, [r0]

	ldr	r1, =outputFile
	bl	List_outputToFile	@ branch to output to file

	ldr	r0, =szOp6Msg
	bl	putstring		@ outputs the message

	ldr	r0, =outputFile
	bl	putstring

	ldr	r0, =chLF
	bl	putch
	ldr	r0, =chLF
	bl	putch

	endOption6:
	b	optionEnd

@ ===============menu loop============
optionEnd:
	ldr	r0, =szEnterTC		@ ask the user to enter to continue
	bl	putstring

	ldr	r0, =pauseBuffer	@ Load the address of pauseBuffer into r0
	mov	r1, #SIZE
	bl	getstring		@ get the string from user

@================ LOOP BACK INTO THE TOP: ==============
	b	menu			@ Loop back up

@====== Option 7 Executed End of Program: ========
endOfProgram:
	ldr	r0, =stringList		@ Load address of pointer
	ldr	r0, [r0]
	bl	d_List

	mov	r0, #0
	mov	r7, #1
	svc	0



@ =================== GetIntInput function: ================
@ Asks user to input a number and puts it into r0
@ ==========================================================
GetIntInput:
	push	{r4-r11,lr}

	intInputLoop:
	ldr	r0, =szNumIP		@ Input prompt displayed
	bl	putstring

	ldr	r0, =szBuffer		@ Load into r0 the address of buffer
	mov	r1, #SIZE
	bl	getstring		@ gets the input

	cmp	r0, #0			@ checking if the user entered anything
	beq	inputSuccess

	ldr	r0, =szBuffer		@ load into r0 the address of buffer
	bl	ascint32

	bvs	intInputOverflow	@ branch if overflow is set
	cmpcs	r0, #0			@ Input is invalid if r0 = 0 and carry flag is set
	beq	intInputInvalid
	bal	inputSuccess		@ if previous conditions pass we branch

	intInputInvalid:
	ldr	r0, =inpInvalid		@ Output invalid message
	bl	putstring		@ branch to putstring
	bal	intInputLoop		@ branch back to top of loop

	intInputOverflow:
	ldr	r0, =inpOverflow	@ Output overflow msg
	bl	putstring		@ branch to putstring
	bal	intInputLoop

	inputSuccess:
	pop	{r4-r11, pc}		@ exit function


@====== GetValue function: ===========================
@ Returns a value into r0 between the range specified
@======================================================
GetValue:
	push	{r4-r11, lr}
	
	mov	r4, r0
	mov	r5, r1
	mov	r6, r2

	blx	r6		@ Generate a value and store in r7
	mov	r7, r0

	mov	r1, r7		@ Check to see if the integer input is valid
	mov	r2, r4
	mov	r3, r5
	bl	inrange

	cmp	r0, #0
	beq	outOfRange		@ If input out of range, loop again
	bal	endOutOfRange	@ If input in range, branch out of input loop

	outOfRange:
	ldr	r1, =szInvalidInput	@ print the error message
	bl	putstring
	bal	endOutOfRange

	endOutOfRange:
	mov	r0, r7			@ move the int input back into return register
	pop	{r4-r11,pc}


@====== inrange function: ==================
@ Returns 0 or 1 into r0 if the number in r1
@ is within range in r2 and r3
@ ==========================================
inrange:
	cmp	r1, r2			@ Branch to out of range if num < min
	blt	outRange

	cmp	r1, r3			@ Branch to out of range if num < min
	bgt	outRange

	bal	inRange			@ Branch to inRange if conditions above pass

	outRange:
	mov	r0, #0
	bal	endRange

	inRange:
	mov	r0, #1
	
	endRange:
	mov	pc, lr			@ Branch back to the instruction specified by LR


@====== List function: ===============
@ The constructor for the linked list
@=====================================
List:
	push	{r4-r11, lr}

	mov	r0, #0		@ Increase the data usage by 8 as the new node is added
	bl	update_data_usage

	mov	r0, #8		@ Move 8 into r0
	bl	malloc		@ allocating 4 bytes for head and 4 for tail

	mov	r1, #0
	str	r1, [r0]	@ Store null pointer into head
	str	r1, [r0, #4]	@ Store null pointer in tail

	pop	{r4-r8, r10-r12, pc}

@====== AddToList function: =================
@ This function will add contents to the list
@===========================================
AddToList:
	push	{r4-r11,lr}
	mov	r4, r0		@ Save the head ptr
	
	mov	r0, #MIN_CHAR	
	mov	r1, #MAX_CHAR
	ldr	r2, =getChar
	bl	GetValue

	mov	r5, r0		@ r5 has the entry received

	cmp	r5, #'a'	@ If option is 'a' get the string from keyboard
	bne	endAddStrInp

	mov	r0, r4		@ Get the original content back
	bl	AddStringInp

	endAddStrInp:
	cmp	r5, #'a'
	beq	addEndSwitchOption

	mov	r0, r4
	cmp	r5, #'b'	@ If option is 'b' add from file
	bleq	AddStrFile	@ adding from file

	addEndSwitchOption:
	pop	{r4-r11,pc}

@====== getChar function: =====================
@ This function gets the character for option 2
@=============================================
getChar:
	push	{r4-r11,lr}
	
	ldr	r0, =szOp2IP	@ Load address of input prompt into r0
	bl	putstring
	
	ldr	r0, =opBuffer
	mov	r1, #SIZE
	bl	getstring
	ldrb	r0, [r0]	@ Returns the first character in the string

	pop	{r4-r11, pc}

@====== AddStringInp function: ==============
@ This function will get string from keyboard
@==============================================
AddStringInp:
	push {r4-r11,lr}

	mov	r4, r0		@ Save the pointer

	ldr	r0, =szOp2aIP	@ Load address of 2a input prompt into r0
	bl	putstring

	ldr	r0, =inputBuffer
	mov	r1, #SIZE
	bl	getstring	@ gets the string

	mov	r0, r4
	ldr	r1, =inputBuffer
	bl	List_addstr	@ Add the string inputted by user

	ldr	r0, =szOp2aMsg	@ print the confirmation message
	bl	putstring

	pop	{r4-r11,pc}


@====== AddStrFile function: =======================
@ This method will add the string from file
@===================================================
AddStrFile:
	push	{r4-r11,lr}
	
	mov	r4, r0		@ Save the pointer

	ldr	r0, =szOp2bIP	@ Load address of 2b input prompt into r0
	bl	putstring

	ldr	r0, =inputFile	@ Load address of inputFile into r0
	mov	r1, #13		@ max num of bytes read in +1
	bl	getstring	@ get the input

	mov	r0, r4		@ moving back the contents

	ldr	r1, =inputFile	@ Load address of input file into r1
	bl	List_inputFromFile

	ldr	r0, =szOp2bMsg	@ Print the confirmation message
	bl	putstring

	ldr	r0, =inputFile	@ Print the input file name
	bl	putstring

	ldr	r1, =inputFileCheck
	ldr	r2, =inputFile
	bl	String_Equals
	
	cmp	r0, #1
	beq	adjustBytes

	ldr	r0, =chLF
	bl	putch
	ldr	r0, =chLF
	bl	putch
	
	bal	endAdjust

adjustBytes:

	mov	r0, #-133
	bl	update_data_usage

	ldr	r0, =chLF
	bl	putch
	ldr	r0, =chLF
	bl	putch

endAdjust:
	pop	{r4-r11, pc}



@====== List_addstr function: =======================
@ This function will add the string input to the list
@====================================================

List_addstr:
	push	{r4-r11, lr}

	mov	r4, r0		@ Save the pointer
	mov	r5, r1		@ move the data pointed by r1 into r5
	
	mov	r0, r5		@ moving r5 into r0
	bl	String_Length	@ branch to string length
	mov	r6, r0		@ r6 contains the length now

	mov	r0, r4		@ Add the data to the list and increment the node
	mov	r1, r5
	add	r2, r6, #2	@ The size to add
	bl	List_add

	pop	{r4-r11,pc}

@====== List_add function: =========================
@ This function will add the data to list
@===================================================
List_add:
	push {r4-r11,lr}

	mov	r4, r0		@ Save the pointer
	mov	r5, r2		@ Save the size to add

	mov	r0, r1		@ Construct a node with the given data
	mov	r1, r2
	bl	Node

	ldr	r3, [r4, #4]	@ load r3 with the tail pointer

	cmp	r3, #0
	beq	firstNode	@ If tail ptr == null, branch to first node
	bal	notFirstNode	@ If tail != null, branch to not first node

	firstNode:
	str	r0, [r4]	@ both head and tail point to this
	str	r0, [r4, #4]
	bal	listAdd_end

	notFirstNode:
	str	r0, [r3, #4]	@ Store the pointer to the newly constructed node
				@ pointer is in the 'next' word

	str	r0, [r4, #4]	@ Store the pointer in the nexwly constructed node
				@ in the "tail" word pointer by the list ptr

	listAdd_end:
	mov	r0, r5			@ Incerase data useage global variable
	bl	update_data_usage	@ increase size

	pop	{r4-r11, pc}		


@====== Node constructor function: ================
@ Constructor for the node
@==================================================
Node:
	push	{r4-r11,lr}

	mov	r4, r0		@ save the pointer
	mov	r5, r1

	mov	r0, #8		@ Allocate 8 bytes for the node (4 for string 4 for next ptr)
	bl	malloc		@ the data ptr and 4 for the next ptr
	
	mov	r6, r0		@ r6 will contain the dynamically allocated mem address

	mov	r0, r5		@ allocate the memory for data segment of the size of data
	bl	malloc
	mov	r7, r0		@ memory address for data segment

	mov	r1, r4		@ copy the data given into new
	mov	r2, r0		@ data allocated
	mov	r3, r5
	bl	memcpy

	mov	r8, #0		@ 0 into r8 will be the nodes next ptr

	str	r7, [r6]	@ Store the data ptr in the first word of r5
	str	r8, [r6, #4]	@ the will store null in second word

	mov	r0, #8		@ Increase data usage by 8
	bl	update_data_usage

	ldr	r0, =nodeUse	@ Add 1 to number of nodes
	ldr	r0, [r0]

	add	r0, #1

	ldr	r1, =nodeUse
	str	r0, [r1]

	mov	r0, r6		@ Move the node ptr r6 into r0 and return

	pop	{r4-r11,pc}


@====== memcpy function: =================================
@ This method will copy the character into the destination
@=========================================================
memcpy:
	byteNotZero:
	cmp	r3, #0		@ If the number of bytes to copy is 0 we end
	ble	memEnd

	ldrb	r0, [r1], #1	@ Load the first byte into r0
	strb	r0, [r2], #1	@ Store the byte into r2
	sub	r3, r3, #1	@ decrement r3
	bal	byteNotZero

	memEnd:
	bx	lr

@====== List_inputFromFile function: ======================
@ Creates a list input from file
@=========================================================

@====== Updating data Usage Function: ==============
@ This function will update the data usage count ===
@===================================================
update_data_usage:
	push {r4}
	
	mov	r4, r0

	ldr	r0, =dataUse
	ldr	r0, [r0]

	add	r0, r0, r4

	ldr	r1, =dataUse
	str	r0, [r1]

	pop	{r4}
	bx	lr

@======= data_use function: ===========================
@ Returns the amount of bytes stored in program into r0
@=====================================================
data_use:
	ldr	r0, =dataUse
	ldr	r0, [r0]
	bx	lr


@====== List_inputFromFile function: ===================
@ input the string from file 
@=======================================================
List_inputFromFile:
	push	{r4-r11,lr}

	mov	r4, r0		@ Save the pointer
	mov	r5, r1

	mov	r1, r5		@ open the file as read-only
	mov	r2, #0
	bl	open_file
	mov	r6, r0

	notFileEOF:
	mov	r0, r6		@ Read the next line in from the file
	bl	read_line
	mov	r7, r1
	mov	r8, r2

	cmp	r7, #0		@ Checking if the function returned a null
	beq	endNotFileEOF

	mov	r0, r4		@ Add the line received as a null-terminated string
	mov	r1, r7
	bl	List_addstr

	cmp	r8, #0		@ check if file is at the end
	beq	endNotFileEOF
	bal	notFileEOF

	endNotFileEOF:
	mov	r0, r6		@ Close the file
	bl	close_file

	pop	{r4-r11, pc}


@====== List_remove function: ===================
@ This function will remove the node off the list
@================================================
List_remove:
	push	{r4-r11,lr}
	
	mov	r4, r0		@ saving the pointer
	mov	r5, r1		@ r1 contains the index to remove from

	bl	List_getNode	@ r1 will contain the node to delete and r0 will contain the one before it

	cmp	r0, #0		@ Checking if the previous node is null
	beq	previousNull

	ldr	r2, [r1, #4]	@ If the node before is not null make the previous node point to the new node

	str	r2, [r0, #4]

	bal	endPreviousNotNull

	previousNull:
	ldr	r2, [r1,#4]	@ If the previous node is null, we update the head
	str	r2, [r4]

	endPreviousNotNull:
	ldr	r2, [r4, #4]	@ If current node is not the tail node branch
	cmp	r1, r2
	bne	endCurrentIsTail

	str	r0, [r4,#4]	@ tail will point to the previous node

	endCurrentIsTail:
	mov	r0, r1		@ Destroy the current node
	bl	d_Node

	pop	{r4-r11, pc}


@====== List_getNode function: ======================================
@ This function will get the node to delete and the node before it
@====================================================================
List_getNode:
	push	{r4-r11,lr}

	cmp	r1, #0		@ if r1 = 0 we go to the end
	blt	gnpError

	mov	r2, #0		@ r2 will be used as the pointer to the previous node

	ldr	r3, [r0]	@ r3 will be the pointer to the current node / head ptr

	indexNotZero_CNN:
	cmp	r3, #0		@ If the current node ptr == null we branch
	beq	gnpError
	
	cmp	r1, #0		@ branch to the success if we dinf the node
	ble	gnpFound

	mov	r2, r3		@ Updating the previous with the current pointer
	ldr	r3, [r3, #4]	@ Load the current node ptr with the next ptr

	sub	r1, r1, #1	@ Decreasing the index

	@ Branch back to the start of loop
	bal	indexNotZero_CNN

	gnpError:		@ if the condition fails we return a null pointer
	mov	r0, #0
	mov	r1, #0
	bal	gnpEnd

	gnpFound:		@ in the passing condition we return r2 as previous node and r1 current node to delete
	mov	r0, r2
	mov	r1, r3

	gnpEnd:
	pop	{r4-r11,pc}

@====== d_Node function: ==========================
@ this function will delete the node that was found
@=================================================
d_Node:
	push	{r4, r7, r8, lr}
	
	mov	r4, r0

	ldr	r0, [r4]		@ Freeing the memory pointed to by the nodes data ptr
	bl	String_Length

	add	r0, #2
	mov	r7, r0			@ r7 will contain the length of the string

	ldr	r0, [r4]		@ r0 will contain the address of string
	bl	free			@ frees memory

	mov	r8, #-1	
	mul	r7, r8

	mov	r0, r7
	bl	update_data_usage	@ updates data usage

	mov	r0, r4			@ Freeing the memory used to hold the data ptr and next ptr
	bl	free

	mov	r0, #-8			@ moving -8 to r0 to update the data count
	bl	update_data_usage

	ldr	r0, =nodeUse		@ loads address of node use into r0
	ldr	r0, [r0]

	sub	r0, #1

	ldr	r1, =nodeUse
	str	r0, [r1]
	
	pop	{r4,r7, r8, pc}


@====== d_List function: =============
@ this function will delete the list
@=====================================
d_List:
	push	{r4-r11,lr}

	mov	r4, r0		@ saving the pointer

	mov	r5, #0		@ Using r5 as the previous node pointer
	ldr	r6, [r4]

	currentNotNull:
	cmp	r6, #0		@ Compare the current node with null
	beq	dlEnd

	mov	r5, r6		@ Update previous to current
	ldr	r6, [r6, #4]	@ update current to the node after it

	mov	r0, r5		@ Delete the previous node
	bl	d_Node

	bal	currentNotNull	@ Branch back to loop

	dlEnd:
	pop	{r4-r11, pc}


@====== List_setstr function: ==============================
@ this function will edit the string and set it to a new one
@==========================================================
List_setstr:
	push	{r4-r11,lr}
	
	mov	r4, r0		@ Save the pointer
	mov	r5, r1
	mov	r6, r2

	mov	r0, r6
	bl	String_Length	@ gets the length of the string
	mov	r7, r0

	mov	r0, r4		@ Sets the data in the node
	mov	r1, r5
	mov	r2, r6
	add	r3, r7, #1
	bl	List_set

	pop	{r4-r11,pc}


@====== List_set function: =================================
@ this function will edit the string and set it to a new one
@===========================================================
List_set:
	push	{r4-r11,lr}

	mov	r4, r0
	mov	r5, r1
	mov	r6, r2
	mov	r7, r3

	bl	List_getNode	@ Gets the pair of nodes at the index given

	cmp	r1, #0		@ if the node is null we branch to end
	beq	listSetEnd

	listSetCurrentNotNull:
	mov	r8, r1		@ store the current node in r8
	
	mov	r0, r7		@ Allocate a data segment of the size of the data
	bl	malloc
	mov	r10, r0

	mov	r1, r6		@ we copy the string input by user into the address allocated
	mov	r2, r10
	mov	r3, r7
	bl	memcpy

	ldr	r0, [r8]	@ Freeing the previous data
	bl	free

	str	r10, [r8]	@ storing the new pointer in the data pointer of the current node

	listSetEnd:
	pop	{r4-r11,pc}



@====== List_printMatch function: =================================
@ this function will print the matching strings input by user
@==================================================================
List_printMatch:
	push	{lr}
	
	ldr	r3, =printStringAndNL	@ prints string and nl after each match
	bl	List_foreachMatch

	pop	{pc}


@====== List_foreachMatch function: =================================
@ this function will print the list for each match of string
@===================================================================
List_foreachMatch:
	push	{r4-r11,lr}

	mov	r4, r0		@ save the pointer
	mov	r5, r1
	mov	r7, r2
	mov	r8, r3

	ldr	r10, [r4]	@ we store the r4 and use r6 as current ptr

	mov	r0, #0
	ldr	r1, =indexPrint
	str	r0, [r1]

	lFEMCurrentNotNull:
	cmp	r10, #0		@ compare the current node with null
	beq	lFEMEnd

	bl	update_index
	ldr	r1, [r10]	@ branch to routine that compares the data
	mov	r2, r5		@ r2 will contain the current pointer
	blx	r7		@ implements the subroutine

	cmp	r0, #0		@ Compares r0 to 0
	beq	lFEMSkip	@ if true skip

	lFEMAction:
	ldr	r1, [r10]	@ r1 will contain the pointer to data of the current node and will branch to the routine
	blx	r8
	
	lFEMSkip:
	ldr	r10, [r10, #4]		@ load current ptr with its own next ptr
	bal	lFEMCurrentNotNull

	lFEMEnd:
	pop	{r4-r11,pc}


@====== printStringAndNL function: =================================
@ this function will print each string and a new line after
@===================================================================
printStringAndNL:
	push	{lr}

	mov	r4, r1

	bl	index_num
	ldr	r1, =szIndexPrint
	bl	intasc32

	ldr	r0, =szIndexPrint
	bl	putstring

	ldr	r0, =chB
	bl	putch

	ldr	r0, =chS
	bl	putch

	mov	r0, r4
	bl	putstring	@ Display the string specified
	
	
	ldr	r0, =chLF
	bl	putch

	

	pop	{pc}


@====== List_outputToFile function: =================================
@ this function will output the list to file
@====================================================================
List_outputToFile:
	push	{r4-r11,lr}
	
	mov	r4, r0		@ save the pointer
	mov	r5, r1
	
	mov	r1, r5		@ Open file
	mov	r2, #01101	@ truncate if file does not exist
	bl	open_file
	mov	r6, r0

	ldr	r0, =currentFH	@ r0 will contain the file handle
	str	r6, [r0]

	mov	r0, r4				@ call foreach method, saving each string to the file
	ldr	r1, =List_saveStringAndNL
	bl	List_foreach

	ldr	r0, =currentFH
	ldr	r0, [r0]
	bl	close_file

	pop	{r4-r11,pc}


@====== List_saveStringAndNL function: =================================
@ this function will output each string and NL
@=======================================================================
List_saveStringAndNL:
	push	{r4-r11,lr}

	ldr	r0, =currentFH
	ldr	r0, [r0]	
	bl	write_to_file

	ldr	r0, =currentFH
	ldr	r0, [r0]
	ldr	r1, =chLF		@ print a new line
	mov	r2, #1
	mov	r7, #4
	svc	0

	pop	{r4-r11,pc}


@====== List_foreach function: =========================================
@ this function will output each string into the file
@=======================================================================
List_foreach:
	push	{r4-r11,lr}

	mov	r4, r0		@ Save the pointer
	mov	r5, r1

	ldr	r6, [r4]	@ r6 has the address of current pointer

	LFECurrentNotNull:
	cmp	r6, #0		@ comapring the current node with null
	beq	lforeach_end

	ldr	r1, [r6]	@ r1 will contain the data pointer of the current node
	blx	r5

	ldr	r6, [r6, #4]		@ loading current pointer node with next
	bal	LFECurrentNotNull

	lforeach_end:
	pop	{r4-r11,pc}

update_index:

	ldr	r0, =indexPrint
	ldr	r0, [r0]

	add	r0, r0, #1

	ldr	r1, =indexPrint
	str	r0, [r1]

	bx	lr

	
index_num:
	ldr	r0, =indexPrint
	ldr	r0, [r0]
	bx	lr

	@Program ends here
	.end
