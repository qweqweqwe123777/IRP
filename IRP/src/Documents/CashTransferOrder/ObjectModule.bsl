Procedure BeforeWrite(Cancel, WriteMode, PostingMode)
	If DataExchange.Load Then
		Return;
	EndIf;
	TotalTable = New ValueTable();
	TotalTable.Columns.Add("Key");
	TotalTable.Add().Key = ThisObject.SendUUID;
	TotalTable.Add().Key = ThisObject.ReceiveUUID;
	CurrenciesClientServer.DeleteUnusedRowsFromCurrenciesTable(ThisObject.Currencies, TotalTable);
	
	Parameters = CurrenciesClientServer.GetParameters_V7(ThisObject, ThisObject.SendUUID, ThisObject.SendCurrency,
		ThisObject.SendAmount);
	CurrenciesClientServer.DeleteRowsByKeyFromCurrenciesTable(ThisObject.Currencies, ThisObject.SendUUID);
	CurrenciesServer.UpdateCurrencyTable(Parameters, ThisObject.Currencies);
	
	Parameters = CurrenciesClientServer.GetParameters_V7(ThisObject, ThisObject.ReceiveUUID, ThisObject.ReceiveCurrency,
		ThisObject.ReceiveAmount);
	CurrenciesClientServer.DeleteRowsByKeyFromCurrenciesTable(ThisObject.Currencies, ThisObject.ReceiveUUID);
	CurrenciesServer.UpdateCurrencyTable(Parameters, ThisObject.Currencies);
EndProcedure

Procedure OnWrite(Cancel)
	If DataExchange.Load Then
		Return;
	EndIf;
EndProcedure

Procedure BeforeDelete(Cancel)
	If DataExchange.Load Then
		Return;
	EndIf;
EndProcedure

Procedure Posting(Cancel, PostingMode)
	PostingServer.Post(ThisObject, Cancel, PostingMode, ThisObject.AdditionalProperties);
EndProcedure

Procedure UndoPosting(Cancel)
	UndopostingServer.Undopost(ThisObject, Cancel, ThisObject.AdditionalProperties);
EndProcedure

Procedure FillCheckProcessing(Cancel, CheckedAttributes)
	DataFilled = ValueIsFilled(SendCurrency) And ValueIsFilled(ReceiveCurrency) And ValueIsFilled(Sender)
		And ValueIsFilled(Receiver);
	If DataFilled Then

		If SendCurrency = ReceiveCurrency Then

			If SendAmount <> ReceiveAmount Then
				Cancel = True;
				CommonFunctionsClientServer.ShowUsersMessage(R().Error_074, "SendAmount", ThisObject);
				CommonFunctionsClientServer.ShowUsersMessage(R().Error_074, "ReceiveAmount", ThisObject);
			EndIf;
		Else
			// Currency exchange is possible only through accounts with the same type (cash account or bank account)
			If Sender.Type <> Receiver.Type Then
				Cancel = True;
				CommonFunctionsClientServer.ShowUsersMessage(R().Error_050, "Sender", ThisObject);
				CommonFunctionsClientServer.ShowUsersMessage(R().Error_050, "Receiver", ThisObject);
			EndIf;
		EndIf;
	EndIf;

	If DocCashTransferOrderServer.UseCashAdvanceHolder(ThisObject) Then
		CheckedAttributes.Add("CashAdvanceHolder");
	EndIf;
EndProcedure