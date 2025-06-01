//Notação para expor a classe como um serviço web

@RestResource(urlMapping='/Case_History__c/*')

//Declaração de classe global e compartilhada
global with sharing class restResourceCaseHistory {
    //Notação de metodo GET 
    @HttpGet
    //Criação do metodo da classe
    global static Case_History__c getChById() {
        //Criação de variavel RestRequest para receber o recurso
        RestRequest req = RestContext.request;

        //Criação de string para coletar o ID do Case History pela URL
        String chId = req.requestURI.substring(
            //Parametro para referenciar o index do ID
            req.requestURI.lastIndexOf('/')+1
        );

        //Criação de variavel Case History que coleta os dados do registro via SOQL
        Case_History__c result = [SELECT Case__r.Status__c, SLA_Met__c FROM Case_History__c WHERE Id = :chId];

        //Retorna o Case History encontrado via SOQL
        return result;
    }
}