#pragma once
#include <string>

namespace $safeprojectname$ {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	
	public ref class MyForm : public System::Windows::Forms::Form
	{
	public:
		MyForm(void)
		{
			InitializeComponent();
			//
			//TODO: Add the constructor code here
			//
		}

	protected:
		
		~MyForm()
		{
			if (components)
			{
				delete components;
			}
		}
	private: System::Windows::Forms::Label^ label1;
	private: System::Windows::Forms::ComboBox^ plug_choice;
	private: System::Windows::Forms::Label^ label2;
	private: System::Windows::Forms::Label^ label3;
	private: System::Windows::Forms::TextBox^ amount;
	private: System::Windows::Forms::TextBox^ real_amount;

	private: System::Windows::Forms::Label^ label4;
	private: System::Windows::Forms::Label^ label5;
	private: System::Windows::Forms::Button^ calculate;
	private: System::Windows::Forms::Button^ about;




	protected:

	private:
		
		System::ComponentModel::Container ^components;

#pragma region Windows Form Designer generated code
		
		void InitializeComponent(void)
		{
			this->label1 = (gcnew System::Windows::Forms::Label());
			this->plug_choice = (gcnew System::Windows::Forms::ComboBox());
			this->label2 = (gcnew System::Windows::Forms::Label());
			this->label3 = (gcnew System::Windows::Forms::Label());
			this->amount = (gcnew System::Windows::Forms::TextBox());
			this->real_amount = (gcnew System::Windows::Forms::TextBox());
			this->label4 = (gcnew System::Windows::Forms::Label());
			this->label5 = (gcnew System::Windows::Forms::Label());
			this->calculate = (gcnew System::Windows::Forms::Button());
			this->about = (gcnew System::Windows::Forms::Button());
			this->SuspendLayout();
			// 
			// label1
			// 
			this->label1->AutoSize = true;
			this->label1->Font = (gcnew System::Drawing::Font(L"Calibri", 15.75F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->label1->Location = System::Drawing::Point(158, 93);
			this->label1->Name = L"label1";
			this->label1->Size = System::Drawing::Size(58, 26);
			this->label1->TabIndex = 0;
			this->label1->Text = L"PLUG";
			this->label1->Click += gcnew System::EventHandler(this, &MyForm::label1_Click);
			// 
			// plug_choice
			// 
			this->plug_choice->DropDownStyle = System::Windows::Forms::ComboBoxStyle::DropDownList;
			this->plug_choice->Font = (gcnew System::Drawing::Font(L"Calibri", 9.75F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(238)));
			this->plug_choice->FormattingEnabled = true;
			this->plug_choice->Items->AddRange(gcnew cli::array< System::Object^  >(5) { L"weby", L"samik", L"dominik", L"peta", L"vietnamci" });
			this->plug_choice->Location = System::Drawing::Point(127, 122);
			this->plug_choice->Name = L"plug_choice";
			this->plug_choice->Size = System::Drawing::Size(121, 23);
			this->plug_choice->TabIndex = 1;
			this->plug_choice->SelectedIndexChanged += gcnew System::EventHandler(this, &MyForm::plug_choice_SelectedIndexChanged);
			// 
			// label2
			// 
			this->label2->AutoSize = true;
			this->label2->Font = (gcnew System::Drawing::Font(L"Unispace", 24, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(238)));
			this->label2->Location = System::Drawing::Point(95, 20);
			this->label2->Name = L"label2";
			this->label2->Size = System::Drawing::Size(197, 39);
			this->label2->TabIndex = 2;
			this->label2->Text = L"SkeroCalc";
			this->label2->Click += gcnew System::EventHandler(this, &MyForm::label2_Click);
			// 
			// label3
			// 
			this->label3->AutoSize = true;
			this->label3->Font = (gcnew System::Drawing::Font(L"Calibri", 15.75F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(238)));
			this->label3->Location = System::Drawing::Point(144, 184);
			this->label3->Name = L"label3";
			this->label3->Size = System::Drawing::Size(95, 26);
			this->label3->TabIndex = 3;
			this->label3->Text = L"AMOUNT";
			// 
			// amount
			// 
			this->amount->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 12, System::Drawing::FontStyle::Regular, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(238)));
			this->amount->Location = System::Drawing::Point(124, 215);
			this->amount->Name = L"amount";
			this->amount->Size = System::Drawing::Size(133, 26);
			this->amount->TabIndex = 4;
			this->amount->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->amount->TextChanged += gcnew System::EventHandler(this, &MyForm::amount_TextChanged);
			// 
			// real_amount
			// 
			this->real_amount->BackColor = System::Drawing::SystemColors::ControlLight;
			this->real_amount->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 18, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(238)));
			this->real_amount->Location = System::Drawing::Point(142, 378);
			this->real_amount->Name = L"real_amount";
			this->real_amount->ReadOnly = true;
			this->real_amount->Size = System::Drawing::Size(91, 35);
			this->real_amount->TabIndex = 5;
			this->real_amount->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			// 
			// label4
			// 
			this->label4->AutoSize = true;
			this->label4->Font = (gcnew System::Drawing::Font(L"Calibri", 15.75F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(238)));
			this->label4->Location = System::Drawing::Point(120, 351);
			this->label4->Name = L"label4";
			this->label4->Size = System::Drawing::Size(144, 26);
			this->label4->TabIndex = 6;
			this->label4->Text = L"REAL AMOUNT";
			// 
			// label5
			// 
			this->label5->AutoSize = true;
			this->label5->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 15.75F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(238)));
			this->label5->Location = System::Drawing::Point(232, 388);
			this->label5->Name = L"label5";
			this->label5->Size = System::Drawing::Size(25, 25);
			this->label5->TabIndex = 7;
			this->label5->Text = L"g";
			// 
			// calculate
			// 
			this->calculate->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 12, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(238)));
			this->calculate->Location = System::Drawing::Point(128, 259);
			this->calculate->Name = L"calculate";
			this->calculate->Size = System::Drawing::Size(124, 42);
			this->calculate->TabIndex = 8;
			this->calculate->Text = L"CALCULATE";
			this->calculate->UseVisualStyleBackColor = true;
			this->calculate->Click += gcnew System::EventHandler(this, &MyForm::calculate_Click);
			// 
			// about
			// 
			this->about->Font = (gcnew System::Drawing::Font(L"Microsoft Sans Serif", 12, System::Drawing::FontStyle::Regular, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(238)));
			this->about->Location = System::Drawing::Point(288, 433);
			this->about->Name = L"about";
			this->about->Size = System::Drawing::Size(96, 27);
			this->about->TabIndex = 9;
			this->about->Text = L"About";
			this->about->UseVisualStyleBackColor = true;
			this->about->Click += gcnew System::EventHandler(this, &MyForm::about_Click);
			// 
			// MyForm
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->BackColor = System::Drawing::Color::MediumSeaGreen;
			this->ClientSize = System::Drawing::Size(384, 461);
			this->Controls->Add(this->about);
			this->Controls->Add(this->calculate);
			this->Controls->Add(this->label5);
			this->Controls->Add(this->label4);
			this->Controls->Add(this->real_amount);
			this->Controls->Add(this->amount);
			this->Controls->Add(this->label3);
			this->Controls->Add(this->label2);
			this->Controls->Add(this->plug_choice);
			this->Controls->Add(this->label1);
			this->DoubleBuffered = true;
			this->MaximizeBox = false;
			this->MaximumSize = System::Drawing::Size(400, 500);
			this->MinimumSize = System::Drawing::Size(400, 500);
			this->Name = L"MyForm";
			this->ShowIcon = false;
			this->StartPosition = System::Windows::Forms::FormStartPosition::CenterScreen;
			this->Text = L"SkeroCalc 2.0";
			this->Load += gcnew System::EventHandler(this, &MyForm::MyForm_Load);
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion
		double skera, vysledek;
		double cena, tax;
		String^ plug;
		int counter = 0;

	private: System::Void MyForm_Load(System::Object^ sender, System::EventArgs^ e) {
	}
	private: System::Void label1_Click(System::Object^ sender, System::EventArgs^ e) {
	}
	private: System::Void label2_Click(System::Object^ sender, System::EventArgs^ e) {
	}
private: System::Void amount_TextChanged(System::Object^ sender, System::EventArgs^ e) {
}
private: System::Void plug_choice_SelectedIndexChanged(System::Object^ sender, System::EventArgs^ e) {
	plug = plug_choice->Text;
	String^ blank = "";
	real_amount->Text = blank;
	if (plug != "smack") {
		calculate->Text = "CALCULATE";
	}
	if (plug == "vietnamci") {
		MessageBox::Show("budou to mordy skera tak ara");
	}
}
private: System::Void calculate_Click(System::Object^ sender, System::EventArgs^ e) {
	if (amount->Text->Equals("") || plug_choice->Text->Equals("")) {
		MessageBox::Show("missing value");
		amount->Text = "0";
	}
	else {
		
		skera = Convert::ToDouble(amount->Text);
		plug = plug_choice->Text;

		if (plug == "weby") {
			tax = 0.9;
			vysledek = skera * tax;
			real_amount->Text = Convert::ToString(vysledek);
		}
		if (plug == "samik") {
			tax = 0.75;
			vysledek = skera * tax;
			real_amount->Text = Convert::ToString(vysledek);
		}
		if (plug == "dominik") {
			tax = 1.3;
			vysledek = skera * tax;
			real_amount->Text = Convert::ToString(vysledek);
		}
		if (plug == "peta" || plug == "vietnamci") {
			tax = 1;
			vysledek = skera * tax;
			real_amount->Text = Convert::ToString(vysledek);
		}
		if (plug == "smack") {
			real_amount->Text = "infinite";
			calculate->Text = "NEØEŠ";
		}
	}
}

private: System::Void about_Click(System::Object^ sender, System::EventArgs^ e) {
	
	counter++;
	/*
	Counter tester
		real_amount->Text = Convert::ToString(counter);
	*/
	if (counter >= 5) {
		MessageBox::Show("smack unlocked");
		if (!(counter > 5)) {
			plug_choice->Items->Add("smack");
		}
	}
	else {
		MessageBox::Show("© 2023 Kybl Enterprise");
	}
	
}
};
}
