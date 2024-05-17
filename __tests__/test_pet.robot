*** Settings ***
# Bibliotecas e Configurações
Library    RequestsLibrary
 


*** Variables ***
# Objetos, Atributos e Variables
${url}    https://petstore.swagger.io/v2/pet
${id}    173218101
${name}    Snoopy                                 # $ - variavel simples
&{category}    id=1    name=cachorro                   # & - lista com valores unicos - json {} 
@{photoUrls}                                # @ - sinaliza uma lista com vários registros - json []
&{tag}    id=1    name=vacinado
@{tags}    ${tag}                                 # Fez uma lista de outra lista 
${status}    available

*** Test Cases ***
# Descritivo de Negócio + Passos de Automação
Post pet
    ${body}    Create Dictionary    id=${id}    category=${category}    name=${name}    
    ...                             photoUrls=${photoUrls}    tags=${tags}    status=${status}

    #executar
    ${response}    POST    url=${url}    json=${body}

    # validações
    ${response_body}    Set Variable    ${response.json()}            # Recebe o conteudo da outra variavel
    Log To Console    ${response_body}       #imprimir o retorno da api no terminal / console 

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}

    Should Be Equal    ${response_body}[name]    ${name}

    Should Be Equal    ${response_body}[tags][0][id]    ${{int(${tag}[id])}}

    Should Be Equal    ${response_body}[tags][0][name]    ${tag}[name]

    Should Be Equal    ${response_body}[status]    ${status}

Get pet
    ${response}    GET    ${{$url + '/' + $id}}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}
    Should Be Equal    ${response_body}[name]    ${name}
    Should Be Equal    ${response_body}[category][id]    ${{int(${category}[id])}}
    Should Be Equal    ${response_body}[category][name]    ${category}[name]

Put pet
    # montar a mensagem / body com a mudança 
    ${body}    Evaluate    json.loads(open('./fixtures/json/pet2.json').read())

    ${response}    PUT    url=${url}    json=${body}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}

    Should Be Equal    ${response_body}[name]    ${name}

    Should Be Equal    ${response_body}[category][id]    ${{int(${category}[id])}}

    Should Be Equal    ${response_body}[category][name]    ${category}[name]

    Should Be Equal    ${response_body}[id]    ${{int($id)}}

    Should Be Equal    ${response_body}[name]    ${name}

    Should Be Equal    ${response_body}[tags][0][id]    ${{int(${tag}[id])}}

    Should Be Equal    ${response_body}[tags][0][name]    ${tag}[name]

    Should Be Equal    ${response_body}[status]    sold

    Should Be Equal    ${response_body}[status]    ${body}[status]

Delete pet
    ${response}    DELETE    ${{$url + '/' + $id}}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{int(200)}}

    Should Be Equal    ${response_body}[type]    unknown

    Should Be Equal    ${response_body}[message]    ${id}






*** Keywords ***
# Descritivo de Negócio (se estruturar separadamente) - DSL (Domain Specific Language)
