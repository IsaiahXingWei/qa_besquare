*** Settings ***
Library   SeleniumLibrary

*** Variables ***
${login_button}    //button[@id='dt_login_button']

*** Test Cases ***
Question 1
# 1. Log in using your account
# 2. Check the current account lands on real account
# 3. Then switch to virtual account and verify virtual account is displayed
    Open Browser    https://app.deriv.com/    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    //div[@class='btn-purchase__text_wrapper' and contains(.,'Rise')]    30
    Click Element    dt_login_button
    Wait Until Page Contains Element    //input[@type='email']    10
    Input Text    //input[@type='email']    Fill in email here
    Input Text    //input[@type='password']    Fill in password here
    Click Element    //button[@type='submit']
    Wait Until Element Is Enabled    //div[@class='acc-info']   60
    Sleep    5
    # Check if we are in real account
    Page Should Contain Element    //div[@class='acc-info']
    Click Element    //div[@class='acc-info']
    Click Element    //li[@id='dt_core_account-switcher_demo-tab']
    Click Element    //span[@class='acc-switcher__id']
    # Check if we are in virtual account
    Page Should Contain Element    //div[@class='acc-info acc-info--is-virtual']


Question 2
# - Underlying: Volatility 10 (1s) Index
# - Contract type: Rise
# - Duration: 5 ticks
# - Stake: 10.00 USD
# sc-mcd__item sc-mcd__item--1HZ10V 
    Click Element    //div[@class='cq-symbol']
    Sleep    7
    Page Should Contain Element   //div[@class='sc-mcd__item sc-mcd__item--1HZ10V ']
    Click Element    //div[@class='sc-mcd__item sc-mcd__item--1HZ10V ']
    Sleep    5
    # Check that we are in Volatility 10 (1s) Index
    Wait Until Page Contains    Volatility 10 (1s) Index    10
    Page Should Contain    Volatility 10 (1s) Index
    # Check that duration set is 5 ticks
    Wait Until Page Contains    5 Ticks    10
    Page Should Contain    5 Ticks
    # Check that we are in stake mode
    Wait Until Element Is Visible    //button[@class='dc-btn dc-btn__toggle dc-button-menu__button dc-button-menu__button--active']    10
    Page Should Contain Element    //button[@class='dc-btn dc-btn__toggle dc-button-menu__button dc-button-menu__button--active']
    # Check that stake amount is 10 USD
    Wait Until Element Is Visible    //input[@id='dt_amount_input' and @value='10']    10
    Page Should Contain Element    //input[@id='dt_amount_input' and @value='10']
    # Buy Contract
    Wait Until Element Is Visible    //div[@class='btn-purchase__info btn-purchase__info--right']    10
    Click Element    //div[@class='btn-purchase__info btn-purchase__info--right']
    # Check that contract is purchased
    Wait Until Element Is Visible   //div[@class='positions-drawer__header']    10
    Page Should Contain Element    //div[@class='positions-drawer__header']
    Wait Until Element Is Visible    //a[@class='dc-result__caption-wrapper']    30

Question 3
# Buy lower contract (estimation time: 30 min)

# - Underlying: AUD/USD
# - Contract type: Lower
# - Duration: 4 days
# - Barrier: Default
# - Payout: 15.50 USD

# Key points:
# - Create keywords to reuse the functionalities of selecting underlying and contract type
# - Use payout instead of stake
    # Change market type
    Click Element    //div[@class='cq-symbol']
    Wait Until Element Is Visible    //span[@class='ic-icon ic-forex']
    Click Element    //span[@class='ic-icon ic-forex']
    Wait Until Element Is Visible    //div[@class='sc-mcd__item sc-mcd__item--frxAUDUSD ']    10
    Click Element    //div[@class='sc-mcd__item sc-mcd__item--frxAUDUSD ']
    # Change contract type
    Wait Until Element Is Visible    //span[@name='contract_type']    10
    Click Element    //span[@name='contract_type']
    # Select Higher/Lower
    Wait Until Element Is Enabled    //div[@id='dt_contract_high_low_item']    10
    Click Element    //div[@id='dt_contract_high_low_item']
    # Check that we are in Higher/Lower
    Wait Until Page Contains    Higher/Lower    10
    Page Should Contain    Higher/Lower
    # Select duration: 4 days
    # Check that we are in Duration
    Wait Until Element Is Visible    //button[@class="dc-btn dc-btn__toggle dc-button-menu__button dc-button-menu__button--active"]    10
    Page Should Contain Element    //button[@class="dc-btn dc-btn__toggle dc-button-menu__button dc-button-menu__button--active"]
    # Select 4 days
    Page Should Contain Element    //input[@class='dc-input__field' and @value='10']
    Click Element    //input[@class='dc-input__field']
    Press Keys    None    BACKSPACE + 4
    # Check that we are in stake mode, and switch to payout
    Page Should Contain Element    //button[@class='dc-btn dc-btn__toggle dc-button-menu__button dc-button-menu__button--active']
    Click Element    //button[@id='dc_payout_toggle_item']
    Wait Until Element Is Visible    //button[@class='dc-btn dc-btn__toggle dc-button-menu__button dc-button-menu__button--active']    10
    Page Should Contain Element    //button[@class='dc-btn dc-btn__toggle dc-button-menu__button dc-button-menu__button--active']
    # Set payout to 15.50 USD
    Page Should Contain Element    //input[@class='dc-input-wrapper__input input--has-inline-prefix input trade-container__input' and @value='10']
    Click Element    //input[@class='dc-input-wrapper__input input--has-inline-prefix input trade-container__input']
    Sleep    3
    Press Keys    None    CTRL+A
    Press Keys    None    BACKSPACE
    Press Keys    None    1 + 5 + . + 5 + 0
    Wait Until Element Is Visible    //input[@class='dc-input-wrapper__input input--has-inline-prefix input trade-container__input' and @value='15.50']    10
    Page Should Contain Element    //input[@class='dc-input-wrapper__input input--has-inline-prefix input trade-container__input' and @value='15.50']
    # Buy Contract
    Wait Until Element Is Visible    //div[@class='btn-purchase__info btn-purchase__info--left']    10
    Sleep    3
    Click Element    //span[@style='--text-size:var(--text-size-xs); --text-color:var(--text-colored-background); --text-lh:var(--text-lh-m); --text-weight:var(--text-weight-bold); --text-align:var(--text-align-left);' and contains(.,'Lower')]
    # Check that contract is purchased
    Wait Until Element Is Visible   //a[@class='dc-contract-card dc-contract-card--red']    10

Question 4
# Check relative barrier error (estimation time: 30 min)

# - Underlying: AUD/USD
# - Contract type: Lower
# - Duration: 4 days
# - Barrier: +0.1
# - Payout: 10  USD

# Key points:
# - Make sure this error message appears: Contracts more than 24 hours in duration would need an absolute barrier
# - Make sure the Lower button is disabled
    # Set payout to 15.50 USD
    Page Should Contain Element    //input[@class='dc-input-wrapper__input input--has-inline-prefix input trade-container__input' and @value='15.50']
    Click Element    //input[@class='dc-input-wrapper__input input--has-inline-prefix input trade-container__input']
    Press Keys    None    CTRL+A
    Press Keys    None    BACKSPACE
    Press Keys    None    1 + 0
    Wait Until Element Is Visible    //input[@class='dc-input-wrapper__input input--has-inline-prefix input trade-container__input' and @value='10']    10
    Page Should Contain Element    //input[@class='dc-input-wrapper__input input--has-inline-prefix input trade-container__input' and @value='10']
    # Change Barrier to +0.1
    Click Element    //input[@id='dt_barrier_1_input']
    Press Keys    None    CTRL+A
    Press Keys    None    BACKSPACE
    Press Keys    None    + + 0 + . + 1
    # Check that error message is present and trade disabled
    Wait Until Page Contains    Contracts more than 24 hours in duration would need an absolute barrier    10
    Page Should Contain Element    //div[@class='trade-container__fieldset-wrapper trade-container__fieldset-wrapper--disabled']
    Page Should Contain    Contracts more than 24 hours in duration would need an absolute barrier

Question 5
# Check multiplier contract parameter (estimation time: 2 hours)

# - Underlying: Volatility 50 Index 
# - Contract type: Multiplier

# Key points:

# a. Only stake is allowed. Should not have payout option
# b. Only deal cancellation or take profit/stop loss is allowed
# c. Multiplier value selection should have x20, x40, x60, x100, x200
# d. Deal cancellation fee should correlate with the stake value (e.g. deal cancellation fee is more expensive when the stake is higher) 
# e. Maximum stake is 2000 USD
# f. Minimum stake is 1 USD
# g. Single click on plus (+) button of take profit field should increase the stake value by 1 USD 
# h. Single click on minus (-) button of take profit field should decrease the stake value by 1 USD
# i. Deal cancellation duration only has these options: 5, 10, 15, 30 and 60 min
    # Change market type
    Click Element    //div[@class='cq-symbol']
    Wait Until Element Is Visible    //span[@class='ic-icon ic-synthetic_index']    10
    Click Element    //span[@class='ic-icon ic-synthetic_index']
    Wait Until Element Is Visible    //div[@class='sc-mcd__item sc-mcd__item--R_50 ']    10
    Click Element    //div[@class='sc-mcd__item sc-mcd__item--R_50 ']
    # Change contract type
    Wait Until Element Is Visible    //span[@name='contract_type']    10
    Click Element    //span[@name='contract_type']
    # Select Higher/Lower
    Wait Until Element Is Visible    //div[@id='dt_contract_multiplier_item']    10
    Click Element    //div[@id='dt_contract_multiplier_item']
    # a. Only stake is allowed. Should not have payout option
    Page Should Not Contain    Payout
    # b. Only deal cancellation or take profit/stop loss is allowed
    # Case 1: Take profit clicked first, next Deal cancelation
    Click Element    //span[@class='dc-text dc-checkbox__label take_profit-checkbox__label']
    Wait Until Element Is Visible    //input[@name='take_profit']    10
    Page Should Contain Element    //input[@name='take_profit']
    Click Element    //span[@class='dc-text dc-checkbox__label']
    Wait Until Element Is Not Visible    //input[@name='take_profit']    10
    Page Should Not Contain Element    //input[@name='take_profit']
    Wait Until Element Is Visible    //span[@name='cancellation_duration']    10
    Page Should Contain Element    //span[@name='cancellation_duration']
    # Case 2: Deal cancelation first, then Take Profit
    Click Element    //span[@class='dc-text dc-checkbox__label take_profit-checkbox__label']
    Wait Until Element Is Visible    //input[@name='take_profit']    10
    Page Should Contain Element    //input[@name='take_profit']
    Wait Until Element Is Not Visible    //span[@name='cancellation_duration']    10
    Page Should Not Contain Element    //span[@name='cancellation_duration']