//Author: Utsav Parajuli

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int String_Length(char *chArr);		//creates an external function

int main()
{
	char	*stringInput;			//pointer to the input buffer
	size_t	bufferSize = 32;		//max number of chars allowed in buffer
	size_t	charCount;			//number of characters

	//input buffer
	stringInput = (char *)malloc(bufferSize * sizeof(char));

	printf("Please enter a string: ");
	getline(&stringInput, &bufferSize, stdin);	//&inputBuffer = address where the string will be stored


	int length = String_Length(stringInput);

	//print the size of string
	printf("\nASM length= %d \n", length);

	int length2 = strlen(stringInput);

	//print the size of string
	printf("\nC length= %d \n", length);


	return 0;
}
