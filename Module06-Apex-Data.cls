copado__Org__c hotfix = [select Id, Name, copado__Environment__c from copado__Org__c where Name='HotFix' limit 1];

copado__User_Story__c u1 = new copado__User_Story__c(Module_External_Id__c='Ebike-Module6-US1');
u1.copado__User_Story_Title__c = 'Module 6: Contact Billing Country Hotfix';
u1.copado__Project__r = new copado__Project__c(Module_External_Id__c='EBike-Project');
u1.copado__Status__c = 'Approved';
u1.copado__Functional_Specifications__c = 'This User Story contains an urgent fix to a flow that needs to be fixed in Production. This User Story (as it does not relate to the Ebike application we are building) would usually be in another project.  For the sake of simplicity, we will include this User Story in our project.\nYou will find out why later.';
u1.copado__Org_Credential__c = hotfix.Id;
u1.copado__Environment__c = hotfix.copado__Environment__c;
upsert u1 Module_External_Id__c;