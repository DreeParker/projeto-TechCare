//importando a biblioteca padrao do LWC, a API para consultar
//Objetos no SF e track para tornar objetos reativos
import { LightningElement, api, track, wire } from 'lwc';

//Importando as bibliotecas de alteração e consulta 
import { updateRecord, getRecord } from 'lightning/uiRecordApi';


//Declaração de uma constante para o campo que precisamos consultar
const type = ['Case_Request__c.Type__c'];

export default class ReopenCaseButton extends (LightningElement) {

    //Variavel de entrada para receber o Id do caso
    @api recordId;

    //Consulta o campo declarado na const, atraves do ID recebido
    @wire(getRecord, {recordId: '$recordId', fields: type}) 
    caseType;
    
    //Objetos reativos para exibir msg no console 
    @track successMessage;
    @track errorMessage;

    
    //Declaração de metodo acionado pelo botão HTML
    handleReopenCase(){

        //Constante com dados recebidos da consulta
        const t = this.caseType.data;
        //Constante com o type do caso
        const typeValue = t.fields.Type__c.value;

        //Variavel para armazenar a data/hora atual
        const now = new Date();
        //Calcula novo SLA para casos standard e premium
        const dataStandard = new Date(now.getTime() + (1000 * 60 * 60 * 24)).toISOString();
        const dataPremium = new Date(now.getTime() + (8 * 60 * 60 * 1000)).toISOString();

        //Declaração de constante com os campos do objeto
        const fields = {};
        //Atribuindo valor a cada campo necessario para a alteração
        fields['Id'] = this.recordId;
        fields['Status__c'] = 'In Progress';
        fields['Reopen_by_Process__c'] = true;
        fields['Reopened_Case__c'] = true;

        //Condição avalia qual o tipo do objeto para definir novo SLA
        if(typeValue === 'Premium'){
            fields['SLA_Deadline__c'] = dataPremium;
        }else{
            fields['SLA_Deadline__c'] = dataStandard;
        }
        
        //Declara uma constante com o parametro dos campos definidos acima
            const recordInput = { fields };

            //Metodo para realizar a atualização dos campos passados no parametro
            updateRecord(recordInput)
                //Função imperativa exibe uma mensagem de sucesso caso de certo
                .then(() => {
                    this.successMessage = 'Case reaberto com sucesso';
                    this.errorMessage = undefined;
                })
                //Captura o erro e exibe uma mensagem
                .catch(error => {
                    this.errorMessage = 'Erro ao reabrir case ' + error.body.message;
                    this.successMessage = undefined;
                });

        

    }


}