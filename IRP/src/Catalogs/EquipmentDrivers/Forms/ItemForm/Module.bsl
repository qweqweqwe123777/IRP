#Region FormEventHandlers

&AtServer
Procedure BeforeWriteAtServer(Cancel, CurrentObject, WriteParameters)
	If IsTempStorageURL(FileAddress) Then
		CurrentObject.Driver = New ValueStorage(GetFromTempStorage(FileAddress));
		CurrentObject.DriverLoaded = True;
	EndIf;
	AddAttributesAndPropertiesServer.BeforeWriteAtServer(ThisObject, Cancel, CurrentObject, WriteParameters);
EndProcedure

&AtClient
Procedure NotificationProcessing(EventName, Parameter, Source)
	If EventName = "UpdateAddAttributeAndPropertySets" Then
		AddAttributesCreateFormControl();
	EndIf;
EndProcedure

&AtServer
Procedure OnCreateAtServer(Cancel, StandardProcessing)
	ExtensionServer.AddAttributesFromExtensions(ThisObject, Object.Ref);
	AddAttributesAndPropertiesServer.OnCreateAtServer(ThisObject);
EndProcedure

&AtClient
Procedure OnOpen(Cancel)
	If Object.DriverLoaded Then
		UpdateDriverStatus();
	EndIf;
EndProcedure
#EndRegion

#Region FormCommandsEventHandlers

&AtClient
Procedure AddFile(Command)
	PutFilesDialogParameters = New PutFilesDialogParameters();
	EndCall			= New NotifyDescription("AddFileEndCall", ThisObject);
	ProgressCall    = New NotifyDescription("AddFileProgressCall", ThisObject);
	BeforeStartCall = New NotifyDescription("AddFileBeforeStartCall", ThisObject);
	BeginPutFileToServer(EndCall, ProgressCall, BeforeStartCall, , PutFilesDialogParameters, ThisObject.UUID);
EndProcedure

&AtClient
Procedure SaveFile(Command)
	If Parameters.Key.IsEmpty() Then
		QuestionToUserNotify = New NotifyDescription("SaveFileNewObjectContinue", ThisObject);
		ShowQueryBox(QuestionToUserNotify, R().QuestionToUser_001, QuestionDialogMode.YesNo);
		Return;
	EndIf;
	SaveFileContinue();
EndProcedure

&AtClient
Procedure Install(Command)
	If Modified Then
		NotifyDescription = New NotifyDescription("InstallDriver_End", ThisObject);
		ShowQueryBox(NotifyDescription, R().QuestionToUser_001, QuestionDialogMode.YesNo);
	Else
		InstallDriver();
	EndIf;
EndProcedure

#EndRegion

#Region Internal

&AtClient
Procedure AddFileEndCall(FileDescription, AddInfo) Export
	If FileDescription = Undefined Or FileDescription.PutFileCanceled Then
		Return;
	EndIf;

	FileAddress = FileDescription.Address;
	Object.Description = FileDescription.FileRef.File.BaseName;
EndProcedure

&AtClient
Procedure AddFileProgressCall(PuttingFile, PutProgress, CancelPut, AddInfo) Export
#If Not MobileClient And Not MobileAppClient Then
	Status(PuttingFile.Name, PutProgress);
#EndIf
EndProcedure

&AtClient
Procedure AddFileBeforeStartCall(PuttingFile, CancelPut, AddInfo) Export
	Return;
EndProcedure

&AtClient
Procedure SaveFileNewObjectContinue(Result, AddInfo = Undefined) Export
	If Result = DialogReturnCode.Yes And Write() Then
		SaveFileContinue();
	EndIf;
EndProcedure

#Region Driver

&AtClient
Procedure BeginGetDriverEnd(DriverObject, Params) Export
	If IsBlankString(DriverObject) Then
		CurrentStatus = R().Eq_002 + ": " + Chars.NBSp + Object.AddInID;
	Else
		Try
			Notify = New NotifyDescription("BeginGetDriverEndAfter", ThisObject);
			DriverObject.НачатьВызовПолучитьОписание(Notify, "");
		Except
			Raise "Old drive revision."
		EndTry;

	EndIf;
EndProcedure

&AtClient
Procedure BeginGetDriverEndAfter(Result, Params, AddInfo) Export
	
	If Result Then
		FillDriverInfo(Params);
		UpdateCurrentStatusDriver();
	EndIf;
	
EndProcedure

&AtServer
Procedure FillDriverInfo(Val Params)
	Array = New Array;
	For Each Param In Params Do
		DriverInfoObj = CommonFunctionsServer.DeserializeXMLUseXDTOFactory(Param); // XDTODataObject
		CurrentVersion = DriverInfoObj.DriverVersion;
		
		For Each KeyRow In DriverInfoObj.Properties() Do
			Array.Add(KeyRow.Name + ": " + DriverInfoObj[KeyRow.Name]);
		EndDo;
		
	EndDo;
	DriverInfo = StrConcat(Array, Chars.LF);
EndProcedure

&AtClient
Procedure InstallDriver_End(Result, Params) Export
	Если Result = DialogReturnCode.Yes Then
		If Modified And Not Write() Then
			Return;
		EndIf;
		InstallDriver();
	EndIf;
EndProcedure

&AtClient
Procedure InstallDriverFromZIPEnd(Result) Export
	UpdateDriverStatus();
EndProcedure

#EndRegion

#EndRegion

#Region Private

&AtClient
Procedure SaveFileContinue()
	BeginGetFileFromServer(GetURL(Object.Ref, "Driver"), Object.Description);
EndProcedure

#Region Driver

&AtClient
Procedure UpdateDriverStatus()
	DriverData = New Structure();
	DriverData.Insert("Driver", Object.Ref);
	DriverData.Insert("AddInID", Object.AddInID);

	Notify = New NotifyDescription("BeginGetDriverEnd", ThisObject);
	HardwareClient.BeginGetDriver(Notify, DriverData);
EndProcedure

&AtClient
Procedure UpdateCurrentStatusDriver()
	CurrentStatus = R().Eq_006;

	If Not IsBlankString(CurrentVersion) Then
		Items.CurrentStatus.Visible = True;
	Else
		Items.CurrentStatus.Visible = False;
	EndIf;
EndProcedure

&AtClient
Procedure InstallDriver()
	ClearMessages();

	If Not CheckFillingDriver() Then
		Return;
	EndIf;

	Notify = New NotifyDescription("InstallDriverFromZIPEnd", ThisObject);

	HardwareClient.InstallDriver(Object.AddInID, Notify);
EndProcedure

&AtClient
Function CheckFillingDriver()
	If Not StrOccurrenceCount(Object.AddInID, ".") Then
		CommonFunctionsClientServer.ShowUsersMessage(R().EqError_003, "Object.AddInID");
		Return False;
	EndIf;
	If Not Object.DriverLoaded Then
		CommonFunctionsClientServer.ShowUsersMessage(R().EqError_004);
		Return False;
	EndIf;
	Return True;
EndFunction

#EndRegion

#EndRegion

#Region AddAttributes

&AtClient
Procedure AddAttributeStartChoice(Item, ChoiceData, StandardProcessing) Export
	AddAttributesAndPropertiesClient.AddAttributeStartChoice(ThisObject, Item, StandardProcessing);
EndProcedure

&AtServer
Procedure AddAttributesCreateFormControl()
	AddAttributesAndPropertiesServer.CreateFormControls(ThisObject);
EndProcedure

#EndRegion
