*** Settings ***
Library   SeleniumLibrary

*** Variables ***
${login_button}    //button[@id='dt_login_button']

*** Test Cases ***
1. Access API Settings Page
    Open Browser    https://app.deriv.com/account/api-token    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']    add email here
    Input Text    //input[@type='password']    add password here
    Click Element    //button[@type='submit']

TC01: Scope Selection of API Key
    # Check that Read, Payments, Admin, Trade and Trading Information checkboxes exists
    Wait Until Page Contains Element    //input[@class='dc-checkbox__input' and @name='read' and @value='false']    10
    Wait Until Page Contains Element    //input[@class='dc-checkbox__input' and @name='payments' and @value='false']    10
    Wait Until Page Contains Element    //input[@class='dc-checkbox__input' and @name='admin' and @value='false']    10
    Wait Until Page Contains Element    //input[@class='dc-checkbox__input' and @name='trade' and @value='false']    10
    Wait Until Page Contains Element    //input[@class='dc-checkbox__input' and @name='trading_information' and @value='false']    10

TC01.1: Clicking on "Read" Checkbox, and expect that Read checkbox is checked upon click
    Click Element    //span[@class='dc-text dc-checkbox__label' and contains(.,"Read")]
    Wait Until Page Contains Element    //input[@class='dc-checkbox__input' and @name='read' and @value='true']    10
    Page Should Contain Element    //input[@class='dc-checkbox__input' and @name='read' and @value='true']

TC01.2: Clicking on "Payments" Checkbox, and expect that Payments checkbox is checked upon click
    Click Element    //span[@class='dc-text dc-checkbox__label' and contains(.,"Payments")]
    Wait Until Page Contains Element    //input[@class='dc-checkbox__input' and @name='payments' and @value='true']    10
    Page Should Contain Element    //input[@class='dc-checkbox__input' and @name='payments' and @value='true']

TC01.3: Clicking on "Admin" Checkbox, and expect that Admin checkbox is checked upon click
    Click Element    //span[@class='dc-text dc-checkbox__label' and contains(.,"Admin")]
    Wait Until Page Contains Element    //input[@class='dc-checkbox__input' and @name='admin' and @value='true']    10
    Page Should Contain Element    //input[@class='dc-checkbox__input' and @name='admin' and @value='true']

TC01.4: Clicking on "Trade" Checkbox, and expect that T checkbox is checked Trade upon click
    Click Element    //span[@class='dc-text dc-checkbox__label' and contains(.,"Trade")]
    Wait Until Page Contains Element    //input[@class='dc-checkbox__input' and @name='trade' and @value='true']    10
    Page Should Contain Element    //input[@class='dc-checkbox__input' and @name='trade' and @value='true']

TC01.5: Clicking on "Trading information" Checkbox, and expect that Trading information checkbox is checked upon click
    Click Element    //span[@class='dc-text dc-checkbox__label' and contains(.,"Trading information")]
    Wait Until Page Contains Element    //input[@class='dc-checkbox__input' and @name='trading_information' and @value='true']    10
    Page Should Contain Element    //input[@class='dc-checkbox__input' and @name='trading_information' and @value='true']

TC02: Naming and Generating API token
    # Check that an input field for "Token name" exists and is visible. Bu default this input field should be empty, and Create button not clickable
    Wait Until Element Is Visible    //input[@name='token_name' and @aria-label='Token name']    10
    Wait Until Element Is Visible    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button' and @type='submit' and @disabled]     10
    # The user must also not have an existing active API Token
    Page Should Not Contain Element    //td[@class='da-api-token__table-cell da-api-token__table-cell--name']

TC02.1: Input no characters in the “Token name” input field, and expect that user not allowed to create token
    Click Element    //input[@name='token_name' and @aria-label='Token name']
    Press Keys    None    SPACE
    Press Keys    None    CTRL+A
    Press Keys    None    BACKSPACE
    Wait Until Element Is Visible    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button' and @type='submit' and @disabled]     10
    Page Should Contain Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button' and @type='submit' and @disabled]
    Wait Until Element Is Visible    //div[@class='dc-field dc-field--error' and contains(.,'Please enter a token name.')]    10
    Page Should Contain Element    //div[@class='dc-field dc-field--error' and contains(.,'Please enter a token name.')]

TC02.2: Input in only 1 Latin character in “Token name” input field, and expect that user not allowed to create token + error message shown
    Click Element    //input[@name='token_name' and @aria-label='Token name']
    Press Keys    None    CTRL+A
    Press Keys    None    BACKSPACE
    Press Keys    None    a
    Wait Until Element Is Visible    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button' and @type='submit' and @disabled]     10
    Page Should Contain Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button' and @type='submit' and @disabled]
    Wait Until Element Is Visible    //div[@class='dc-field dc-field--error' and contains(.,'Length of token name must be between 2 and 32 characters.')]    10
    Page Should Contain Element    //div[@class='dc-field dc-field--error' and contains(.,'Length of token name must be between 2 and 32 characters.')]

TC02.3: Input in 33 Latin characters in “Token name” input field, and expect that user not allowed to create token + error message shown
    Click Element    //input[@name='token_name' and @aria-label='Token name']
    Press Keys    None    CTRL+A
    Press Keys    None    BACKSPACE
    Press Keys    None    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    Wait Until Element Is Visible    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button' and @type='submit' and @disabled]     10
    Page Should Contain Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button' and @type='submit' and @disabled]
    Wait Until Element Is Visible    //div[@class='dc-field dc-field--error' and contains(.,'Maximum 32 characters.')]    10
    Page Should Contain Element    //div[@class='dc-field dc-field--error' and contains(.,'Maximum 32 characters.')]

TC02.4: Input in between 2 to 32 Latin characters in “Token name” input field, and expect that is allowed to create token
    Click Element    //input[@name='token_name' and @aria-label='Token name']
    Press Keys    None    CTRL+A
    Press Keys    None    BACKSPACE
    Press Keys    None    abcdefgh
    Wait Until Page Does Not Contain Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button' and @type='submit' and @disabled]     10
    Page Should Not Contain Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button' and @type='submit' and @disabled]
    Wait Until Page Does Not Contain Element    //div[@class='dc-field dc-field--error']    10
    Page Should Not Contain Element    //div[@class='dc-field dc-field--error']

TC02.5a: When valid token name is inputted, “Create” button should be clickable
    Click Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button' and @type='submit']

TC02.5b: Upon clicking “Create” button, previous inputs are cleared
    Wait Until Page Does Not Contain Element    //input[@name='token_name' and @aria-label='Token name' and @value='abcdefgh']    10
    Page Should Not Contain Element    //input[@name='token_name' and @aria-label='Token name' and @value='abcdefgh']
    Page Should Not Contain Element    //input[@class='dc-checkbox__input' and @name='read' and @value='true']
    Page Should Not Contain Element    //input[@class='dc-checkbox__input' and @name='payments' and @value='true']
    Page Should Not Contain Element    //input[@class='dc-checkbox__input' and @name='admin' and @value='true']
    Page Should Not Contain Element    //input[@class='dc-checkbox__input' and @name='trade' and @value='true']
    Page Should Not Contain Element    //input[@class='dc-checkbox__input' and @name='trading_information' and @value='true']

TC02.5c: Upon clicking “Create” button, “Create” button is no longer clickable
    Wait Until Page Does Not Contain Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button' and @type='submit' and @disabled]     10
    Page Should Not Contain Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button' and @type='submit' and @disabled]
    
TC02.6: The generated token is shown on screen, under “Copy and paste the token into the app.” section, details of created token should exist
    Wait Until Element Is Visible    //td[@class='da-api-token__table-cell da-api-token__table-cell--name']    10
    Page Should Contain Element    //td[@class='da-api-token__table-cell da-api-token__table-cell--name']

# TC03: Scope of usability of previously generated API Keys
# We have already checked in TC02 that no previous API Keys exists, and
# in TC02.6, check that the API Key is successfully generated

TC03.1a: The generated token can be copied by user upon clicking of “Copy” icon
    # Click "Copy" icon
    Wait Until Page Contains Element   //*[contains(@data-testid, "dt_copy_token_icon")]    10
    Click Element    //*[contains(@data-testid, "dt_copy_token_icon")]
    # Check for confirmation message
    Wait Until Element Is Visible    //div[@class='dc-modal-body']    10
    Page Should Contain Element    //div[@class='dc-modal-body']
    # Close the confirmation message
    Wait Until Element Is Visible    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button']    10
    Click Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button']

TC03.2a: The Latin characters details of API key can be visibly seen upon click of “Eye” icon
    # Check that API Token is hidden
    Page Should Contain Element    //div[@class='da-api-token__pass-dot']
    # Click "Eye" Icon
    Wait Until Page Contains Element   //*[contains(@data-testid, "dt_toggle_visibility_icon")]    10
    Click Element    //*[contains(@data-testid, "dt_toggle_visibility_icon")]
    # Check that API Token is not hidden
    Wait Until Page Does Not Contain Element   //div[@class='da-api-token__pass-dot']    10
    Page Should Not Contain Element    //div[@class='da-api-token__pass-dot']

TC03.2b: Upon second click of “Eye” icon, Latin character details of API Key is no longer visible
    # Click "Eye" Icon
    Wait Until Page Contains Element   //*[contains(@data-testid, "dt_toggle_visibility_icon")]    10
    Click Element    //*[contains(@data-testid, "dt_toggle_visibility_icon")]
    # Check that API Token is hidden
    Wait Until Page Contains Element   //div[@class='da-api-token__pass-dot']    10
    Page Should Contain Element    //div[@class='da-api-token__pass-dot']

TC03.3a: Upon click of “Trash” icon, a confirmation message will be sent to user to confirm delete API key
    # Click "Trash" Icon
    Wait Until Element Is Visible    //*[@class="dc-icon dc-clipboard da-api-token__delete-icon"]    10
    Click Element    //*[@class="dc-icon dc-clipboard da-api-token__delete-icon"]
    # Check that confirmation message is visible
    Wait Until Element Is Visible    //div[@class='dc-modal-body']    10
    Page Should Contain Element    //div[@class='dc-modal-body']

TC03.3b: If user clicks on “Cancel”, the token is not deleted
    # Click "Cancel"
    Wait Until Element Is Visible    //button[@class='dc-btn dc-btn__effect dc-btn--secondary dc-btn__large dc-dialog__button']    10
    Click Element    //button[@class='dc-btn dc-btn__effect dc-btn--secondary dc-btn__large dc-dialog__button']
    # Check that API Key still exists
    Wait Until Element Is Visible    //td[@class='da-api-token__table-cell da-api-token__table-cell--name']    10
    Page Should Contain Element    //td[@class='da-api-token__table-cell da-api-token__table-cell--name']

TC03.3c: If user clicks on “Yes, please”, token is deleted
    # Click "Trash" Icon
    Wait Until Element Is Visible    //*[@class="dc-icon dc-clipboard da-api-token__delete-icon"]    10
    Click Element    //*[@class="dc-icon dc-clipboard da-api-token__delete-icon"]
    # Check that confirmation message is visible
    Wait Until Element Is Visible    //div[@class='dc-modal-body']    10
    Page Should Contain Element    //div[@class='dc-modal-body']
    # Click "Cancel"
    Wait Until Element Is Visible    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button']    10
    Click Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button']
    # Check that API Key no longer exists
    Wait Until Element Is Not Visible    //td[@class='da-api-token__table-cell da-api-token__table-cell--name']    10
    Page Should Not Contain Element    //td[@class='da-api-token__table-cell da-api-token__table-cell--name']




