//Author: Utsav Parajuli
//RASM5

#include "rasm5.h"

int main()
{
	//constants
	const int AR_SIZE = 200000;

	//variables
	fstream fin;

	ofstream fout;

	int	index	= 0;
	int 	choice	= 0;
	int	count	= 0;
	int	i	= 0;

	double	cBubble    = 0;
	double	aBubble    = 0;
	double	cInsertion = 0;
	double	aInsertion = 0;

	int	intArr1[AR_SIZE];
	int	intArr2[AR_SIZE];
	int	intArr3[AR_SIZE];
	int	intArr4[AR_SIZE];

	clock_t start;
	clock_t end;


	//run the menu
	do
	{
		system("clear");

		//printing the menu
		cout << "\t\tRASM5 C++ vs. Assembly\n";
		cout << "File Element Count: " << count << endl;
		cout << "---------------------------------------------------------\n";
		cout << "C++ bubbleSort Time: " << cBubble << " secs\n";
		cout << "Assembly bubbleSort Time: " << aBubble << " secs\n\n";
		cout << "C++ insertionSort Time: " << cInsertion << " secs\n";
		cout << "Assembly insertionSort Time: " << aInsertion << " secs\n";
		cout << "---------------------------------------------------------\n";

		cout << "<1> Load input file (integers)\n";
		cout << "<2> Sort using C++ bubbleSort algorithm\n";
		cout << "<3> Sort using Assembly bubbleSort algorithm\n";
		cout << "<4> Sort using C++ insertionSort algorithm\n";
		cout << "<5> Sort using Assembly insertionSort algorithm\n";
		cout << "<6> Quit\n\n";

		//get option
		cout << "Enter an option: ";
		cin  >> choice;

		//checking if we have to read in from file
		if(choice == 1)
		{
			fin.open("input.txt");

			while(i < 200000)
			{
				fin >> intArr1[index];

				intArr2[index] = intArr1[index];
				intArr3[index] = intArr1[index];
				intArr4[index] = intArr1[index];

				index++;
				count++;
				i++;
			}

			fin.close();

			cout << "\nINPUT FILE WAS SUCCESSFULLY LOADED!!\n";
		}

		//if not load we check for other cases
		else
		{
			switch(choice)
			{
				case 2:
					fout.open("cB_output.txt");

					//starting the timer for sorting
					start = clock();
					cBubbleSort(intArr1, AR_SIZE);
					end = clock();
					cBubble = (end - start) / 1000000.0;

					//outputting to file
					for(int i = 0; i < AR_SIZE; i++)
					{
						fout << intArr1[i] << endl;
					}

					fout.close();
					break;

				case 3:
					fout.open("aB_output.txt");

					//starting the timer for sorting
					start = clock();
					aBubbleSort(intArr2, AR_SIZE);
					end = clock();
					aBubble = (end - start) / 1000000.0;

					//outputting to file
					for(int i = 0; i < AR_SIZE; i++)
					{
						fout << intArr2[i] << endl;
					}

					fout.close();

					break;
					
				case 4:
					fout.open("cI_output.txt");

					//starting the timer for sorting
					start = clock();
					cInsertionSort(intArr3, AR_SIZE);
					end = clock();
					cInsertion = (end - start) / 1000000.0;

					//outputting to file
					for(int i = 0; i < AR_SIZE; i++)
					{
						fout << intArr3[i] << endl;
					}

					fout.close();
					break;

				case 5:
					fout.open("aI_output.txt");

					//starting the timer for sorting
					start = clock();
					aInsertionSort(intArr4, AR_SIZE);
					end = clock();
					aInsertion = (end - start) / 1000000.0;

					//outputting to file
					for(int i = 0; i < AR_SIZE; i++)
					{
						fout << intArr4[i] << endl;
					}

					fout.close();
					break;	 
			}
		}

		//checking if the choice was not 6
		if(choice != 6)
		{
			cout << "Press any key to continue\n";
			cin.ignore().get();
		}


	}while(choice !=6);	//run the loop again

	return 0;
}
