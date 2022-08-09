*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    Collections


*** Variables ***
${url_base}    https://gorest.co.in/
${path_params}    public/v2/users
${id_users}    
&{headers}       Content-Type=application/json    Authorization=Bearer d85fc5d3d4f9fb82c58f4ca6a62077c3123cb1043a2f00d988be6b39bf96bdcd    
${end_point}    ""
${response}    ""
${payload_user}




*** Keywords ***

Dado que tenho os dados para efetuar o serviço list_all_user
    ${end_point}    Catenate    ${url_base}${path_params}    #${id_users}
    Create Session    gorest    ${end_point}    ${headers}
    Set Test Variable    ${end_point}

Quando executo serviço list_all_user
     ${response}  GET    ${end_point}
     Set Test Variable    ${response}
     Log To Console    ${response.text}

    

Então valido o status code da request
    Should Be Equal As Integers    200    ${response.status_code}
    

Deletar usuario criado
    ${id_users}    Set Variable    ${response.json()}[0][id]
    ${response}    DELETE    ${end_point}

Dado que tenho os dados para efetuar o serviço create_user
    ${payload_user}    Get File    ./json/body.json    
    Create Session    gorest    ${end_point}    ${headers}
    Set Test Variable    ${payload_user}

    

    

Quando executo serviço create_user
    ${response}    POST On Session    alias=gorest    url=${end_point}    data=${payload_user}
    Set Test Variable    ${response}
Valido se usuario foi criado utilizando a request de get_user
    ${new_end_point}    Catenate    ${end_point}/${response.json()}[id]
    ${response}  GET    ${new_end_point}
    
    