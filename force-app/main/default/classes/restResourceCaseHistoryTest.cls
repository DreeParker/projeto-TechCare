@isTest
private class restResourceCaseHistoryTest {

    @IsTest
    static void getChByIdTest() {

        //Criação de caso para teste
        Case_Request__c caso = new Case_Request__c();
        caso.Subject__c = 'Teste RestResource';
        caso.Status__c = 'New';

        //Comando DML para inserir o caso
        insert caso;

        //Atualização do caso
        caso.Status__c = 'Closed';
        caso.Closed_by_Process__c = true;
        caso.Resolution_Notes__c = 'Teste';
        caso.Close_Date__c = Datetime.now();

        //Comando DML para atualização do caso teste
        update caso;

        //Lista para buscar e armazenar o Case History criado a partir do caso de teste
        List<Case_History__c> chId = [SELECT Id, Case__c FROM Case_History__c WHERE Case__c = :caso.Id];
        
        //Criação de um Rest Resource
        RestRequest request = new RestRequest();
        request.requestUri = '/services/apexrest/Case_History__c/' + chId[0].Id;
        request.httpMethod = 'GET';

        RestContext.request = request;

        //Chamada da classe restResource
        Case_History__c result = restResourceCaseHistory.getChById();

        //Avalia se a variavel result não esta nula
        Assert.isTrue(result != null);
        
    }
}