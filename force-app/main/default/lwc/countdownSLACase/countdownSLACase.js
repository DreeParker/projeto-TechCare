//importando a biblioteca padrao do LWC, a API para consultar
//Objetos no SF e track para tornar objetos reativos
import { LightningElement, api, wire } from 'lwc';

//Importando as bibliotecas de consulta de objetos e campos
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

//Importando o campo SLA
import SLADEADLINE_FIELD from '@salesforce/schema/Case_Request__c.SLA_Deadline__c';

//Importando o campo CreatedDate
import CREATEDATE_FIELD from '@salesforce/schema/Case_Request__c.CreatedDate';

export default class CountdownSLACase extends LightningElement {

    //Capturando o id do case com a anotação api
    @api recordId;
    //Capturando possiveis erros
    error;

    //Declarando a variavel que armazenara o SLA do caso
    deadline;

    //Declarando a variavel que armazenara o SLA do caso
    created;

    //Declara a variavel countdown
    countdown = 'Carregando...';

    //Armazena o Id do timer
    setTimeInterval;

    //Consulta o campo SLA Deadline e CreatedDate do case via getRecord
    @wire(getRecord, { recordId: "$recordId", fields: [SLADEADLINE_FIELD, CREATEDATE_FIELD] })

    //Metodo que será iniciado após o resultado da consulta
    verifyGetRecord({data, error}){

      //Condição para verificar se os dados da consulta retornaram
      if(data){

        //Armazena o valor do SLA dentro da variavel
        this.deadline = getFieldValue(data, SLADEADLINE_FIELD);
        //Armazena o valor da data de criação dentro da variavel
        this.created = getFieldValue(data, CREATEDATE_FIELD);
        
        //Limpa o contador antes de inicia-lo
        clearInterval(this.setTimeInterval);

        //Inicia o contador através de uma função imperativa
        this.setTimeInterval = setInterval(() => {

          //Variavel dia armazenado o valor do SLA
          let dateEnd = new Date(this.deadline);
          //Variavel armazena o dia de criação do caso
          let dateInit = new Date(this.created);

          let now = new Date();

          //Variavel armazena a hora do SLA 
          let timeEnd = dateEnd.getTime();
          //Variavel armazena a hora do dia de criação do caso
          let timeInit = dateInit.getTime();

          let timeNow = now.getTime();
          
          //Variavel que vai armazenar a diferença entre a data de criação e do SLA
          let timeDifference = timeEnd - timeInit;

          //Condição verifica se a diferença entre as datas é menor que zero
          if(timeDifference < 0){
            //Limpa o contador
            clearInterval(this.setTimeInterval);
            //Exibe uma mensagem de expiração do SLA
            this.countdown = 'SLA Expired';

          } else if(timeNow > timeEnd){

            clearInterval(this.setTimeInterval);
            //Exibe uma mensagem de expiração do SLA
            this.countdown = 'SLA Expired';

          }else{
            //Calcula o dia através da diferença
            let days = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
            //Calcula as horas através da diferença
            let hours = Math.floor((timeDifference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));

            //Exibe os dias e horas restantes
            this.countdown = days + "days " + hours + "hrs ";
          }
          
          //Intervalo de tempo em que o contador atualiza (nesse caso a cada 1 seg)
        },1000)
        
        //Coleta o erro
      } else if(error){
        this.error = error;
        this.dateEnd = undefined;
      }
    }

}