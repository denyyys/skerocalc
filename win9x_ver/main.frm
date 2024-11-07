VERSION 5.00
Begin VB.Form main 
   BackColor       =   &H00004000&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "SkeroCalc95"
   ClientHeight    =   5670
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5445
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5670
   ScaleWidth      =   5445
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton About_btn 
      Caption         =   "About"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   4200
      TabIndex        =   7
      Top             =   5160
      Width           =   1095
   End
   Begin VB.CommandButton Calculate_btn 
      Caption         =   "Calculate"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1800
      TabIndex        =   4
      Top             =   3360
      Width           =   1815
   End
   Begin VB.TextBox real_amount_box 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   2160
      Locked          =   -1  'True
      TabIndex        =   3
      Top             =   4680
      Width           =   1095
   End
   Begin VB.TextBox skera_box 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1800
      TabIndex        =   2
      Top             =   2160
      Width           =   1815
   End
   Begin VB.ComboBox select_plug 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      ItemData        =   "SkeroCalc95.frx":0000
      Left            =   1800
      List            =   "SkeroCalc95.frx":0002
      TabIndex        =   1
      Text            =   "select plug"
      Top             =   1080
      Width           =   1815
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "Real Amount"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Index           =   1
      Left            =   2055
      TabIndex        =   6
      Top             =   4320
      Width           =   1365
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "Enter Amount"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Index           =   0
      Left            =   2010
      TabIndex        =   5
      Top             =   1800
      Width           =   1395
   End
   Begin VB.Label SkeroCalc_text 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "SkeroCalc95"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000005&
      Height          =   375
      Left            =   1680
      TabIndex        =   0
      Top             =   120
      Width           =   2175
   End
End
Attribute VB_Name = "main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim aboutClickCount As Integer
Dim isSmackUnlocked As Boolean

Private Sub Form_Load()
    
    aboutClickCount = 0
    
    select_plug.AddItem "weby"
    select_plug.AddItem "samik"
    select_plug.AddItem "dominik"
    select_plug.AddItem "peta"
    select_plug.AddItem "vietnamci"
    
End Sub

Private Sub select_plug_Click()
    If select_plug.Text = "vietnamci" Then
        MsgBox "budou to mordy skera tak ara", vbExclamation, "Warning"
    End If
    
    If select_plug.Text <> "smack" Then
        Calculate_btn.Caption = "Calculate"
        real_amount_box.Text = ""
    End If
    
End Sub

Private Sub Calculate_btn_Click()

    Dim skera As Double
    Dim tax As Double
    Dim realAmount As Double
    
    If select_plug.Text = "smack" Then
        real_amount_box.Text = "infinite"
        Calculate_btn.Caption = "NERES"
        Exit Sub
    End If
    
    If Not IsNumeric(skera_box.Text) Then
        MsgBox "Please enter a valid numeric amount.", vbExclamation, "Invalid Input"
    End If
    
    skera = Val(skera_box.Text)
    
    Select Case select_plug.Text
        Case "weby"
            tax = 0.9
        Case "samik"
            tax = 0.75
        Case "dominik"
            tax = 1.3
        Case "peta"
            tax = 1
        Case "vietnamci"
            tax = 1
        Case "smack"
            tax = 1
        Case Else
            MsgBox "Please select a plug."
            
            Exit Sub

End Select

realAmount = skera * tax
real_amount_box.Text = Format(realAmount, "0.00") & "g"

End Sub

Private Sub About_btn_Click()
    
    If isSmackUnlocked Then
        MsgBox "smack unlocked", vbInformation, "huleni"
    Else
        MsgBox "Kybl Enterprise 2024", vbInformation, "About"
        aboutClickCount = aboutClickCount + 1
        
        If aboutClickCount = 5 Then
            select_plug.AddItem "smack"
            MsgBox "smack unlocked", vbInformation, "huleni"
            isSmackUnlocked = True
        End If
    End If
    
End Sub
