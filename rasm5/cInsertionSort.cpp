#include "rasm5.h"

void cInsertionSort (int a[], int length)
{
	int j, temp;

	for(int i = 1; i < length; i++)
	{
		temp = a[i];
		j = i - 1;

		while(j >= 0 && a[j] > temp)
		{
			a[j + 1] = a[j];
			j = j - 1;
		}

		a[j + 1] = temp;
	}
}
