*** Settings ***
Resource    ../resources/serve-rest-front.resource
Test Setup    Abrir o navegador


*** Test Cases ***
Login com sucesso Serve Rest front
  Cadastrar novo usuario


Desafio: Conferir se o novo usuário esta na lista de usuarios cadastrados
    Cadastrar novo usuario
    Ir para lista de usuários
    Conferir se o novo usuario esta na listagem

Desafio: Cadastrar e consultar novo produto
    Cadastrar novo usuario
    Cadastrar novo produto
    Conferir se o produto aparece na listagem