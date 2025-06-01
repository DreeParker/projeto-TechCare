@isTest
private class ClosedCaseRequestHandlerTest {


    @isTest
    static void CreateCaseHistoryTest() {
    
        //Lista auxiliar para armazenar os case requests de teste
        List <Case_Request__c> casosTeste = new List<Case_Request__c>();
        
        //Criação do primeiro caso de teste
        Case_Request__c caso1 = new Case_Request__c();
        caso1.Status__c = 'New';
        caso1.Subject__c = 'Test 1 EEEEEE';

        //Adição do caso a lista
        casosTeste.add(caso1);
        

        //Criação do primeiro caso de teste
        Case_Request__c caso2 = new Case_Request__c();
        caso2.Status__c = 'New';
        caso2.Subject__c = 'Test 2 IIIII';

        //Adição do caso a lista
        casosTeste.add(caso2);
        

        //Inicio do teste
        Test.startTest();

            //Comando DML para inserção dos casos armazenados na lista
            insert casosTeste;

            //Fechamento do caso de teste e atualização de campos necessarios 
            caso1.Status__c = 'Closed';
            caso1.Closed_by_Process__c = true;
            caso1.Close_Date__c = Datetime.now();
            caso1.Resolution_Notes__c = 'Nota de teste';

            //Comando DML para atualizar os caso 1
            update caso1;

            //Fechamento do caso de teste e atualização de campos necessarios 
            caso2.Status__c = 'Closed';
            caso2.Closed_by_Process__c = true;
            caso2.Close_Date__c = Datetime.now();
            caso2.Resolution_Notes__c = 'Nota de teste';
            
            //Alteração do SLA para uma data anterior a uma data atual
            caso2.SLA_Deadline__c = Datetime.newInstance(2025, 01, 01, 1, 1, 1);

            //Comando DML para atualizar os caso 2
            update caso2;

        //Fim do teste
        Test.stopTest();

        //Lista para coletar via SOQL os Cases Histories abertos a partir dos casos de teste
        List<Case_History__c> ch = [SELECT Id, Case__c, Time_Closed__c, SLA_Met__c FROM Case_History__c WHERE Case__c = :casosTeste];

        //Verifica se a lista ch retornou a quantidade de Case History de acordo com a qtd de casos de testes fechados
        System.assertEquals(2, ch.size());

        //Verifica se o campo SLA Met é falso de acordo com o caso de teste modificado
        System.Assert.isFalse(ch[1].SLA_Met__c);

    }
}