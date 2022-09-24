*** Settings ***
Library   SeleniumLibrary
Library   String

*** Variables ***
${login_button}    //button[@id='dt_login_button']

*** Test Cases ***
1. Access Close Account Settings Page
    Open Browser    https://app.deriv.com/account/closing-account    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']    set own email
    Input Text    //input[@type='password']    set own password
    Click Element    //button[@type='submit']

TC01: Accessing the Security and Privacy policy
    Wait Until Element Is Visible    //a[@href='https://deriv.com/tnc/security-and-privacy.pdf']    10
    # Click Element    //a[@href='https://deriv.com/tnc/security-and-privacy.pdf']
    # Check that we are in a new tab called "security-and-privacy.pdf"

TC02: User presses the “Cancel” button
    Wait Until Element Is Visible    //button[@class='dc-btn dc-btn--secondary dc-btn__large closing-account__button--cancel']    10
    Click Element    //button[@class='dc-btn dc-btn--secondary dc-btn__large closing-account__button--cancel']
    # Check that we have exited settings page
    Wait Until Page Does Not Contain Element    //button[@class='dc-btn dc-btn--secondary dc-btn__large closing-account__button--cancel']    10
    Page Should Not Contain Element    //button[@class='dc-btn dc-btn--secondary dc-btn__large closing-account__button--cancel']

Reset State
    Close Browser
    Open Browser    https://app.deriv.com/account/closing-account    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']    set own email
    Input Text    //input[@type='password']    set own password
    Click Element    //button[@type='submit']

TC03: User presses the “Close my account” button
    Wait Until Element Is Visible    //button[@class='dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account']    10
    Click Element    //button[@class='dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account']

TC04.1: User does not click on any of the reasons and attempts to close account
    # Check that no checkboxes are ticked
    Page Should Not Contain Element    //span[@class='dc-checkbox__box dc-checkbox__box--active']
    # Check that "Continue" not clickable
    Element Should Be Disabled    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large']

TC04.2: User presses on only 1 reason
    Click Element    //span[contains(., 'I have other financial priorities.')]
    # Check that "Continue" is clickable
    Element Should Be Enabled    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large']
    # Check that other checkboxes still clickable
    Page Should Not Contain Element    //span[@class='dc-checkbox__box dc-checkbox__box--disabled']

TC04.3: User presses on only 2 reasons
    # Click another reason
    Click Element    //span[contains(., 'I want to stop myself from trading.')]
    # Check that "Continue" is clickable
    Element Should Be Enabled    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large']
    # Check that other checkboxes still clickable
    Page Should Not Contain Element    //span[@class='dc-checkbox__box dc-checkbox__box--disabled']

TC04.4: User presses on 3 reasons
    # Click another reason
    Click Element    //span[contains(., 'I’m no longer interested in trading.')]
    # Check that "Continue" is clickable
    Element Should Be Enabled    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large']
    # Check that other checkboxes are not clickable
    Wait Until Page Contains Element    //span[@class='dc-checkbox__box dc-checkbox__box--disabled']    10
    Page Should Contain Element    //span[@class='dc-checkbox__box dc-checkbox__box--disabled']

TC05: “What other trading platforms do you use” textbox functionality
    # Can click on textbook
    Click Element    //textarea[@name='other_trading_platforms']
    # Can input stuff
    Press Keys    None    aaa
    # Check that input exists within box
    Wait Until Page Contains Element    //textarea[@name='other_trading_platforms' and contains(.,'aaa')]    10
    Page Should Contain Element    //textarea[@name='other_trading_platforms' and contains(.,'aaa')]

TC06: “What could we improve” textbox functionality
    Click Element    //textarea[@name='do_to_improve']
    # Can input stuff
    Press Keys    None    aaa
    # Check that input exists within box
    Wait Until Page Contains Element    //textarea[@name='do_to_improve' and contains(.,'aaa')]    10
    Page Should Contain Element    //textarea[@name='do_to_improve' and contains(.,'aaa')]
    # Attempt to input more than 110 characters
    Press Keys    None    CTRL+A
    Press Keys    None    BACKSPACE
    Repeat Keyword    120 times    Press Keys    None    a
    # Check that input length is 110
    Wait Until Element Is Visible    //p[@class='dc-text closing-account-reasons__hint' and contains(.,'Remaining characters: 0')]    10
    Page Should Contain Element    //p[@class='dc-text closing-account-reasons__hint' and contains(.,'Remaining characters: 0')]

TC07: User presses “Back” button
    Click Element    //button[@class='dc-btn dc-btn__effect dc-btn--secondary dc-btn__large']
    # Check that we have indeed gone back to the previous page
    Wait Until Element Is Visible    //button[@class='dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account']    10
    Page Should Contain Element    //button[@class='dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account']

Provide a state which satisfies prequesites to test TC08
    Wait Until Element Is Visible    //button[@class='dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account']    10
    Click Element    //button[@class='dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account']
    Click Element    //span[contains(., 'I have other financial priorities.')]

TC08.1: User presses “Continue” button
    Wait Until Element Is Enabled    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large']    10
    Click Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large']
    # Confirm that a confirmation page is visible
    Wait Until Page Contains Element    //div[@class='account-closure-warning-modal']    10
    Page Should Contain Element    //div[@class='account-closure-warning-modal']

TC08.2: After user presses "Continue" button, user presses "Go Back" on account closure warning page
    Wait Until Page Contains Element    //button[@class='dc-btn dc-btn__effect dc-btn--secondary dc-btn__large' and contains(.,'Go Back')]    10
    Click Element    //button[@class='dc-btn dc-btn__effect dc-btn--secondary dc-btn__large' and contains(.,'Go Back')]
    # Confirm that user is led out of confirmation page
    Wait Until Page Does Not Contain Element    //div[@class='account-closure-warning-modal']    10
    Page Should Not Contain Element    //div[@class='account-closure-warning-modal']

TC08.3: After user presses "Continue" button, user presses "Close Account" on account closure warning page
    Wait Until Element Is Enabled    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large']    10
    Click Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large']
    # Confirm that a confirmation page is visible
    Wait Until Page Contains Element    //div[@class='account-closure-warning-modal']    10
    Page Should Contain Element    //div[@class='account-closure-warning-modal']
    # Click on "Close account"
    Wait Until Page Contains Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large' and contains(.,'Close account')]    10
    Click Element    //button[@class='dc-btn dc-btn__effect dc-btn--primary dc-btn__large' and contains(.,'Close account')]
    # Confirm that user is led out of confirmation page
    Wait Until Page Does Not Contain Element    //div[@class='account-closure-warning-modal']    10
    Page Should Not Contain Element    //div[@class='account-closure-warning-modal']

TC09: If user tries to relogin using previously deleted account, ask user to confirm if they wish to rejoin Deriv
    Close Browser
    Open Browser    https://app.deriv.com/account/closing-account    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']    set own email
    Input Text    //input[@type='password']    set own password
    Click Element    //button[@type='submit']
    # Confirm that user receives confirmation message if they wish to rejoin Deriv
    Wait Until Page Contains     Want to start trading on Deriv again?    10
    Page Should Contain    Want to start trading on Deriv again?

