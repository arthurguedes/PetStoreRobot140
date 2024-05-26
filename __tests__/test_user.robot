*** Settings ***
Library    RequestsLibrary

*** Variables ***
${url}    https://petstore.swagger.io/v2/user
${id}    10
${username}    gugaliseu
${firstName}    guga
${lastName}    liseu
${email}    gugaliseu@gmail.com
${password}    gugaliseu123456
${phone}    11952224896
${userStatus}    0

*** Test Cases ***
Post user
    ${body}    Create Dictionary    id=${id}    username=${username}    firstName=${firstName}    lastName=${lastName}    email=${email}    password=${password}    phone=${phone}    userStatus=${userStatus}

    #executar
    ${response}    POST    url=${url}    json=${body}

    # validações
    ${response_body}    Set Variable    ${response.json()}            # Recebe o conteudo da outra variavel
    Log To Console    ${response_body}       #imprimir o retorno da api no terminal / console 

    Status Should Be    200
    #Should Be Equal    ${response_body}[id]    ${{int($id)}}

    #Should Be Equal    ${response_body}[username]    ${username}

    #Should Be Equal    ${response_body}[firstName]    ${firstName}

Get user
    ${response}    GET    ${{$url + '/' + $username}}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}
    Should Be Equal    ${response_body}[username]    ${username}
    Should Be Equal    ${response_body}[firstName]    ${firstName}

Put user
    # montar a mensagem / body com a mudança 
    ${body}    Evaluate    json.loads(open('./fixtures/json/user1.json').read())

    ${response}    PUT    url=${url}    json=${body}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}

    Should Be Equal    ${response_body}[username]    ${username}

    Should Be Equal    ${response_body}[userStatus]    ${{int(${userStatus})}}

Delete user
    ${response}    DELETE    ${{$url + '/' + $username}}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{int(200)}}

    Should Be Equal    ${response_body}[type]    unknown

    #Should Be Equal    ${response_body}[message]    ${id}


