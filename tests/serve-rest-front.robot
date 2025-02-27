*** Settings ***
Resource    ../resources/serve-rest-front.resource
Test Setup    Abrir o navegador
Suite Teardown    Close Browser    ALL


*** Test Cases ***
Login com sucesso Serve Rest front
  [Tags]    login_usuario
  Cadastrar novo usuario


Desafio: Conferir se o novo usuário esta na lista de usuarios cadastrados
    [Tags]    lista_usuario
    Cadastrar novo usuario
    Ir para lista de usuários
    Conferir se o novo usuario esta na listagem

Desafio: Cadastrar e consultar novo produto
    [Tags]    card_produto
    Cadastrar novo usuario
    Cadastrar novo produto
    Conferir se o produto aparece na listagem