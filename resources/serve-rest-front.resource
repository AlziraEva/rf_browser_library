*** Settings ***
Library     Browser 
Library     FakerLibrary
Library    DateTime


*** Variables ***
${BROWSER}                               chromium
${HEADLESS}                              ${False}   
${SITE_SERVE_REST}                       https://front.serverest.dev/login
${BOTAO_CADASTRAR_HOME}                  a[data-testid="cadastrar"]
${INPUT_CADASTRAR_NOME_USUARIO}          input[data-testid='nome']
${INPUT_CADASTRAR_EMAIL_USUARIO}         input[data-testid='email']
${INPUT_CADASTRAR_SENHA_USUARIO}         input[data-testid='password']
${CHECKBOX_CADASTRAR}                    input[data-testid='checkbox']
${BOTAO_CADASTRAR_USUARIO}               button[data-testid='cadastrar']
${BOTAO_LISTA_USUARIOS}                  a[data-testid="listarUsuarios"]
${BOTAO_CADASTRAR_PRODUTO}               a[data-testid="cadastrarProdutos"]
${INPUT_CADASTRAR_NOME_PRODUTO}          input[data-testid="nome"]
${INPUT_CADASTRAR_PRECO_PRODUTO}         input[data-testid="preco"]
${INPUT_CADASTRAR_DESCRICAO_PRODUTO}     textarea[data-testid="descricao"]
${INPUT_CADASTRAR_QUANTIDADE_PRODUTO}    input[data-testid="quantity"]
${INPUT_CADASTRAR_IMAGEM_PRODUTO}        input[data-testid="imagem"]
${BOTAO_SUBMETER_CADASTRO_PRODUTO}       button[data-testid="cadastarProdutos"]
${CAMINHO_IMAGEM}                        ../assets/image.png

*** Keywords ***
Abrir o navegador
    New Browser     browser=${BROWSER}
    ...             headless=${HEADLESS}
    
Ir para o Site Rest front
    New Page       url=${SITE_SERVE_REST}
    ${title}       Get Title    ==    Front - ServeRest

Preencher dados do novo usuario e cadastrar
    Click            ${BOTAO_CADASTRAR_HOME}
    ${EMAIL}         FakerLibrary.Email
    Set Global Variable    ${EMAIL}
    ${SENHA}         FakerLibrary.Password
    Fill Text        ${INPUT_CADASTRAR_NOME_USUARIO}      Eva      
    Fill Text        ${INPUT_CADASTRAR_EMAIL_USUARIO}     ${EMAIL}
    Fill Text        ${INPUT_CADASTRAR_SENHA_USUARIO}     ${SENHA}
    Check Checkbox   ${CHECKBOX_CADASTRAR}
    Click            ${BOTAO_CADASTRAR_USUARIO}
    

Conferir usuario cadastrado com sucesso
    Get Text    h1    ==    Bem Vindo Eva

Ir para lista de usuários
    Click    ${BOTAO_LISTA_USUARIOS}
    

# Conferir se o novo usuario esta na listagem
#     Get Element    //td[contains(.,'${EMAIL}')]
Conferir se o novo usuario esta na listagem
    ${elemento}     Get Table Cell Element      //table[@class='table table-striped']    column="Email"    row="${EMAIL}"
    Get Text    ${elemento}   ==    ${EMAIL}

Cadastrar novo usuario
    Ir para o Site Rest front
    Preencher dados do novo usuario e cadastrar
    Conferir usuario cadastrado com sucesso

Cadastrar novo produto
    Click                        ${BOTAO_CADASTRAR_PRODUTO}
    ${NOME_PRODUTO}              FakerLibrary.Name
    Set Global Variable          ${NOME_PRODUTO}
    ${PRECO_PRODUTO}             FakerLibrary.Random Number               digits=2    
    ${DESCRICAO_PRODUTO}         FakerLibrary.Sentence
    Set Global Variable          ${DESCRICAO_PRODUTO}
    ${QUANTIDADE_PRODUTO}        FakerLibrary.Random Number               digits=1    
    Fill Text                    ${INPUT_CADASTRAR_NOME_PRODUTO}          ${NOME_PRODUTO}
    Fill Text                    ${INPUT_CADASTRAR_PRECO_PRODUTO}         ${PRECO_PRODUTO}  
    Fill Text                    ${INPUT_CADASTRAR_DESCRICAO_PRODUTO}     ${DESCRICAO_PRODUTO}   
    Fill Text                    ${INPUT_CADASTRAR_QUANTIDADE_PRODUTO}    ${QUANTIDADE_PRODUTO}             
    Upload File By Selector      ${INPUT_CADASTRAR_IMAGEM_PRODUTO}        ${CAMINHO_IMAGEM} 
    Take Screenshot
    Click                        ${BOTAO_SUBMETER_CADASTRO_PRODUTO}


Conferir se o produto aparece na listagem
    ${elemento}    Get Table Cell Element    table=//table[@class='table table-striped']    column="Nome"    row="${DESCRICAO_PRODUTO}"
    Get Text             ${elemento}    ==   ${NOME_PRODUTO}
    Highlight Elements    ${elemento}
    Take Screenshot       fullPage=${True}
    