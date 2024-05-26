*** Settings ***
Library    RequestsLibrary

*** Variables ***
${url}    https://petstore.swagger.io/v2/store/order
${id}    2
${petId}    2
${quantity}    2
${shipDate}    2024-05-26T03:13:32.042Z
${status}    placed
${complete}    true

*** Test Cases ***
Post store
    ${body}    Create Dictionary    id=${id}    petId=${petId}    quantity=${quantity}    shipDate=${shipDate}    status=${status}    complete=${complete}

    #executar
    ${response}    POST    url=${url}    json=${body}

    # validações
    ${response_body}    Set Variable    ${response.json()}            # Recebe o conteudo da outra variavel
    Log To Console    ${response_body}       #imprimir o retorno da api no terminal / console 

    Status Should Be    200
    #Should Be Equal    ${response_body}[id]    ${{int($id)}}

    #Should Be Equal    ${response_body}[username]    ${username}

    #Should Be Equal    ${response_body}[firstName]    ${firstName}

Get store
    ${response}    GET    ${{$url + '/' + $id}}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    #Should Be Equal    ${response_body}[id]    ${{int($id)}}
    #Should Be Equal    ${response_body}[username]    ${username}
    #Should Be Equal    ${response_body}[firstName]    ${firstName}



Delete user
    ${response}    DELETE    ${{$url + '/' + $id}}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{int(200)}}

    Should Be Equal    ${response_body}[type]    unknown

    #Should Be Equal    ${response_body}[message]    ${id}


