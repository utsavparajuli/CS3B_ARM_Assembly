#ifndef RASM5_H_
#define RASM5_H_

//defining external .s files for bubble sort and insertion sort
extern "C" void aBubbleSort(int a[], int length);
extern "C" void aInsertionSort(int a[], int length);

#include <iostream>
#include <iomanip>
#include <fstream>
#include <ctime>

using namespace std;

//function prototype for bubblesort
void cBubbleSort(int a[], int length);

//function prototye for insertion sort
void cInsertionSort(int a[], int length);

#endif
