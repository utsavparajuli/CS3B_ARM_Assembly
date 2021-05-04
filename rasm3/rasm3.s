@ Author:  Utsav Parajuli & Omar Cruz
@ Lab:	   RASM 3
@ Purpose: String functions

	.data

szHeader:	.asciz	"Programmed by:  Utsav Parajuli & Omar Cruz\nLab:		RASM 3\nDate:		04/12/2021\n"

chLF:		.byte	0x0A
szIP1:		.asciz	"Please enter the first string : "
szIP2:		.asciz	"Please enter the second string: "
szIP3:		.asciz	"Please enter the third string : "


szI1:		.skip	20
szI2:		.skip	20
szI3:		.skip	20


szStr1:		.asciz	"s1 = "
szStr2:		.asciz	"s2 = "
szStr3:		.asciz	"s3 = "

szLength1:	.asciz	"1. s1.length() = "
szLength2:	.asciz	"   s2.length() = "
szLength3:	.asciz	"   s3.length() = "
szLen:		.skip	12

szEquals1:	.asciz	"2. String_equals(s1, s3) = "
szEquals2:	.asciz	"3. String_equals(s1, s1) = "
szFalse:	.asciz	"FALSE"
szTrue:		.asciz	"TRUE"

szEqIC1:	.asciz	"4. String_equalsIgnoreCase(s1, s3) = "
szEqIC2:	.asciz	"5. String_equalsIgnoreCase(s1, s2) = "

szCopy1:	.asciz	"6. s4 = String_copy(s1)"
szCopy2:	.asciz	"   s1 = "
szCopy3:	.asciz	"   s4 = "
szDest:		.skip	512	

szSubstr1:	.asciz	"7. String_substring_1(s3,4,14) = "
szQuote:	.asciz	"\""
szDest2:	.skip	512

szSubstr2:	.asciz	"8. String_substring_2(s3,7) = "
szDest3:	.skip	512

szCharAt:	.asciz	"9. String_charAt(s2, 4) = "
szChar:		.word	0
szSQuote:	.word	0x27

szStartW1:	.asciz	"10. String_startsWith_1(s1,11,\"hat.\") = "
szStrW1:	.asciz	"hat."

szStartW2:	.asciz	"11. String_startsWith_2(s1,\"Cat\") = "
szStrW2:	.asciz	"Cat"

szEndW:		.asciz	"12. String_endsWith(s1,\"in the hat.\") = "
szEW:		.asciz	"in the hat."

szIndex:	.skip	12
szIndexO1:	.asciz	"13. String_indexOf_1(s2, 'g') = "

szIndexO2:	.asciz	"14. String_indexOf_2(s2, 'g', 9) = "

szIndexO3:	.asciz	"15. String_indexOf_3(s2, \"eggs\") = "
szIO3Search:	.asciz	"eggs"

szLastIO1:	.asciz	"16. String_lastIndexOf_1(s2, 'g') = "

szLastIO2:	.asciz	"17. String_lastIndexOf_2(s2, 'g', 6) = "

szLastIO3:	.asciz	"18. String_lastIndexOf_3(s2, \"egg\") = "
szLIO3Search:	.asciz	"egg"

szReplace:	.asciz	"19. String_replace(s1, 'a', 'o') = "

szLowerCase:	.asciz	"20. String_toLowerCase(s1) = "

szUpperCase:	.asciz	"21. String_toUpperCase(s1) = "

szConcat1:	.asciz	"22. String_concat(s1, \" \") = "
szConcat2:	.asciz	"    String_concat(s1, s2) = "
szConcatI2:	.asciz	"\" \""

	.text

	.global _start		@ Provide staring address for program linker

_start:

	@===========HEADER==============
	@===============================
	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =szHeader	@ Loads address of szHeader onto r0
	bl	putstring	@ branch to putstring
	
	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	@===========INPUT================
	@================================
	@Input1:
	ldr	r0, =szIP1	@ Load address of szIP1 into r0
	bl	putstring	@ branch to putstring

	ldr	r0, =szI1	@ Load address of szI1 into r0
	mov	r1, #21		@ Max number of input allowed +1
	
	bl	getstring	@ branches to getstring

	@Input2:
	ldr	r0, =szIP2	@ Load address of szIP2 into r0
	bl	putstring	@ branch to putstring

	ldr	r0, =szI2	@ Load address of szI2 into r0
	mov	r1, #21		@ Max number of input allowed +1
	
	bl	getstring	@ branches to getstring

	@Input3:
	ldr	r0, =szIP3	@ Load address of szIP3 into r0
	bl	putstring	@ branch to putstring

	ldr	r0, =szI3	@ Load address of szI3 into r0
	mov	r1, #21		@ Max number of input allowed +1
	
	bl	getstring	@ branches to getstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch


	@==========OUTPUTTING STRINGS======
	@=================================
	@First:
	ldr	r0, =szStr1	@ Loads address of szStr1 into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =szI1	@ Loads address of szI1 into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch
	
	@Second:
	ldr	r0, =szStr2	@ Loads address of szStr2 into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =szI2	@ Loads address of szI2 into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	@Third:
	ldr	r0, =szStr3	@ Loads address of szStr3 into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =szI3	@ Loads address of szI3 into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch


	@==========TEST 1 (LENGTH)==========
	@===================================

	ldr	r0, =szLength1	@ Loads address of szLength1 into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =szI1	@ Load address of szI1 into r0
	bl	String_Length	@ branches to String_Length

	ldr	r1, =szLen	@ Load into r1 address of szLen
	bl	intasc32	@ branches to intasc32

	ldr	r0, =szLen	@ Load into r0 address of szLen
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	
	@==========TEST 2 (LENGTH)==========
	@===================================

	ldr	r0, =szLength2	@ Loads address of szLength2 into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =szI2	@ Load address of szI2 into r0
	bl	String_Length	@ branches to String_Length

	ldr	r1, =szLen	@ Load into r1 address of szLen
	bl	intasc32	@ branches to intasc32

	ldr	r0, =szLen	@ Load into r0 address of szLen
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	@==========TEST 3 (LENGTH)==========
	@===================================

	ldr	r0, =szLength3	@ Loads address of szLength3 into r0
	bl	putstring	@ branches to putstring

	ldr	r0, =szI3	@ Load address of szI3 into r0
	bl	String_Length	@ branches to String_Length

	ldr	r1, =szLen	@ Load into r1 address of szLen
	bl	intasc32	@ branches to intasc32

	ldr	r0, =szLen	@ Load into r0 address of szLen
	bl	putstring	@ branches to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch	
	
	@=========TEST 1 (EQUALS)=============
	@=====================================
	ldr	r0, =szEquals1	@ Load address of szEquals1 into r0
	bl	putstring	@ branch to putstring
	
	ldr	r1, =szI1	@ Load address of szI1 into r1
	ldr	r2, =szI3	@ Load address of szI3 into r2
	bl	String_Equals	@ branch to string equals
	bl	Print_Bool	@ branch to print bool which will print the bool value

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	@=========TEST 2 (EQUALS)=============
	@=====================================
	ldr	r0, =szEquals2	@ Load address of szEquals2 into r0
	bl	putstring	@ branch to putstring
	
	ldr	r1, =szI1	@ Load address of szI1 into r1
	ldr	r2, =szI1	@ Load address of szI1 into r2
	bl	String_Equals	@ branch to string equals
	bl	Print_Bool	@ branch to print bool which will print the bool value

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	@=========TEST 1 (EQUALS IGNORE CASE)=============
	@=================================================
	ldr	r0, =szEqIC1	@ Load address of szEqIC1 into r0
	bl	putstring	@ branch to putstring
	
	ldr	r1, =szI1	@ Load address of szI1 into r1
	ldr	r2, =szI3	@ Load address of szI3 into r2

	bl	String_EqualsIgnoreCase		@ branch to string equals ignore case

	bl	Print_Bool	@ branch to print bool which will print the bool value

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	@=========TEST 2 (EQUALS IGNORE CASE)=============
	@=================================================
	ldr	r0, =szEqIC2	@ Load address of szEqIC2 into r0
	bl	putstring	@ branch to putstring
	
	ldr	r1, =szI1	@ Load address of szI1 into r1
	ldr	r2, =szI2	@ Load address of szI1 into r2

	bl	String_EqualsIgnoreCase		@ branch to string equals

	bl	Print_Bool	@ branch to print bool which will print the bool value

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch


	@===========TEST 1 (STRING COPY)====================
	@===================================================
	ldr	r0, =szCopy1	@ Load into r0 the address of szCopy1
	bl	putstring	@ branch to putstring
	
	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =szCopy2	@ Load into r0 the address of szCopy2
	bl	putstring	@ branch to putstring
	
	ldr	r0, =szI1	@ Load into r0 the address of szI1
	bl	putstring	@ branch to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =szCopy3	@ Load into r0 the address of szCopy3
	bl	putstring	@ branch to putstring

@	ldr	r0, =szI1	@ Load into r0 the address of szI1
	ldr	r1, =szI1	@ Load into r1 the address to for the string to be copied to
	bl	String_Copy	@ branch to String_Copy

@	ldr	r0, =szDest	@ Load into r0 the newly copied string
	bl	putstring	@ branch to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	
	@=========== SUBSTRING 1=============================
	@====================================================
	ldr	r0, =szSubstr1	@ Load address of szSubstr1 into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szQuote	@ Load into r0 address of szQuote
	bl	putstring	@ branch to putstring

	ldr	r0, =szI3	@ load into r0 address of szI3
	ldr	r1, =szDest2	@ load into r1 address of szDest2
	mov	r2, #4		@ move the start index into r2
	mov	r3, #14		@ move the end index into r3

	bl	String_Substring_1	@ branch to string substring 1
	
	ldr	r0, =szDest2	@ load into r0 address of szDest2
	bl	putstring	@ branch to putstring
	
	ldr	r0, =szQuote	@ Load into r0 address of szQuote
	bl	putstring	@ branch to putstring
	
	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	@=========== SUBSTRING 2=============================
	@====================================================
	ldr	r0, =szSubstr2	@ Load address of szSubstr2 into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szQuote	@ Load into r0 address of szQuote
	bl	putstring	@ branch to putstring

	ldr	r0, =szI3	@ load into r0 address of szI3
	ldr	r1, =szDest3	@ load into r1 address of szDest3
	mov	r2, #7		@ move the start index into r2

	bl	String_Substring_2	@ branch to string substring 2
	
	ldr	r0, =szDest3	@ load into r0 address of szDest3
	bl	putstring	@ branch to putstring
	
	ldr	r0, =szQuote	@ Load into r0 address of szQuote
	bl	putstring	@ branch to putstring
	
	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	@================= CHAR AT ==========================
	@====================================================
	ldr	r0, =szCharAt	@ Load address of szCharAt into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szSQuote	@ Load into r0 address of szSQuote
	bl	putch		@ branch to putch

	ldr	r0, =szI2	@ load into r0 address of szI2
	mov	r1, #4		@ move the char at index into r1

	bl	String_CharAt	@ branch to string character at
	
	ldr	r1, =szChar	@ load into r1 the address of szChar
	str	r0, [r1]	@ store the character from the specified index into r1[szChar]

	ldr	r0, =szChar	@ load into r0 the address of szChar
	bl	putch		@ branch to putch
	
	ldr	r0, =szSQuote	@ Load into r0 address of szSQuote
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	@================= STARTS WITH 1 ==========================
	@====================================================
	ldr	r0, =szStartW1	@ Load address of szStartW1 into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szI1	@ load into r0 address of szI1
	mov	r1, #11		@ move the char start index into r1
	ldr	r2, =szStrW1	@ load into r2 the string to look for

	bl	String_StartsWith_1	@ branch to string character at

	bl	Print_Bool	@ Print the boolean value

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch


	@================= STARTS WITH 2 ==========================
	@====================================================
	ldr	r0, =szStartW2	@ Load address of szStartW2 into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szI1	@ load into r0 address of szI1
	ldr	r1, =szStrW2	@ load into r1 the string to look for

	bl	String_StartsWith_2	@ branch to string character at

	bl	Print_Bool	@ Print the boolean value

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	@================= ENDS WITH ==========================
	@====================================================
	ldr	r0, =szEndW	@ Load address of szEndW into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szI1	@ load into r0 address of szI1
	ldr	r1, =szEW	@ load into r1 the string to look for

	bl	String_EndsWith	@ branch to string character at

	bl	Print_Bool	@ Print the boolean value

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	@================= STRING INDEX OF 1 ==========================
	@==============================================================
	ldr	r0, =szIndexO1	@ Load address of szIndexO1 into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szI2	@ load into r0 address of szI2
	mov	r1, #'g'	@ load the character to be searched for

	bl	string_index_of_1	@ branch to string_index_of_1

	ldr	r1, =szIndex		@ r1 contains the address of szIndex
	bl	intasc32		@ convert the int value in r0 to ascii

	mov	r0, r1			@ move the contents of r1 into r0
	bl	putstring		@ branch to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch


	@================= STRING INDEX OF 2 ==========================
	@==============================================================
	ldr	r0, =szIndexO2	@ Load address of szIndexO2 into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szI2	@ load into r0 address of szI2
	mov	r1, #'g'	@ load the character to be searched for
	mov	r2, #9		@ move the index to start searching from to r2

	bl	string_index_of_2	@ branch to string_index_of_2

	ldr	r1, =szIndex		@ r1 contains the address of szIndex
	bl	intasc32		@ convert the int value in r0 to ascii

	mov	r0, r1			@ move the contents of r1 into r0
	bl	putstring		@ branch to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch
	

	@================= STRING INDEX OF 3 ==========================
	@==============================================================
	ldr	r0, =szIndexO3	@ Load address of szIndexO3 into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szI2		@ load into r0 address of szI2
	ldr	r1, =szIO3Search	@ load the string to be searched for

	bl	string_index_of_3	@ branch to string_index_of_3

	ldr	r1, =szIndex		@ r1 contains the address of szIndex
	bl	intasc32		@ convert the int value in r0 to ascii

	mov	r0, r1			@ move the contents of r1 into r0
	bl	putstring		@ branch to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch


	@================= STRING LAST INDEX OF 1 =====================
	@==============================================================
	ldr	r0, =szLastIO1	@ Load address of szLastIO1 into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szI2	@ load into r0 address of szI2
	mov	r1, #'g'	@ load the character to be searched for

	bl	string_lastIndex_of_1	@ branch to string_lastIndex_of_1

	ldr	r1, =szIndex		@ r1 contains the address of szIndex
	bl	intasc32		@ convert the int value in r0 to ascii

	mov	r0, r1			@ move the contents of r1 into r0
	bl	putstring		@ branch to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch


	@================= STRING LAST INDEX OF 2 =====================
	@==============================================================
	ldr	r0, =szLastIO2	@ Load address of szLastIO2 into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szI2	@ load into r0 address of szI2
	mov	r1, #'g'	@ load the character to be searched for
	mov	r2, #6		@ move the index to start searching from to r2

	bl	string_lastIndex_of_2	@ branch to string_lastIndex_of_2

	ldr	r1, =szIndex		@ r1 contains the address of szIndex
	bl	intasc32		@ convert the int value in r0 to ascii

	mov	r0, r1			@ move the contents of r1 into r0
	bl	putstring		@ branch to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch
	

	@================= STRING LAST INDEX OF 3 =====================
	@==============================================================
	ldr	r0, =szLastIO3	@ Load address of szLastIO3 into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szI2		@ load into r0 address of szI2
	ldr	r1, =szLIO3Search	@ load the string to be searched for

	bl	string_lastIndex_of_3	@ branch to string_lastIndex_of_3

	ldr	r1, =szIndex		@ r1 contains the address of szIndex
	bl	intasc32		@ convert the int value in r0 to ascii

	mov	r0, r1			@ move the contents of r1 into r0
	bl	putstring		@ branch to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch


	@================= STRING REPLACE  =====================
	@=======================================================
	ldr	r0, =szReplace	@ Load address of szReplace into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szQuote	@ Load into r0 address of szQuote
	bl	putstring	@ branch to putstring

	ldr	r0, =szI1	@ Loads address of first string into r0
	mov	r1, #'a'	@ Character to be removed
	mov	r2, #'o'	@ Character to be replaced with

	bl	string_replace	@ branches to string replace

	bl	putstring	@ prints the new item on screen

	ldr	r0, =szQuote	@ Load into r0 address of szQuote
	bl	putstring	@ branch to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch


	@================= STRING TO LOWER CASE =======================
	@==============================================================
	ldr	r0, =szLowerCase	@ Load address of szLowerCase into r0
	bl	putstring		@ branch and link to putstring

	ldr	r0, =szQuote		@ Load into r0 address of szQuote
	bl	putstring		@ branch to putstring

	ldr	r0, =szI1		@ Load into r0 address of szI1
	bl	string_toLowerCase	@ branch to lowercase

	bl	putstring		@ branches to putstring

	ldr	r0, =szQuote		@ Load into r0 address of szQuote
	bl	putstring		@ branch to putstring

	ldr	r0, =chLF		@ Load address of chLF into r0
	bl	putch			@ branch to putch

	ldr	r0, =chLF		@ Load address of chLF into r0
	bl	putch			@ branch to putch


	@================= STRING TO UPPER CASE =======================
	@==============================================================
	ldr	r0, =szUpperCase	@ Load address of szUpperCase into r0
	bl	putstring		@ branch and link to putstring

	ldr	r0, =szQuote		@ Load into r0 address of szQuote
	bl	putstring		@ branch to putstring

	ldr	r0, =szI1		@ Load into r0 address of szI1
	bl	string_toUpperCase	@ branch to uppercase

	bl	putstring		@ branches to putstring

	ldr	r0, =szQuote		@ Load into r0 address of szQuote
	bl	putstring		@ branch to putstring

	ldr	r0, =chLF		@ Load address of chLF into r0
	bl	putch			@ branch to putch

	ldr	r0, =chLF		@ Load address of chLF into r0
	bl	putch			@ branch to putch


	@================= STRING CONCAT  =======================
	@========================================================
	ldr	r0, =szConcat1	@ Load address of szConcat1 into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szQuote	@ Load into r0 address of szQuote
	bl	putstring	@ branch to putstring
	
	ldr	r0, =szI1	@ Loads address of szI1 into r0
	ldr	r1, =szConcatI2 @ Loads address of 2nd string to be concatenated

	bl	string_concat	@ branches to string concat
	
	bl	putstring	@ prints to screen
	
	ldr	r0, =szQuote	@ Load into r0 address of szQuote
	bl	putstring	@ branch to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =szConcat2	@ Load address of szConcat2 into r0
	bl	putstring	@ branch and link to putstring

	ldr	r0, =szQuote	@ Load into r0 address of szQuote
	bl	putstring	@ branch to putstring

	ldr	r0, =szI1	@ Loads address of szI1 into r0
	ldr	r1, =szI2	@ Loads address of szI2 to be concatenated

	bl	string_concat	@ branches to string concat
	
	bl	putstring	@ prints to screen
	
	ldr	r0, =szQuote	@ Load into r0 address of szQuote
	bl	putstring	@ branch to putstring

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	ldr	r0, =chLF	@ Load address of chLF into r0
	bl	putch		@ branch to putch

	mov	r0, #0
	mov	r7, #1
	svc	0	

	
Print_Bool:
	push	{r1,r4-r11, lr}

	cmp	r0, #1		@ compares r0 to 1
	beq	true		@ branches to true

	cmp	r0, #0		@ compares r0 to 0
	beq	false		@ branches to false

true:
	ldr	r0, =szTrue	@ load szTrue
	bl	putstring	@ branches to putstring
	
	b	boolEnd

false:
	ldr	r0, =szFalse	@ load szFalse
	bl	putstring	@ branches to putstring
	
	b	boolEnd

boolEnd:
	pop	{r1, r4-r11, lr}
	bx	lr
	.end		
