public with sharing class ClosedCaseRequestHandler {

    //Metodo estatico para a criação de Cases Histories recebendo como parametro os Case Requests do trigger
    public static void CreateCaseHistory(List<Case_Request__c> casos){
        
    //Declaração de lista auxiliar para massificar a criação de Case Histories
    List<Case_History__c> caseHistoryList = new List<Case_History__c>();

        //Loop for para iterar pelos casos passados pelo trigger
        for(Case_Request__c c : casos){
            //Condição que avalia se o caso esta fechado e se a data de fechamento é menor que o SLA
            if(c.Status__c == 'Closed' && c.Close_Date__c < c.SLA_Deadline__c){
                //Criação de um case history
                Case_History__c ch = new Case_History__c();
                ch.Case__c = c.Id;
                ch.SLA_Met__c = True;
                ch.Time_Closed__c = c.Close_Date__c;
                caseHistoryList.add(ch);
                    
            //Condição que avalia se o caso esta fechado e se a data de fechamento é maior que o SLA
            }else if(c.Status__c == 'Closed' && c.Close_Date__c > c.SLA_Deadline__c){
                //Criação de um case history
                Case_History__c ch = new Case_History__c();
                ch.Case__c = c.Id;
                ch.SLA_Met__c = False;
                ch.Time_Closed__c = c.Close_Date__c;
                caseHistoryList.add(ch);

            }
        }
    
    //Condição verifica se a lista esta vazia antes de inserir os registros
    if(caseHistoryList.size() > 0){

        //Comando DML para inserir os novos cases histories
        insert caseHistoryList;
    }

    }
}