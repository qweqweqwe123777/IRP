﻿#language: en
@tree
@Positive
@Movements
@MovementsBankPayment

Feature: check Bank payment movements


Background:
	Given I launch TestClient opening script or connect the existing one



Scenario: _043300 preparation (Bank payment)
	When set True value to the constant
	And I close TestClient session
	Given I open new TestClient session or connect the existing one
	* Load info
		When Create information register Barcodes records
		When Create catalog Companies objects (own Second company)
		When Create catalog PlanningPeriods objects
		When Create catalog Agreements objects
		When Create catalog ObjectStatuses objects
		When Create catalog ItemKeys objects
		When Create catalog ItemTypes objects
		When Create catalog Units objects
		When Create catalog Items objects
		When Create catalog PriceTypes objects
		When Create catalog Specifications objects
		When Create chart of characteristic types AddAttributeAndProperty objects
		When Create catalog AddAttributeAndPropertySets objects
		When Create catalog AddAttributeAndPropertyValues objects
		When Create catalog Currencies objects
		When Create catalog Companies objects (Main company)
		When Create catalog Stores objects
		When Create catalog Partners objects
		When Create catalog Companies objects (partners company)
		When Create information register PartnerSegments records
		When Create catalog PartnerSegments objects
		When Create chart of characteristic types CurrencyMovementType objects
		When Create catalog TaxRates objects
		When Create catalog Taxes objects	
		When Create information register TaxSettings records
		When Create information register PricesByItemKeys records
		When Create catalog IntegrationSettings objects
		When Create information register CurrencyRates records
		When Create catalog BusinessUnits objects
		When Create catalog ExpenseAndRevenueTypes objects
		When Create catalog Companies objects (second company Ferron BP)
		When Create catalog PartnersBankAccounts objects
		When update ItemKeys
		When Create catalog SerialLotNumbers objects
		When Create catalog CashAccounts objects
		When Create catalog PlanningPeriods objects
		When Create catalog BankTerms objects
		When Create catalog PaymentTerminals objects
		When Create catalog PaymentTypes objects
		When Create catalog CashAccounts objects (POS)
	* Add plugin for taxes calculation
		Given I open hyperlink "e1cib/list/Catalog.ExternalDataProc"
		If "List" table does not contain lines Then
				| "Description" |
				| "TaxCalculateVAT_TR" |
			When add Plugin for tax calculation
		When Create information register Taxes records (VAT)
	* Tax settings
		When filling in Tax settings for company
	When Create Document discount
	When Create catalog LegalNameContracts objects
	* Add plugin for discount
		Given I open hyperlink "e1cib/list/Catalog.ExternalDataProc"
		If "List" table does not contain lines Then
				| "Description" |
				| "DocumentDiscount" |
			When add Plugin for document discount
			When Create catalog CancelReturnReasons objects
	* Load documents
		Given I open hyperlink "e1cib/list/Document.PurchaseOrder"
		If "List" table does not contain lines Then
			| 'Number'  |
			| '115' |
			When Create document PurchaseOrder objects (check movements, GR before PI, Use receipt sheduling)
			And I execute 1C:Enterprise script at server
				| "Documents.PurchaseOrder.FindByNumber(115).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document PurchaseInvoice objects
		And I execute 1C:Enterprise script at server
			| "Documents.PurchaseInvoice.FindByNumber(12).GetObject().Write(DocumentWriteMode.Posting);" |
		Given I open hyperlink "e1cib/list/Document.PurchaseInvoice"
		If "List" table does not contain lines Then
			| 'Number'  |
			| '115' |
			| '116' |
			When Create document PurchaseInvoice objects (check movements)
			And I execute 1C:Enterprise script at server
				| "Documents.PurchaseInvoice.FindByNumber(115).GetObject().Write(DocumentWriteMode.Posting);" |
			And I execute 1C:Enterprise script at server
				| "Documents.PurchaseInvoice.FindByNumber(116).GetObject().Write(DocumentWriteMode.Posting);" |
		Given I open hyperlink "e1cib/list/Document.GoodsReceipt"
		If "List" table does not contain lines Then
			| 'Number'  |
			| '115' |
			| '116' |
			When Create document GoodsReceipt objects (check movements)
			And I execute 1C:Enterprise script at server
				| "Documents.GoodsReceipt.FindByNumber(115).GetObject().Write(DocumentWriteMode.Posting);" |
			And I execute 1C:Enterprise script at server
				| "Documents.GoodsReceipt.FindByNumber(116).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document CashTransferOrder objects
		When Create document CashTransferOrder objects (check movements)
		And I execute 1C:Enterprise script at server
			| "Documents.CashTransferOrder.FindByNumber(1).GetObject().Write(DocumentWriteMode.Posting);" |
		And I execute 1C:Enterprise script at server
			| "Documents.CashTransferOrder.FindByNumber(2).GetObject().Write(DocumentWriteMode.Posting);" |
		And I execute 1C:Enterprise script at server
			| "Documents.CashTransferOrder.FindByNumber(3).GetObject().Write(DocumentWriteMode.Posting);" |
		And I execute 1C:Enterprise script at server
			| "Documents.CashTransferOrder.FindByNumber(4).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document PurchaseOrder objects (with aging, prepaid, post-shipment credit)
		And I execute 1C:Enterprise script at server
			| "Documents.PurchaseOrder.FindByNumber(323).GetObject().Write(DocumentWriteMode.Posting);" |
		And I execute 1C:Enterprise script at server
			| "Documents.PurchaseOrder.FindByNumber(324).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document PurchaseInvoice objects (with aging, prepaid, post-shipment credit)
		And I execute 1C:Enterprise script at server
			| "Documents.PurchaseInvoice.FindByNumber(323).GetObject().Write(DocumentWriteMode.Posting);" |
		And I execute 1C:Enterprise script at server
			| "Documents.PurchaseInvoice.FindByNumber(324).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document OutgoingPaymentOrder objects (Cash planning)
		And I execute 1C:Enterprise script at server
			| "Documents.OutgoingPaymentOrder.FindByNumber(323).GetObject().Write(DocumentWriteMode.Posting);" |
		And I execute 1C:Enterprise script at server
			| "Documents.OutgoingPaymentOrder.FindByNumber(324).GetObject().Write(DocumentWriteMode.Posting);" |
	* Load Bank payment
		When Create document BankPayment objects (check movements, advance)
		When Create document BankPayment objects
		When Create document BankPayment objects (check movements)
		And I execute 1C:Enterprise script at server
			| "Documents.BankPayment.FindByNumber(1).GetObject().Write(DocumentWriteMode.Posting);" |
		And I execute 1C:Enterprise script at server
			| "Documents.BankPayment.FindByNumber(2).GetObject().Write(DocumentWriteMode.Posting);" |
		And I execute 1C:Enterprise script at server
			| "Documents.BankPayment.FindByNumber(3).GetObject().Write(DocumentWriteMode.Posting);" |
		And I execute 1C:Enterprise script at server
			| "Documents.BankPayment.FindByNumber(10).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document SalesReturn objects (check movements)
		And I execute 1C:Enterprise script at server
			| "Documents.SalesReturn.FindByNumber(101).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document BankPayment objects (check cash planning, cash transfer order and OPO)
		And I execute 1C:Enterprise script at server
			| "Documents.BankPayment.FindByNumber(323).GetObject().Write(DocumentWriteMode.Posting);" |
		And I execute 1C:Enterprise script at server
			| "Documents.BankPayment.FindByNumber(324).GetObject().Write(DocumentWriteMode.Posting);" |
		And I execute 1C:Enterprise script at server
			| "Documents.BankPayment.FindByNumber(325).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document BankPayment objects (return to customer)
		And I execute 1C:Enterprise script at server
			| "Documents.BankPayment.FindByNumber(326).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document BankPayment objects (return to customer by POS)
		And I execute 1C:Enterprise script at server
			| "Documents.BankPayment.FindByNumber(1329).GetObject().Write(DocumentWriteMode.Posting);" |
		And I execute 1C:Enterprise script at server
			| "Documents.BankPayment.FindByNumber(1330).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document BankPayment objects (with partner term by document, without basis)
		And I execute 1C:Enterprise script at server
			| "Documents.BankPayment.FindByNumber(328).GetObject().Write(DocumentWriteMode.Posting);" |
		And I close all client application windows
		When Create document SalesReturn objects (check movements)
		And I execute 1C:Enterprise script at server
			| "Documents.SalesReturn.FindByNumber(101).GetObject().Write(DocumentWriteMode.Posting);" |
		
Scenario: _043301 check Bank payment movements by the Register "R3010 Cash on hand"
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '2' |
	* Check movements by the Register  "R3010 Cash on hand" 
		And I click "Registrations report" button
		And I select "R3010 Cash on hand" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 2 dated 05.04.2021 12:28:47' | ''            | ''                    | ''          | ''             | ''             | ''                  | ''         | ''                             | ''                     |
			| 'Document registrations records'           | ''            | ''                    | ''          | ''             | ''             | ''                  | ''         | ''                             | ''                     |
			| 'Register  "R3010 Cash on hand"'           | ''            | ''                    | ''          | ''             | ''             | ''                  | ''         | ''                             | ''                     |
			| ''                                         | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''   | ''                  | ''         | ''                             | 'Attributes'           |
			| ''                                         | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'      | 'Account'           | 'Currency' | 'Multi currency movement type' | 'Deferred calculation' |
			| ''                                         | 'Expense'     | '05.04.2021 12:28:47' | '500'       | 'Main Company' | 'Front office' | 'Bank account, EUR' | 'EUR'      | 'en description is empty'      | 'No'                   |
			| ''                                         | 'Expense'     | '05.04.2021 12:28:47' | '550'       | 'Main Company' | 'Front office' | 'Bank account, EUR' | 'USD'      | 'Reporting currency'           | 'No'                   |
			| ''                                         | 'Expense'     | '05.04.2021 12:28:47' | '2 500'     | 'Main Company' | 'Front office' | 'Bank account, EUR' | 'TRY'      | 'Local currency'               | 'No'                   |
	And I close all client application windows

	
Scenario: _043302 check Bank payment movements by the Register "R5010 Reconciliation statement" (payment to vendor)
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |'Date'               |
			| '1'       |'07.09.2020 19:16:43'|
	* Check movements by the Register  "R5010 Reconciliation statement" 
		And I click "Registrations report" button
		And I select "R5010 Reconciliation statement" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 1 dated 07.09.2020 19:16:43'   | ''            | ''                    | ''          | ''             | ''             | ''           | ''                  | ''                  |
			| 'Document registrations records'             | ''            | ''                    | ''          | ''             | ''             |  ''          |''                   | ''                  |
			| 'Register  "R5010 Reconciliation statement"' | ''            | ''                    | ''          | ''             | ''             | ''           | ''                  | ''                  |
			| ''                                           | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''             | ''           | ''                  | ''                  |
			| ''                                           | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'       |'Currency'    | 'Legal name'        |'Legal name contract'|
			| ''                                           | 'Receipt'     | '07.09.2020 19:16:43' | '1 000'     | 'Main Company' | ''             | 'TRY'        | 'Company Ferron BP' |'Contract Ferron BP' |
	And I close all client application windows

Scenario: _043303 check absence Bank payment movements by the Register "R5010 Reconciliation statement" (cash transfer, currency exchange)
	And I close all client application windows
	* Select Bank payment (cash transfer)
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '2' |
	* Check movements by the Register  "R5010 Reconciliation statement" 
		And I click "Registrations report" button
		And I select "R5010 Reconciliation statement" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document does not contain values
			| 'Register  "R5010 Reconciliation statement'   |                  
	And I close all client application windows
	* Select Bank payment (currency exchange)
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '3' |
	* Check movements by the Register  "R5010 Reconciliation statement" 
		And I click "Registrations report" button
		And I select "R5010 Reconciliation statement" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document does not contain values
			| 'Register  "R5010 Reconciliation statement'   |                  
	And I close all client application windows

	
Scenario: _043304 check Bank payment movements by the Register "R1021 Vendors transactions" (payment to vendor, basis document exist)
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |'Date'               |
			| '1'       |'07.09.2020 19:16:43'|
		And I select current line in "List" table		
	* Check movements by the Register  "R1021 Vendors transactions" 
		And I click "Registrations report" button
		And I select "R1021 Vendors transactions" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 1 dated 07.09.2020 19:16:43' | ''            | ''                    | ''          | ''             | ''       | ''                             | ''         | ''                  | ''          | ''                   | ''                                              | ''                         | ''                     | ''                         |
			| 'Document registrations records'           | ''            | ''                    | ''          | ''             | ''       | ''                             | ''         | ''                  | ''          | ''                   | ''                                              | ''                         | ''                     | ''                         |
			| 'Register  "R1021 Vendors transactions"'   | ''            | ''                    | ''          | ''             | ''       | ''                             | ''         | ''                  | ''          | ''                   | ''                                              | ''                         | ''                     | ''                         |
			| ''                                         | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''       | ''                             | ''         | ''                  | ''          | ''                   | ''                                              | ''                         | 'Attributes'           | ''                         |
			| ''                                         | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch' | 'Multi currency movement type' | 'Currency' | 'Legal name'        | 'Partner'   | 'Agreement'          | 'Basis'                                         | 'Order'                    | 'Deferred calculation' | 'Vendors advances closing' |
			| ''                                         | 'Expense'     | '07.09.2020 19:16:43' | '171,2'     | 'Main Company' | ''       | 'Reporting currency'           | 'USD'      | 'Company Ferron BP' | 'Ferron BP' | 'Vendor Ferron, TRY' | 'Purchase invoice 12 dated 07.09.2020 17:53:38' | ''                         | 'No'                   | ''                         |
			| ''                                         | 'Expense'     | '07.09.2020 19:16:43' | '1 000'     | 'Main Company' | ''       | 'Local currency'               | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Vendor Ferron, TRY' | 'Purchase invoice 12 dated 07.09.2020 17:53:38' | ''                         | 'No'                   | ''                         |
			| ''                                         | 'Expense'     | '07.09.2020 19:16:43' | '1 000'     | 'Main Company' | ''       | 'TRY'                          | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Vendor Ferron, TRY' | 'Purchase invoice 12 dated 07.09.2020 17:53:38' | ''                         | 'No'                   | ''                         |
			| ''                                         | 'Expense'     | '07.09.2020 19:16:43' | '1 000'     | 'Main Company' | ''       | 'en description is empty'      | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Vendor Ferron, TRY' | 'Purchase invoice 12 dated 07.09.2020 17:53:38' | ''                         | 'No'                   | ''                         |
	And I close all client application windows

Scenario: _043305 check absence Bank payment movements by the Register "R1021 Vendors transactions" (payment to vendor, without basis document)
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |'Date'               |
			| '10'       |'12.02.2021 11:24:13'|
	* Check movements by the Register  "R1021 Vendors transactions" 
		And I click "Registrations report" button
		And I select "R1021 Vendors transactions" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document does not contain values
			| 'R1021 Vendors transactions'   | 
	And I close all client application windows

Scenario: _043306 check Bank payment movements by the Register "R1020 Advances to vendors" (payment to vendor, without basis document )
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |'Date'               |
			| '10'       |'12.02.2021 11:24:13'|
	* Check movements by the Register  "R1020 Advances to vendors" 
		And I click "Registrations report" button
		And I select "R1020 Advances to vendors" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 10 dated 12.02.2021 11:24:13'| ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                                         | ''                     | ''                  |
			| 'Document registrations records'           | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                                         | ''                     | ''                  |
			| 'Register  "R1020 Advances to vendors"'    | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                                         | ''                     | ''                  |
			| ''                                         | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''             | ''                             | ''         | ''                  | ''          | ''                                         | 'Attributes'           | ''                  |
			| ''                                         | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'       | 'Multi currency movement type' | 'Currency' | 'Legal name'        | 'Partner'   | 'Order'                                    | 'Deferred calculation' | 'Vendors advances closing' |
			| ''                                         | 'Receipt'     | '12.02.2021 11:24:13' | '342,4'     | 'Main Company' | 'Front office' | 'Reporting currency'           | 'USD'      | 'Company Ferron BP' | 'Ferron BP' | ''                                         | 'No'                   | ''                |
			| ''                                         | 'Receipt'     | '12.02.2021 11:24:13' | '2 000'     | 'Main Company' | 'Front office' | 'Local currency'               | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | ''                                         | 'No'                   | ''                |
			| ''                                         | 'Receipt'     | '12.02.2021 11:24:13' | '2 000'     | 'Main Company' | 'Front office' | 'en description is empty'      | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | ''                                         | 'No'                   | ''                |
	And I close all client application windows

Scenario: _043307 check absence Bank payment movements by the Register "R1020 Advances to vendors" (payment to vendor, without basis document)
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |'Date'               |
			| '1'       |'07.09.2020 19:16:43'|
	* Check movements by the Register  "R1020 Advances to vendors" 
		And I click "Registrations report" button
		And I select "R1020 Advances to vendors" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document does not contain values
			| 'R1020 Advances to vendors'   | 
	And I close all client application windows


Scenario: _043315 check Bank payment movements by the Register "R3035 Cash planning" (payment to vendor, with planning transaction basis)
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number' | 'Date'                |
			| '323'    | '03.06.2021 17:01:44' |
	* Check movements by the Register  "R3035 Cash planning" 
		And I click "Registrations report" button
		And I select "R3035 Cash planning" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 323 dated 03.06.2021 17:01:44' | ''                    | ''          | ''             | ''       | ''                                                     | ''                  | ''         | ''                    | ''          | ''                  | ''                             | ''                | ''                | ''                     |
			| 'Document registrations records'             | ''                    | ''          | ''             | ''       | ''                                                     | ''                  | ''         | ''                    | ''          | ''                  | ''                             | ''                | ''                | ''                     |
			| 'Register  "R3035 Cash planning"'            | ''                    | ''          | ''             | ''       | ''                                                     | ''                  | ''         | ''                    | ''          | ''                  | ''                             | ''                | ''                | ''                     |
			| ''                                           | 'Period'              | 'Resources' | 'Dimensions'   | ''       | ''                                                     | ''                  | ''         | ''                    | ''          | ''                  | ''                             | ''                | ''                | 'Attributes'           |
			| ''                                           | ''                    | 'Amount'    | 'Company'      | 'Branch' | 'Basis document'                                       | 'Account'           | 'Currency' | 'Cash flow direction' | 'Partner'   | 'Legal name'        | 'Multi currency movement type' | 'Financial movement type'   | 'Planning period' | 'Deferred calculation' |
			| ''                                           | '03.06.2021 17:01:44' | '-1 500'    | 'Main Company' | ''       | 'Outgoing payment order 323 dated 07.09.2020 19:23:44' | 'Bank account, TRY' | 'TRY'      | 'Outgoing'            | 'Ferron BP' | 'Company Ferron BP' | 'Local currency'               | 'Movement type 1' | 'First'           | 'No'                   |
			| ''                                           | '03.06.2021 17:01:44' | '-1 500'    | 'Main Company' | ''       | 'Outgoing payment order 323 dated 07.09.2020 19:23:44' | 'Bank account, TRY' | 'TRY'      | 'Outgoing'            | 'Ferron BP' | 'Company Ferron BP' | 'en description is empty'      | 'Movement type 1' | 'First'           | 'No'                   |
			| ''                                           | '03.06.2021 17:01:44' | '-400'      | 'Main Company' | ''       | 'Outgoing payment order 323 dated 07.09.2020 19:23:44' | 'Bank account, TRY' | 'TRY'      | 'Outgoing'            | 'Kalipso'   | 'Company Kalipso'   | 'Local currency'               | 'Movement type 1' | 'First'           | 'No'                   |
			| ''                                           | '03.06.2021 17:01:44' | '-400'      | 'Main Company' | ''       | 'Outgoing payment order 323 dated 07.09.2020 19:23:44' | 'Bank account, TRY' | 'TRY'      | 'Outgoing'            | 'Kalipso'   | 'Company Kalipso'   | 'en description is empty'      | 'Movement type 1' | 'First'           | 'No'                   |
			| ''                                           | '03.06.2021 17:01:44' | '-256,8'    | 'Main Company' | ''       | 'Outgoing payment order 323 dated 07.09.2020 19:23:44' | 'Bank account, TRY' | 'USD'      | 'Outgoing'            | 'Ferron BP' | 'Company Ferron BP' | 'Reporting currency'           | 'Movement type 1' | 'First'           | 'No'                   |
			| ''                                           | '03.06.2021 17:01:44' | '-68,48'    | 'Main Company' | ''       | 'Outgoing payment order 323 dated 07.09.2020 19:23:44' | 'Bank account, TRY' | 'USD'      | 'Outgoing'            | 'Kalipso'   | 'Company Kalipso'   | 'Reporting currency'           | 'Movement type 1' | 'First'           | 'No'                   |
	And I close all client application windows

Scenario: _043316 check Bank payment movements by the Register "R3035 Cash planning" (currency exchange, with planning transaction basis)
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number' |
			| '324'    |
	* Check movements by the Register  "R3035 Cash planning" 
		And I click "Registrations report" button
		And I select "R3035 Cash planning" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 324 dated 03.06.2021 17:05:34' | ''                    | ''          | ''             | ''       | ''                                                | ''                  | ''         | ''                    | ''        | ''           | ''                             | ''                | ''                | ''                     |
			| 'Document registrations records'             | ''                    | ''          | ''             | ''       | ''                                                | ''                  | ''         | ''                    | ''        | ''           | ''                             | ''                | ''                | ''                     |
			| 'Register  "R3035 Cash planning"'            | ''                    | ''          | ''             | ''       | ''                                                | ''                  | ''         | ''                    | ''        | ''           | ''                             | ''                | ''                | ''                     |
			| ''                                           | 'Period'              | 'Resources' | 'Dimensions'   | ''       | ''                                                | ''                  | ''         | ''                    | ''        | ''           | ''                             | ''                | ''                | 'Attributes'           |
			| ''                                           | ''                    | 'Amount'    | 'Company'      | 'Branch' | 'Basis document'                                  | 'Account'           | 'Currency' | 'Cash flow direction' | 'Partner' | 'Legal name' | 'Multi currency movement type' | 'Financial movement type'   | 'Planning period' | 'Deferred calculation' |
			| ''                                           | '03.06.2021 17:05:34' | '-1 000'    | 'Main Company' | ''       | 'Cash transfer order 3 dated 05.04.2021 12:23:49' | 'Bank account, TRY' | 'TRY'      | 'Outgoing'            | ''        | ''           | 'Local currency'               | 'Movement type 1' | ''                | 'No'                   |
			| ''                                           | '03.06.2021 17:05:34' | '-1 000'    | 'Main Company' | ''       | 'Cash transfer order 3 dated 05.04.2021 12:23:49' | 'Bank account, TRY' | 'TRY'      | 'Outgoing'            | ''        | ''           | 'en description is empty'      | 'Movement type 1' | ''                | 'No'                   |
			| ''                                           | '03.06.2021 17:05:34' | '-171,2'    | 'Main Company' | ''       | 'Cash transfer order 3 dated 05.04.2021 12:23:49' | 'Bank account, TRY' | 'USD'      | 'Outgoing'            | ''        | ''           | 'Reporting currency'           | 'Movement type 1' | ''                | 'No'                   |
	And I close all client application windows

Scenario: _043317 check Bank payment movements by the Register "R3035 Cash planning" (cash transfer order, with planning transaction basis)
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number' |
			| '325'    |
	* Check movements by the Register  "R3035 Cash planning" 
		And I click "Registrations report" button
		And I select "R3035 Cash planning" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 325 dated 03.06.2021 17:04:49' | ''                    | ''          | ''             | ''       | ''                                                | ''                  | ''         | ''                    | ''        | ''           | ''                             | ''                | ''                | ''                     |
			| 'Document registrations records'             | ''                    | ''          | ''             | ''       | ''                                                | ''                  | ''         | ''                    | ''        | ''           | ''                             | ''                | ''                | ''                     |
			| 'Register  "R3035 Cash planning"'            | ''                    | ''          | ''             | ''       | ''                                                | ''                  | ''         | ''                    | ''        | ''           | ''                             | ''                | ''                | ''                     |
			| ''                                           | 'Period'              | 'Resources' | 'Dimensions'   | ''       | ''                                                | ''                  | ''         | ''                    | ''        | ''           | ''                             | ''                | ''                | 'Attributes'           |
			| ''                                           | ''                    | 'Amount'    | 'Company'      | 'Branch' | 'Basis document'                                  | 'Account'           | 'Currency' | 'Cash flow direction' | 'Partner' | 'Legal name' | 'Multi currency movement type' | 'Financial movement type'   | 'Planning period' | 'Deferred calculation' |
			| ''                                           | '03.06.2021 17:04:49' | '-4 500'    | 'Main Company' | ''       | 'Cash transfer order 2 dated 05.04.2021 12:09:54' | 'Bank account, EUR' | 'TRY'      | 'Outgoing'            | ''        | ''           | 'Local currency'               | 'Movement type 1' | ''                | 'No'                   |
			| ''                                           | '03.06.2021 17:04:49' | '-550'      | 'Main Company' | ''       | 'Cash transfer order 2 dated 05.04.2021 12:09:54' | 'Bank account, EUR' | 'USD'      | 'Outgoing'            | ''        | ''           | 'Reporting currency'           | 'Movement type 1' | ''                | 'No'                   |
			| ''                                           | '03.06.2021 17:04:49' | '-500'      | 'Main Company' | ''       | 'Cash transfer order 2 dated 05.04.2021 12:09:54' | 'Bank account, EUR' | 'EUR'      | 'Outgoing'            | ''        | ''           | 'en description is empty'      | 'Movement type 1' | ''                | 'No'                   |
	And I close all client application windows

	
		

Scenario: _043318 check absence Bank payment movements by the Register "R3035 Cash planning" (without planning transaction basis)
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |'Date'               |
			| '1'       |'07.09.2020 19:16:43'|
	* Check movements by the Register  "R3035 Cash planning" 
		And I click "Registrations report" button
		And I select "R3035 Cash planning" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document does not contain values
			| 'R3035 Cash planning'   | 
	And I close all client application windows

Scenario: _043319 check Bank payment movements by the Register "R5022 Expenses" (with  comission)
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number' | 'Date'                |
			| '323'    | '03.06.2021 17:01:44' |
	* Check movements by the Register  "R5022 Expenses" 
		And I click "Registrations report" button
		And I select "R5022 Expenses" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 323 dated 03.06.2021 17:01:44' | ''                    | ''          | ''                  | ''            | ''             | ''       | ''                   | ''             | ''         | ''         | ''                    | ''                             | ''                          |
			| 'Document registrations records'             | ''                    | ''          | ''                  | ''            | ''             | ''       | ''                   | ''             | ''         | ''         | ''                    | ''                             | ''                          |
			| 'Register  "R5022 Expenses"'                 | ''                    | ''          | ''                  | ''            | ''             | ''       | ''                   | ''             | ''         | ''         | ''                    | ''                             | ''                          |
			| ''                                           | 'Period'              | 'Resources' | ''                  | ''            | 'Dimensions'   | ''       | ''                   | ''             | ''         | ''         | ''                    | ''                             | 'Attributes'                |
			| ''                                           | ''                    | 'Amount'    | 'Amount with taxes' | 'Amount cost' | 'Company'      | 'Branch' | 'Profit loss center' | 'Expense type' | 'Item key' | 'Currency' | 'Additional analytic' | 'Multi currency movement type' | 'Calculation movement cost' |
			| ''                                           | '03.06.2021 17:01:44' | '2,57'      | '2,57'              | ''            | 'Main Company' | ''       | 'Front office'       | 'Expense'      | ''         | 'USD'      | ''                    | 'Reporting currency'           | ''                          |
			| ''                                           | '03.06.2021 17:01:44' | '15'        | '15'                | ''            | 'Main Company' | ''       | 'Front office'       | 'Expense'      | ''         | 'TRY'      | ''                    | 'Local currency'               | ''                          |
			| ''                                           | '03.06.2021 17:01:44' | '15'        | '15'                | ''            | 'Main Company' | ''       | 'Front office'       | 'Expense'      | ''         | 'TRY'      | ''                    | 'en description is empty'      | ''                          |		
	And I close all client application windows

Scenario: _043320 check Bank payment movements by the Register "R3010 Cash on hand" (Return to customer, without basis)
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '326' |
	* Check movements by the Register  "R3010 Cash on hand" 
		And I click "Registrations report" button
		And I select "R3010 Cash on hand" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 326 dated 02.09.2021 14:24:44' | ''            | ''                    | ''          | ''             | ''                        | ''                  | ''         | ''                             | ''                     |
			| 'Document registrations records'             | ''            | ''                    | ''          | ''             | ''                        | ''                  | ''         | ''                             | ''                     |
			| 'Register  "R3010 Cash on hand"'             | ''            | ''                    | ''          | ''             | ''                        | ''                  | ''         | ''                             | ''                     |
			| ''                                           | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''                        | ''                  | ''         | ''                             | 'Attributes'           |
			| ''                                           | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'                  | 'Account'           | 'Currency' | 'Multi currency movement type' | 'Deferred calculation' |
			| ''                                           | 'Expense'     | '02.09.2021 14:24:44' | '17,12'     | 'Main Company' | 'Distribution department' | 'Bank account, TRY' | 'USD'      | 'Reporting currency'           | 'No'                   |
			| ''                                           | 'Expense'     | '02.09.2021 14:24:44' | '100'       | 'Main Company' | 'Distribution department' | 'Bank account, TRY' | 'TRY'      | 'Local currency'               | 'No'                   |
			| ''                                           | 'Expense'     | '02.09.2021 14:24:44' | '100'       | 'Main Company' | 'Distribution department' | 'Bank account, TRY' | 'TRY'      | 'en description is empty'      | 'No'                   |		
	And I close all client application windows

Scenario: _043321 check Bank payment movements by the Register "R5010 Reconciliation statement" (return to customer)
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '326'       |
	* Check movements by the Register  "R5010 Reconciliation statement" 
		And I click "Registrations report" button
		And I select "R5010 Reconciliation statement" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 326 dated 02.09.2021 14:24:44' | ''            | ''                    | ''          | ''             | ''                        | ''         | ''                | ''                    |
			| 'Document registrations records'             | ''            | ''                    | ''          | ''             | ''                        | ''         | ''                | ''                    |
			| 'Register  "R5010 Reconciliation statement"' | ''            | ''                    | ''          | ''             | ''                        | ''         | ''                | ''                    |
			| ''                                           | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''                        | ''         | ''                | ''                    |
			| ''                                           | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'                  | 'Currency' | 'Legal name'      | 'Legal name contract' |
			| ''                                           | 'Receipt'     | '02.09.2021 14:24:44' | '100'       | 'Main Company' | 'Distribution department' | 'TRY'      | 'Company Kalipso' | ''                    |				
	And I close all client application windows

Scenario: _043322 check Bank payment movements by the Register "R1020 Advances to vendors" (with partner term by document, without basis)
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '328'       |
	* Check movements by the Register  "R1020 Advances to vendors" 
		And I click "Registrations report" button
		And I select "R1020 Advances to vendors" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 328 dated 08.02.2022 13:43:58' | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''                  | ''          | ''      | ''                     | ''                         |
			| 'Document registrations records'             | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''                  | ''          | ''      | ''                     | ''                         |
			| 'Register  "R1020 Advances to vendors"'      | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''                  | ''          | ''      | ''                     | ''                         |
			| ''                                           | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''                        | ''                             | ''         | ''                  | ''          | ''      | 'Attributes'           | ''                         |
			| ''                                           | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'                  | 'Multi currency movement type' | 'Currency' | 'Legal name'        | 'Partner'   | 'Order' | 'Deferred calculation' | 'Vendors advances closing' |
			| ''                                           | 'Receipt'     | '08.02.2022 13:43:58' | '8,56'      | 'Main Company' | 'Distribution department' | 'Reporting currency'           | 'USD'      | 'Company Ferron BP' | 'Ferron BP' | ''      | 'No'                   | ''                         |
			| ''                                           | 'Receipt'     | '08.02.2022 13:43:58' | '50'        | 'Main Company' | 'Distribution department' | 'Local currency'               | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | ''      | 'No'                   | ''                         |
			| ''                                           | 'Receipt'     | '08.02.2022 13:43:58' | '50'        | 'Main Company' | 'Distribution department' | 'en description is empty'      | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | ''      | 'No'                   | ''                         |	
	And I close all client application windows

Scenario: _043323 check Bank payment movements by the Register "R3010 Cash on hand" (Return to customer by POS, with basis document)
		And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '1 329' |
	* Check movements by the Register  "R3010 Cash on hand" 
		And I click "Registrations report" button
		And I select "R3010 Cash on hand" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 1 329 dated 24.06.2022 18:06:56' | ''            | ''                    | ''          | ''             | ''                        | ''                                     | ''         | ''                             | ''                     |
			| 'Document registrations records'               | ''            | ''                    | ''          | ''             | ''                        | ''                                     | ''         | ''                             | ''                     |
			| 'Register  "R3010 Cash on hand"'               | ''            | ''                    | ''          | ''             | ''                        | ''                                     | ''         | ''                             | ''                     |
			| ''                                             | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''                        | ''                                     | ''         | ''                             | 'Attributes'           |
			| ''                                             | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'                  | 'Account'                              | 'Currency' | 'Multi currency movement type' | 'Deferred calculation' |
			| ''                                             | 'Expense'     | '24.06.2022 18:06:56' | '8,56'      | 'Main Company' | 'Distribution department' | 'POS account, Comission separate, TRY' | 'USD'      | 'Reporting currency'           | 'No'                   |
			| ''                                             | 'Expense'     | '24.06.2022 18:06:56' | '50'        | 'Main Company' | 'Distribution department' | 'POS account, Comission separate, TRY' | 'TRY'      | 'Local currency'               | 'No'                   |
			| ''                                             | 'Expense'     | '24.06.2022 18:06:56' | '50'        | 'Main Company' | 'Distribution department' | 'POS account, Comission separate, TRY' | 'TRY'      | 'en description is empty'      | 'No'                   |
	And I close all client application windows

Scenario: _043324 check Bank payment movements by the Register "R3050 Pos cash balances" (Return to customer by POS, with basis document)
		And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '1 329' |
	* Check movements by the Register  "R3050 Pos cash balances" 
		And I click "Registrations report" button
		And I select "R3050 Pos cash balances" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 1 329 dated 24.06.2022 18:06:56' | ''                    | ''          | ''           | ''             | ''                        | ''             | ''                                     | ''                 |
			| 'Document registrations records'               | ''                    | ''          | ''           | ''             | ''                        | ''             | ''                                     | ''                 |
			| 'Register  "R3050 Pos cash balances"'          | ''                    | ''          | ''           | ''             | ''                        | ''             | ''                                     | ''                 |
			| ''                                             | 'Period'              | 'Resources' | ''           | 'Dimensions'   | ''                        | ''             | ''                                     | ''                 |
			| ''                                             | ''                    | 'Amount'    | 'Commission' | 'Company'      | 'Branch'                  | 'Payment type' | 'Account'                              | 'Payment terminal' |
			| ''                                             | '24.06.2022 18:06:56' | '-50'       | '-5'         | 'Main Company' | 'Distribution department' | 'Card 01'      | 'POS account, Comission separate, TRY' | 'Test01'           |
	And I close all client application windows

Scenario: _043325 check Bank payment movements by the Register "R2021 Customer transactions" (Return to customer by POS, with basis document)
		And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '1 329' |
	* Check movements by the Register  "R2021 Customer transactions" 
		And I click "Registrations report" button
		And I select "R2021 Customer transactions" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 1 329 dated 24.06.2022 18:06:56' | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''                  | ''          | ''                         | ''                                           | ''      | ''                     | ''                           |
			| 'Document registrations records'               | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''                  | ''          | ''                         | ''                                           | ''      | ''                     | ''                           |
			| 'Register  "R2021 Customer transactions"'      | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''                  | ''          | ''                         | ''                                           | ''      | ''                     | ''                           |
			| ''                                             | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''                        | ''                             | ''         | ''                  | ''          | ''                         | ''                                           | ''      | 'Attributes'           | ''                           |
			| ''                                             | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'                  | 'Multi currency movement type' | 'Currency' | 'Legal name'        | 'Partner'   | 'Agreement'                | 'Basis'                                      | 'Order' | 'Deferred calculation' | 'Customers advances closing' |
			| ''                                             | 'Expense'     | '24.06.2022 18:06:56' | '-50'       | 'Main Company' | 'Distribution department' | 'Local currency'               | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Basic Partner terms, TRY' | 'Sales return 103 dated 12.03.2021 08:59:52' | ''      | 'No'                   | ''                           |
			| ''                                             | 'Expense'     | '24.06.2022 18:06:56' | '-50'       | 'Main Company' | 'Distribution department' | 'TRY'                          | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Basic Partner terms, TRY' | 'Sales return 103 dated 12.03.2021 08:59:52' | ''      | 'No'                   | ''                           |
			| ''                                             | 'Expense'     | '24.06.2022 18:06:56' | '-50'       | 'Main Company' | 'Distribution department' | 'en description is empty'      | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Basic Partner terms, TRY' | 'Sales return 103 dated 12.03.2021 08:59:52' | ''      | 'No'                   | ''                           |
			| ''                                             | 'Expense'     | '24.06.2022 18:06:56' | '-8,56'     | 'Main Company' | 'Distribution department' | 'Reporting currency'           | 'USD'      | 'Company Ferron BP' | 'Ferron BP' | 'Basic Partner terms, TRY' | 'Sales return 103 dated 12.03.2021 08:59:52' | ''      | 'No'                   | ''                           |		
		And I close all client application windows

Scenario: _043327 check Bank payment movements by the Register "R2020 Advances from customer" (Return to customer by POS, without basis document)
		And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '1 330' |
	* Check movements by the Register  "R2020 Advances from customer" 
		And I click "Registrations report" button
		And I select "R2020 Advances from customer" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 1 330 dated 24.06.2022 18:07:02' | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''                  | ''          | ''      | ''                     | ''                           |
			| 'Document registrations records'               | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''                  | ''          | ''      | ''                     | ''                           |
			| 'Register  "R2020 Advances from customer"'     | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''                  | ''          | ''      | ''                     | ''                           |
			| ''                                             | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''                        | ''                             | ''         | ''                  | ''          | ''      | 'Attributes'           | ''                           |
			| ''                                             | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'                  | 'Multi currency movement type' | 'Currency' | 'Legal name'        | 'Partner'   | 'Order' | 'Deferred calculation' | 'Customers advances closing' |
			| ''                                             | 'Receipt'     | '24.06.2022 18:07:02' | '-50'       | 'Main Company' | 'Distribution department' | 'Local currency'               | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | ''      | 'No'                   | ''                           |
			| ''                                             | 'Receipt'     | '24.06.2022 18:07:02' | '-50'       | 'Main Company' | 'Distribution department' | 'en description is empty'      | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | ''      | 'No'                   | ''                           |
			| ''                                             | 'Receipt'     | '24.06.2022 18:07:02' | '-8,56'     | 'Main Company' | 'Distribution department' | 'Reporting currency'           | 'USD'      | 'Company Ferron BP' | 'Ferron BP' | ''      | 'No'                   | ''                           |	
	And I close all client application windows

Scenario: _043328 check Bank payment movements by the Register "R3010 Cash on hand" (Return to customer by POS, without basis document)
		And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '1 330' |
	* Check movements by the Register  "R3010 Cash on hand" 
		And I click "Registrations report" button
		And I select "R3010 Cash on hand" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 1 330 dated 24.06.2022 18:07:02' | ''            | ''                    | ''          | ''             | ''                        | ''                                     | ''         | ''                             | ''                     |
			| 'Document registrations records'               | ''            | ''                    | ''          | ''             | ''                        | ''                                     | ''         | ''                             | ''                     |
			| 'Register  "R3010 Cash on hand"'               | ''            | ''                    | ''          | ''             | ''                        | ''                                     | ''         | ''                             | ''                     |
			| ''                                             | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''                        | ''                                     | ''         | ''                             | 'Attributes'           |
			| ''                                             | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'                  | 'Account'                              | 'Currency' | 'Multi currency movement type' | 'Deferred calculation' |
			| ''                                             | 'Expense'     | '24.06.2022 18:07:02' | '8,56'      | 'Main Company' | 'Distribution department' | 'POS account, Comission separate, TRY' | 'USD'      | 'Reporting currency'           | 'No'                   |
			| ''                                             | 'Expense'     | '24.06.2022 18:07:02' | '50'        | 'Main Company' | 'Distribution department' | 'POS account, Comission separate, TRY' | 'TRY'      | 'Local currency'               | 'No'                   |
			| ''                                             | 'Expense'     | '24.06.2022 18:07:02' | '50'        | 'Main Company' | 'Distribution department' | 'POS account, Comission separate, TRY' | 'TRY'      | 'en description is empty'      | 'No'                   |	
	And I close all client application windows

Scenario: _043329 check Bank payment movements by the Register "R3050 Pos cash balances" (Return to customer by POS, without basis document)
		And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '1 330' |
	* Check movements by the Register  "R3050 Pos cash balances" 
		And I click "Registrations report" button
		And I select "R3050 Pos cash balances" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 1 330 dated 24.06.2022 18:07:02' | ''                    | ''          | ''           | ''             | ''                        | ''             | ''                                     | ''                 |
			| 'Document registrations records'               | ''                    | ''          | ''           | ''             | ''                        | ''             | ''                                     | ''                 |
			| 'Register  "R3050 Pos cash balances"'          | ''                    | ''          | ''           | ''             | ''                        | ''             | ''                                     | ''                 |
			| ''                                             | 'Period'              | 'Resources' | ''           | 'Dimensions'   | ''                        | ''             | ''                                     | ''                 |
			| ''                                             | ''                    | 'Amount'    | 'Commission' | 'Company'      | 'Branch'                  | 'Payment type' | 'Account'                              | 'Payment terminal' |
			| ''                                             | '24.06.2022 18:07:02' | '-50'       | '-5'         | 'Main Company' | 'Distribution department' | 'Card 01'      | 'POS account, Comission separate, TRY' | 'Test01'           |
		And I close all client application windows

Scenario: _0433291 check absence Bank payment movements by the Register R5022 Expenses" (Return to customer by POS)
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number' |
			| '1 330'  |
	* Check movements by the Register  "R5022 Expenses" 
		And I click "Registrations report" button
		And I select "R5022 Expenses" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document does not contain values
			| 'R5022 Expenses'   | 
	And I close all client application windows


Scenario: _043330 Bank payment clear posting/mark for deletion
	And I close all client application windows
	* Select Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '2' |
	* Clear posting
		And in the table "List" I click the button named "ListContextMenuUndoPosting"
		Then user message window does not contain messages
		And I click "Registrations report" button
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 2 dated 05.04.2021 12:28:47' |
			| 'Document registrations records'                    |
		And I close current window
	* Post Bank payment
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '2' |
		And in the table "List" I click the button named "ListContextMenuPost"		
		Then user message window does not contain messages
		And I click "Registrations report" button
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document contains values
			| 'R3010 Cash on hand' |
		And I close all client application windows
	* Mark for deletion
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '2' |
		And in the table "List" I click the button named "ListContextMenuSetDeletionMark"
		Then "1C:Enterprise" window is opened
		And I click "Yes" button
		Then user message window does not contain messages
		And I click "Registrations report" button
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Bank payment 2 dated 05.04.2021 12:28:47' |
			| 'Document registrations records'                    |
		And I close current window
	* Unmark for deletion and post document
		Given I open hyperlink "e1cib/list/Document.BankPayment"
		And I go to line in "List" table
			| 'Number'  |
			| '2' |
		And in the table "List" I click the button named "ListContextMenuSetDeletionMark"
		Then "1C:Enterprise" window is opened
		And I click "Yes" button				
		Then user message window does not contain messages
		And in the table "List" I click the button named "ListContextMenuPost"	
		Then user message window does not contain messages
		And I click "Registrations report" button
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document contains values
			| 'R3010 Cash on hand' |
		And I close all client application windows	