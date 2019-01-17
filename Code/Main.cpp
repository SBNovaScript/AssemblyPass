// Steven Baumann
// 12/12/18

#include <iostream>
#include <string>
using namespace std;

extern "C" char asmCheck(char *chArray, int len); // External asm function for checking the password
string getInput();
int checkPass(string pass);
void showCriteria();

int main() {
	char result = '~';
	while (result == '~') { // While there is no input, or the input resulted in an error
		showCriteria();
		string userPass = getInput();

		//converting string to char array

		char* chArray = new char[userPass.length() + 1];
		for (int i = 0; i < userPass.length(); i++)
		{
			chArray[i] = userPass[i];
		}

		// Optional, view memory adresses
		// cout << static_cast<void*>(&chArray[0]) << " " << chArray[0] << endl;
		// cout << static_cast<void*>(&chArray[1]) << " " << chArray[1] << endl;

		result = asmCheck(&chArray[0], userPass.length()); // Get the result of the password checker

		if (result == '~') {
			cout << endl << "One of the rules wasn't followed; please try again." << endl << endl;
		}
		else {
			cout << "Password accepted!" << endl;
		}
	}

}

void showCriteria() {
	cout << "Hello! Please enter your password with the following constraints:" << endl <<
		"1. Has At least 9 charicters" << endl <<
		"2. Has at least 1 number" << endl <<
		"3. Has at least 1 uppercase charicter" << endl;
}

string getInput() {
	string pass;
	cin >> pass;
	return pass;
}

int checkPass(string pass) { // C++ implementation
	
	return 1;

	/*if (pass.length() < 9) {
		return 0;
	}

	bool checkCapital = 0;

	for (char& c : pass) {
		if (isupper(c)) {
			checkCapital = 1;
		}
	}

	if (checkCapital) {
		return 1;
	}
	else {
		return 0;
	}*/
	
}