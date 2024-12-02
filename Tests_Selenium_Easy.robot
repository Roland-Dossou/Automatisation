*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    Collections
Library    random
Library    BuiltIn
Library    String
Test Setup    Ouvrir SeleniumEasy
Test Teardown    Fermer SeleniumEasy


*** Variables ***
${BROWSER}    Chrome
${BROWSER2}    Firefox

*** Test Cases ***
Selenium Menu Input Forms - Simple Form Demo - Single Input Field
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    https://demo.anhtester.com/basic-first-form-demo.html
    ...    ${\n}EXERCICE : saisir le message Hello dans le champ text
    ...    Cliquer sur le bouton show message
    ...    vérifier que le message qui s'affiche est bien celui attendu
    ...    Bonus : Remplacez HELLO par la variable d'environnement USERNAME
    # Naviguer vers
    ${resultat_attendu}    BuiltIn.Set Variable    Hello %{USERNAME}       
    Input Text    xpath=//input[@id="user-message"]    ${resultat_attendu}
    Click Element    xpath=//button[@onclick="showInput();"]
    Wait Until Element Contains    //span[@id="display"]    ${resultat_attendu}      
    ${resultat_obtenu}    Get Text    //span[@id="display"]  
    #premiere methode de verification avec should be equal qui n'est pas assez fiable
    BuiltIn.Should Be Equal    ${resultat_attendu}    ${resultat_obtenu}    
    #deuxieme methode de verification avec element text should be qui est plus fiable car besoin de implicte wait          
    Element Text Should Be    //span[@id="display"]    ${resultat_attendu}        

Selenium Menu Input Forms - Simple Form Demo - Two Input Fields
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    http://127.0.0.1:8082/demo.seleniumeasy.com/basic-first-form-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Saisir le nombre 1
    ...    ${\n}Saisir le nombre 2
    ...    ${\n}Cliquer sur la somme
    ...    ${\n}Récupérer le résultat
    ...    ${\n}Vérifier le résultat
    # Naviguer vers
    ${resultat_attentdu}    BuiltIn.Set Variable    3            
    Input Text    //input[@id="sum1"]    1
    Input Text    //input[@id="sum2"]    2
    Click Element    //button[@onclick="return total()"]
    Wait Until Element Contains    //span[@id="displayvalue"]    ${resultat_attentdu}    
    ${resultat_obtenu}    Get Text    //span[@id="displayvalue"]
    Element Text Should Be    //span[@id="displayvalue"]    ${resultat_attentdu}    

Selenium Menu Input Forms - Checkbox Demo - Single Checkbox Demo
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    https://demo.anhtester.com/basic-checkbox-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Cliquer sur la Checkbox
    ...    ${\n}Vérifier le message
    # Naviguer vers
    ${resultat_attendu}    BuiltIn.Set Variable    Success - Check box is checked
    Click Element    //a[contains(text(),'Input Forms')]
    Click Element    //a[contains(text(),'Checkbox Demo')]
    Click Element    //input[@type="checkbox"]
    Wait Until Element Contains    //div[contains(text(),'Success - Check box is checked')]    ${resultat_attendu}
    ${resultat_obtenu}    Get Text    //div[contains(text(),'Success - Check box is checked')]
    Element Text Should Be    //div[contains(text(),'Success - Check box is checked')]    ${resultat_attendu}    

Selenium Menu Input Forms - Checkbox Demo - Multiple Checkbox Demo
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    https://demo.anhtester.com/basic-checkbox-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Cliquer sur Check All et Uncheck All (créer des locators pour différencier les deux)
    ...    ${\n}Sélectionner les 4 options
    ...    ${\n}Vérifier que le bouton est passé sur Uncheck All
    # Naviguer vers
    Click Element    //ul[@id='treemenu']//a[text()='Input Forms']
    Click Element    //ul[@id='treemenu']//a[text()='Checkbox Demo']
    # Sélectionner les 4 options
    Wait Until Element Is Enabled    //input[@id="check1" and @value="Check All"] 
    Click Element    //input[@id="check1" and @value="Check All"]     
    # Vérifier que le bouton est passé sur Uncheck All
    Wait Until Element Is Enabled    //input[@id="check1" and @value="Uncheck All"]
    ${resultat_attendu}    BuiltIn.Set Variable    Uncheck All
    ${resultat_obtenu}    Get Value    //input[@id="check1" and @value="Uncheck All"] 
    # Décochez tout et fermer
    #Click Element    //input[@id="check1" and @value="Uncheck All"]   
    
     
    ##SeleniumLibrary.Element Text Should Be    //input[@id="check1" and @value="Uncheck All"]    ${resultat_attendu} pourquoi pas should be?
    #Methode 1
    BuiltIn.Should Be Equal    Uncheck All    ${resultat_attendu}           
    #methode 2
    Element Attribute Value Should Be    //input[@id="check1" and @value="Uncheck All"]    attribute    Uncheck All    
    Click Element    //label[text()="Option 1"]/input
    Click Element    //label[text()="Option 2"]/input
    Click Element    //label[text()="Option 3"]/input
    Click Element    //label[text()="Option 4"]/input

Selenium Menu Input Forms - Radio Buttons Demo - Radio Button Demo
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    https://demo.anhtester.com/basic-radiobutton-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Sélectionner Male puis Female
    ...    ${\n}Clicker sur Get Checked value
    ...    ${\n}Vérifier le message
    # Naviguer vers
    Click Element    //ul[@id='treemenu']//a[text()='Input Forms']
    Click Element    //ul[@id='treemenu']//a[text()='Radio Buttons Demo']
    Select Radio Button    optradio    Male
    Select Radio Button    optradio    Female
    Click Element    //button[@class="btn btn-default"]
    #pas besoin de variabilser car le wait until fait deja la verification et c'est plus fiable que le get element
    Wait Until Element Contains    //p[@class="radiobutton"]    Radio button 'Female' is checked    
    #${genre_attendu}    BuiltIn.Set Variable    Radio button 'Female' is checked
    #Element Attribute Value Should Be    //p[@class="radiobutton"]    attribute    Radio button 'Female' is checked          
    #    Radio button 'Female' is checked    ${genre_attendu} 
    
   
Selenium Menu Input Forms - Select Dropdown List - Select List Demo
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    https://demo.anhtester.com/basic-select-dropdown-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Sélectionner Monday
    ...    ${\n}Vérifier que le message affiche bien la sélection
    ...    ${\n}EXERCICE PLUS DIFFICILE : Sélectionner un élement de manière aléatoire
    # Naviguer vers
    Click Element    //ul[@id='treemenu']//a[text()='Input Forms']
    Click Element    //ul[@id='treemenu']//a[text()='Select Dropdown List']
    Select From List By Label    id=select-demo    Monday  
    Wait Until Element Contains    //p[@class="selected-value"]    Monday   
    ${resultat_attendu_jour}    Set Variable    Monday   
    ${resultat_obtenu_jour}    Get Value    //p[@class="selected-value"] 



Selenium Menu Input Forms - Select Dropdown List - Select List Demo bis
    ${randomNumber}    Evaluate    random.sample(range(2,9),1)    modules=random
    Click Element    //ul[@id='treemenu']//a[text()='Input Forms']
    Click Element    //ul[@id='treemenu']//a[text()='Select Dropdown List']
    Select From List By Index    //select[@id='select-demo']    ${randomNumber}
    Sleep    5
    # Vérifiez que le jour sélectionné s'affiche correctement
    ${selected_value}    Get Text    //p[contains(text(),'Day selected')]
    ${expected_value}    Evaluate    "['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][${randomNumber}-1]"
    Should Contain    ${selected_value}    ${expected_value}

    #Sélectionner Un Jour Au Hasard Ouvrir le navigateur 
    #${randomNumber}    Evaluate    str(random.randint(1,7))    modules=random
    #Select From List By Index    //*[@id='select-demo']/option[3]  
    #Get WebElements    //select[@id='select-demo']/option[not(@disabled)] 
    #${random_option}    Get random item    ${options} 
    #${value}    Get Element Attribute ${random_option} value 
    #Select From List By Value select-demo ${value} 
    # Vérifiez que le jour sélectionné s'affiche correctement 
    #${selected_value}    Get Text    //p[contains(text(),'Day selected')]
    #Should Contain    ${selected_value}        ${value}


Sélectionner Un Jour Au Hasard
    ${randomNumber}=    Evaluate    random.sample(range(2, 9), 1)[0]    modules=random
    Click Element    //ul[@id='treemenu']//a[text()='Input Forms']
    Click Element    //ul[@id='treemenu']//a[text()='Select Dropdown List']
    Select From List By Index    //select[@id='select-demo']    ${randomNumber}
    Sleep    5
    # Vérifiez que le jour sélectionné s'affiche correctement
    ${selected_value}=    Get Text    //p[contains(text(),'Day selected')]
    # Créez la liste des jours de la semaine
    ${days}=    Create List    Sunday    Monday    Tuesday    Wednesday    Thursday    Friday    Saturday
    # Calculer l'index en tant qu'entier
    ${expected_index}=    Evaluate    ${randomNumber} - 1
    ${expected_value}=    Get From List    ${days}    ${expected_index}
    Should Contain    ${selected_value}    ${expected_value}
    Log    ${selected_value}


Selenium Menu Input Forms - Select Dropdown List - Multi Select List Demo
    [Documentation]    ...    ${\n}Présentation Exercice
    ...    http://127.0.0.1:8082/demo.seleniumeasy.com/basic-select-dropdown-demo.html
    ...    ${\n}EXERCICE : Manipulation du formulaire
    ...    ${\n}Sélectionner deux choix dans la liste
    ...    ${\n}Vérifier que le message First Selected correspond bien à la première sélection
    ...    ${\n}Vérifier que le message Get All Selected contient bien les deux sélections
    # Naviguer vers
    Click Element    //ul[@id='treemenu']//a[text()='Input Forms']
    Click Element    //ul[@id='treemenu']//a[text()='Select Dropdown List']
    Click Element    //option[text()="New York"]    
    Click Element    //option[text()="Florida"] 
       

Selenium Menu Table - Table Pagination - Table with Pagination Example
    [Documentation]    ${\n}Présentation Exercice
    ...    http://127.0.0.1:8082/demo.seleniumeasy.com/table-pagination-demo.html
    ...    ${\n}EXERCICE : Naviguer sur le nombre de page et le nombre de ligne des tableaux
    ...    ${\n}Compter le nombre de page
    ...    ${\n}Sur quelle page sommes nous ?
    ...    ${\n}Compter le nombre de ligne du tableau
    ...    ${\n}Initialiser une variable nombreLigneCumul à 0
    ...    ${\n}Faire une boucle sur le nombre de page en cliquant sur suivant à la fin
    ...    ${\n}Dans la boucle :
    ...    ${\n}    Vérifier que la page active correspond à l'index de la boucle
    ...    ${\n}    Compter le nombre de ligne du tableau
    ...    ${\n}    Faire le cumul du nombre de ligne
    ...    ${\n}    Cliquer sur le bouton suivant si on n'est pas sur la dernière page
    ...    ${\n}Récupérer l'index de la dernière ligne
    ...    ${\n}Vérifier que le cumul du nombre de ligne est égal à cet index
    # Naviguer vers
    Click Element    //ul[@id='treemenu']//a[text()='Table']
    Click Element    //ul[@id='treemenu']//a[text()='Table Pagination']
    Get Element Count    //a[contains(@class,"page_link")]
    ${current_page}    Get Text    //li[@class="active"]/a
    ${count_row}    Get Element Count    //tbody/tr[not(contains(@style, 'none'))]  
    ${total_row}    Set Variable    ${0}
    FOR    ${INDEX}    IN RANGE    1    3
        Click Element    //a[contains(@class,"page_link") and text()="${INDEX}"]
        ${current_page}    Get Text    //li[@class="active"]/a
        Should Be Equal As Integers    ${current_page}    ${INDEX}
        ${count_row}    Get Element Count    //tbody/tr[not(contains(@style, 'none'))]  
        ${total_row}    Evaluate    ${total_row} + ${count_row}   
    END
    ${last_index}    Get Text    //tbody/tr[last()]/td[1]
    Should Be Equal As Integers    ${last_index}    ${total_row}
    
    
   


Selenium Menu Table - Table Data Search - Type in your search
    [Documentation]    ${\n}Présentation Exercice sur le parcourt d'un tableau
    ...    https://demo.anhtester.com/table-search-filter-demo.html
    ...    ${\n}EXERCICE 1 : Récupérer le statut de la tache 4 en appliquant un filtre
    ...    ${\n}Attention un TR avec un style display none est présent mais pas visible, pour l'ignorer utilisez not(@style) dans votre critère xpath
    ...    ${\n}EXERCICE 2 : Supprimer le filtrer(utilisez clear et press keys), parcourir le tableau et récupérer le nom de la personne affectée à jQuery
    # Naviguer vers
    Click Element    //ul[@id='treemenu']//a[text()='Table']
    Click Element    //ul[@id='treemenu']//a[text()='Table Data Search']
    


Selenium Menu Progress Bars & Sliders - Bootstrap Progress bar - Progress Bar for Download
    [Documentation]    ${\n}Présentation Exercice
    ...    https://demo.anhtester.com/bootstrap-download-progress-demo.html
    ...    ${\n}EXERCICE : Cliquer sur Download
    ...    ${\n}Synchroniser et vérifier d'être à 100%
    ...    ${\n}Quel est la durée nécessaire au timeout ?
    # Naviguer vers
    Click Element    //ul[@id='treemenu']//a[text()='Progress Bars & Sliders']
    Click Element    //ul[@id='treemenu']//a[text()='Bootstrap Progress bar']
    Click Element    //button[@class="btn btn-block btn-primary"]
    Sleep    19
    Element Should Contain    //div[@class='percenttext' and text()='100%']    100%
    

Selenium Menu Progress Bars & Sliders - Drag & Drop Sliders - Range Sliders
    [Documentation]    ${\n}Présentation Exercice
    ...    https://demo.anhtester.com/drag-drop-range-sliders-demo.html
    ...   ${\n}EXERCICE : Manipuler la barre de progression
    ...    ${\n}Trouver un xpath qui identifie input et output en fonction de id="slider1"
    ...    ${\n}Faire un press keys ARROW_RIGHT sur la barre, on remarque que le press key clique au milieu avant et nous positionne à 50
    ...    ${\n}Alimenter une liste @{KEYS} de 40 ARROW_RIGHT afin de passer de 50 à 90
    ...    ${\n}Faire un press keys sur cette liste @{KEYS}
    ...    ${\n}Faire un press keys pour atteindre 89 avec seulement 3 KEYS (ARROW_LEFT, ARROW_RIGHT, HOME, END, PAGE_UP, PAGE_DOWN)
    # Naviguer vers
    Click Element    //ul[@id='treemenu']//a[text()='Progress Bars & Sliders']
    Click Element    //ul[@id='treemenu']//a[text()='Drag & Drop Sliders']


*** Keywords ***
Ouvrir SeleniumEasy
    [Documentation]
    ...    Ouverture de Chrome à l'adresse https://www.qwant.com/

    # ETAPE DE LANCEMENT DE L APPLICATION
    SeleniumLibrary.Open Browser    http://127.0.0.1:8082/demo.seleniumeasy.com/basic-first-form-demo.html     ${BROWSER2}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Set Selenium Implicit Wait    5s
    SeleniumLibrary.Set Selenium Speed    0.3s

    # verification de l etat initial : etre sur la page de Google
    ${popupIsPresent}    BuiltIn.Run Keyword And Return Status    SeleniumLibrary.Wait Until Page Contains Element    //a[@title="Close"]
    BuiltIn.Run Keyword If    ${popupIsPresent}    SeleniumLibrary.Click Element    //a[@title="Close"]
    # Vérifier que le titre contient "Selenium Easy Demo"
    ${title}    SeleniumLibrary.Get Title
    BuiltIn.Should Contain    ${title}    Selenium Easy

Fermer SeleniumEasy
    [Documentation]
    ...    Fermeture du navigateur
    BuiltIn.Sleep    3
    Close Browser   
