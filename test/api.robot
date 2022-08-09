*** Settings ***    
Resource    ../resource/resource.resource


*** Test Cases ***
Pegar todos os usuarios ja cadastrados e printar a quantidade dos usuarios ja cadastrados
    Dado que tenho os dados para efetuar o serviço list_all_user
    Quando executo serviço list_all_user
    Então valido o status code da request

Cadastro um novo usuário de     #"joão " e "Silva"
    #  [Teardown]    Deletar usuario criado
     Dado que tenho os dados para efetuar o serviço create_user
#     Quando executo serviço create_user
#     Valido se usuario foi criado utilizando a request de get_user


