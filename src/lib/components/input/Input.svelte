<script>
    import {
        isValidInputText,
        isValidInputNumber,
        isValidInputEmail,
        isValidInputPhone,
        isValidInputPassword,
    } from "$lib/utils/util-validate.js";

    export let type = "text";
    export let placeholder;
    export let autocomplete;
    export let required = "false"
    export let parentHandlerInput;
    export let style;

    let isValidInput;
    let invalid;

    switch (type) {
        case "text":
            isValidInput = isValidInputText;
            break;
        case "number":
            isValidInput = isValidInputNumber;
            break;
        case "email":
            isValidInput = isValidInputEmail;
            break;
        case "phone":
            isValidInput = isValidInputPhone;
            break;
        case "password":
            isValidInput = isValidInputPassword;
            break;

        default:
            isValidInput = isValidInputText;
            break;
    }

    const handlerInput = (e) => {
        const { value } = e.target;
        parentHandlerInput(value);

        invalid = !isValidInputText(value);
    };

    const handlerValidation = (e) => {
        const { value } = e.target;

        invalid = !isValidInput(value);
    };
</script>

<div class="container">
    <input
        {type}
        class="text"
        class:invalid={invalid}

        {placeholder}
        {autocomplete}

        on:input={handlerInput}
        on:change={handlerValidation}

        {invalid}
        {required}

        {style}
    />
</div>

<style>
    input {
        outline: none;

        width: 20rem;
        height: 1rem;

        margin: 0;
        border: 0;
        border-radius: 0.4rem;
        padding: 1rem;

        background-color: var(--background-input);

        transition: all 0.2s ease-in;
    }

    input.invalid {
        transition: all 0.4s ease-out;
        box-shadow: 0px 0px 4px 1px var(--error);
    }
</style>
