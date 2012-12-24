" Vim syntax file
" Language:	ObjectPascal
" Previous Maintainer: (pascal.vim) Xavier Crégut <xavier.cregut@enseeiht.fr>
" Current  Maintainer: Thorsten Maerz <info@netztorte.de>
" Last Change:	2010 April 30

" Remove any old syntax stuff hanging around
syn clear
syn case ignore
syn sync lines=250

if !exists("pascal_traditional")
endif

if !exists("did_pascal_syntax_inits")
  let did_pascal_syntax_inits = 1
  " The default methods for highlighting.  Can be overridden later
endif

" ------------------------------------------------------------------------------

syn keyword pascalTodo 			contained	TODO
syn region  pascalString		start=+'+	end=+'+
"syn match  pascalIdentifier		"\<[a-zA-Z_][a-zA-Z0-9_]*\>"
syn match  pascalDelimiter		"[()]"
syn match  pascalMatrixDelimiter	"[][]"

"if you prefer you can highlight the range
"syn match  pascalMatrixDelimiter	"[\d\+\.\.\d\+]"

"syn match  pascalNumber		"-\=\<\d\+\.\d\+[dD]-\=\d\+\>"
"syn match  pascalNumber		"-\=\<\d\+\.\d\+[eE]-\=\d\+\>"
"syn match  pascalNumber		"-\=\<\d\+\.\d\+\>"
syn match  pascalNumber			"-\=\<\d\+\>"
syn match  pascalByte			"\$[0-9a-fA-F]\+\>"

syn match pascalShowTab 		"\t"
syn match pascalShowTabc 		"\t"

syn region pascalComment		start="(\*"	end="\*)"	contains=pascalTodo
syn region pascalComment		start="{"	end="}"		contains=pascalTodo
syn region pascalComment		start="//"	end="$"		contains=pascalTodo

syn keyword pascalLabel			label

syn keyword pascalAccess       		public private protected published
syn match pascalAccess       		"strict private"
syn match pascalAccess       		"strict public"
syn match pascalAccess       		"strict protected"

syn match pascalAssignment		":="
syn keyword pascalAssignment		assign

syn keyword pascalConstant		false maxint nil true
syn keyword pascalConditional		case else if of on then
syn keyword pascalException		try except finally raise
syn keyword pascalRepeat		do downto for repeat to until while

syn keyword pascalComparator		in is
syn match pascalComparator 		"<"
syn match pascalComparator 		"="
syn match pascalComparator 		">"

syn keyword pascalType			TDate TDateTime THandle TRect TTime array boolean byte cardinal char
syn match pascalType			"class("me=e-1,he=e-1
syn keyword pascalType			double dword extended file float input integer keyboard long longint
syn keyword pascalType			longstring object output pchar pointer real resourcestring set short
syn keyword pascalType			shortstring string threadvar variant word UTF8String UTF8 UTF16String
syn keyword pascalType			UTF16

syn keyword pascalFunction		procedure function
syn match pascalFunction		"class\s*procedure"
syn match pascalFunction		"class\s*function"
syn match pascalFunction		"reference\s*to\s*function"
syn match pascalFunction		"reference\s*to\s*procedure"
syn keyword pascalFunction		record type var const constructor destructor property

syn keyword pascalOperator		and as div mod not of or shl shr with xor

syn keyword pascalKeyword		asm begin
syn match pascalKeyword			"contains"
syn keyword pascalKeyword		delete dispose end forward get
syn keyword pascalKeyword		goto implementation inherited initialization finalization
syn keyword pascalKeyword		insert interface label
syn keyword pascalKeyword		library exports new package program put read readln
syn keyword pascalKeyword		requires reset rewrite seek unit uses write writeln

syn keyword pascalObject		TAction TActionList TButton TBitBtn TSpeedBtn TCheckBox TRadioButton
syn keyword pascalObject		TDrawGrid TStringGrid TDBGrid TEdit TMemo TListBox TComboBox TCheckListBox
syn keyword pascalObject		TErrorEvent TNotifyEvent TException Exception
syn keyword pascalObject		TField TTable TQuery TDataSource TDataSet TDataBase TParam TParams
syn keyword pascalObject		TForm TFrame TImage TImageList TLabel TStaticText
syn keyword pascalObject		TList TStrings TStringList TMenu TMainMenu TPopupMenu TMenuItem
syn keyword pascalObject		TObject TPersistent TComponent TControl TWinControl
syn keyword pascalObject		TPanel TSplitter TGroupBox TRadioGroupBox
syn keyword pascalObject		TServerSocket TClientSocket TSocket
syn keyword pascalObject		TStream TFileStream TMemoryStream TCustomStream TReader TWriter
syn keyword pascalObject		TTabNoteBook TTabSheet TPageControl TTimer TUpDown TSpinEdit

"  virtual
syn keyword pascalModifier		inline external assembler near far absolute
syn keyword pascalModifier		interrupt interactive packed dispinterface out automated
syn keyword pascalModifier		at default nodefault dispid implements message
syn keyword pascalModifier		readonly writeonly resident stored

syn keyword pascalObjModifier		abstract virtual override reintroduce
syn keyword pascalFuncModifier		cdecl pascal register stdcall safecall dynamic export name overload
syn region pascalDefine			start="{\$" end="}"

" ------------------------------------------------------------------------------

hi def link pascalAccess       		Statement
hi def link pascalAssignment 	        Operator
hi def link pascalByte			Number
hi def link pascalComment      		Comment
hi def link pascalComparator	        Conditional
hi def link pascalConditional		Conditional
hi def link pascalConstant 	        Statement
hi def link pascalDelimiter		Identifier
hi def link pascalDefine		Macro
hi def link pascalException		Exception
hi def link pascalFuncModifier		Type
hi def link pascalFunction		Function
hi def link pascalIdentifier		Identifier
hi def link pascalLabel			Label
hi def link pascalMatrixDelimiter      	Identifier
hi def link pascalModifier		Type
hi def link pascalNumber	       	Number
hi def link pascalObjModifier		Type
hi def link pascalObject	       	Type
hi def link pascalOperator		Operator
hi def link pascalRepeat	       	Repeat
hi def link pascalShowTab		Error
hi def link pascalShowTabc		Error
hi def link pascalKeyword		Keyword
hi def link pascalString	       	String
hi def link pascalStructure		Structure
hi def link pascalTodo			Todo
hi def link pascalType			Type
hi def link pascalUnclassified		Statement

" ------------------------------------------------------------------------------

let b:current_syntax = "delphi"

" vim: ts=8 sw=2
