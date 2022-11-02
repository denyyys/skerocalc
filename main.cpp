#include <iostream>
#include <string>

using namespace std;

class plug {
	public:
		string name;
		int price;
		float tax;
};

void calc(int choice);

int main()
{

	int choice;
	do {
		system("cls");
		cout << "SkeroCalculator" << endl;
		cout << "-------------------" << endl;

		cout << "Vyber pluga" << endl;
		cout << "1. samik" << endl;
		cout << "2. weby" << endl;
		cout << "3. peta" << endl;
		cout << "4. dominik" << endl;
		cout << "volba: ";
		cin >> choice;

		switch (choice) {
		case 1: calc(1);
			break;
		case 2: calc(2);
			break;
		case 3: calc(3);
			break;
		case 4: calc(4);
			break;
		case 51: calc(51);
			break;
		}
	} while (choice != 0);

	return 0;
}

void calc(int choice)
{
	plug samik;
	samik.name = "Samik";
	samik.price = 200;
	samik.tax = 0.75;

	plug weby;
	weby.name = "Weby";
	weby.price = 200;
	weby.tax = 0.9;

	plug peta;
	peta.name = "Peta";
	peta.price = 200;
	peta.tax = 1.0;

	plug dominik;
	dominik.name = "Dominik";
	dominik.price = 100;
	dominik.tax = 1.3;

	float import;

	if (choice == 1) {
		system("cls");
		cout << "Plug: " << samik.name << endl;
		cout << "Cena: " << samik.price << endl;
		cout << "Dan: " << samik.tax << endl;
		cout << "Naber skera (format N.N): ";
		cin >> import;
		cout  << endl << "Celkem skera: " << import * samik.tax << "g" << endl;
		cout << "___________________________________________" << endl;
		system("pause");
	}
	else if (choice == 2) {
		system("cls");
		cout << "Plug: " << weby.name << endl;
		cout << "Cena: " << weby.price << endl;
		cout << "Dan: " << weby.tax << endl;
		cout << "Naber skera (format N.N): ";
		cin >> import;
		cout << endl << "Celkem skera: " << import * weby.tax << "g" << endl;
		system("pause");
	}
	else if (choice == 3) {
		system("cls");
		cout << "Plug: " << peta.name << endl;
		cout << "Cena: " << peta.price << endl;
		cout << "Dan: " << peta.tax << endl;
		cout << endl << "Naber skera (format N.N): ";
		cin >> import;
		cout << "Celkem skera: " << import * peta.tax << "g" << endl;
		system("pause");
	}
	else if (choice == 4) {
		system("cls");
		cout << "Plug: " << dominik.name << endl;
		cout << "Cena: " << dominik.price << endl;
		cout << "Dan " << dominik.tax << endl;
		cout << endl << "Naber skera (format N.N): ";
		cin >> import;
		cout << "Celkem skera: " << import * dominik.tax << "g" << endl;
		system("pause");
	}
	else if (choice == 51) {
		system("cls");
		cout << "Plug: " << "Smack One" << endl;
		cout << "Cena: " << "neres" << endl;
		cout << "Dan: " << "0" << endl;
		cout << "Skero prideleno: " << "infinite" << endl;
		system("pause");
	}else {
		cout << "Zadana neplatna volba!" << endl;
	}
}