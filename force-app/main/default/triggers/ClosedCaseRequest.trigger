//Trigger ativado no objeto Case Request após o mesmo ser atualizado
trigger ClosedCaseRequest on Case_Request__c (after update) {
    
    //Condição verifica se o trigger foi ativado depois que todos os registros foram salvos
    if(Trigger.isAfter){

        //Invoca a classe auxiliar passando como parametro os registros ativados pelo trigger
        ClosedCaseRequestHandler.CreateCaseHistory(Trigger.new);
    }

}