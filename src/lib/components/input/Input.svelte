<script>
    import {
        isValidInputText,
        isValidInputNumber,
        isValidInputEmail,
        isValidInputPhone,
        isValidInputPassword,
    } from "$lib/utils/util-validate.js";

    export let type = "text";
    export let placeholder = undefined;
    export let readonly = false;
    export let minlength = undefined;
    export let maxlength = undefined;
    export let autocomplete = undefined;
    export let required = undefined;
    export let parentHandlerInput = undefined;
    export let className = "";
    export let style = undefined;
    export let value = null;
    export let options = [];

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
        case "select":
            isValidInput = true;
            break;

        default:
            isValidInput = isValidInputText;
            break;
    }

    const handlerInput = (e) => {
        const { value } = e.target;
        parentHandlerInput && parentHandlerInput(value);

        invalid = !isValidInputText(value);

        if (maxlength) {
            if (value.length > maxlength) {
                e.preventDefault();

                e.target.value = value.slice(0, value.length - 1);;
            }
        }
    };

    const handlerValidation = (e) => {
        const { value } = e.target;

        invalid = !isValidInput(value);
    };
</script>

<div class="container">
    {#if type === "select"}
        <select class="text {className}" {required} {style}>
            {#each options as option}
                <option class="text" value={option}>{option}</option>
            {/each}
        </select>
    {:else}
        <input
            {type}
            class="text {className}"
            class:invalid
            {placeholder}
            {autocomplete}
            {readonly}
            on:input={handlerInput}
            on:change={handlerValidation}
            {invalid}
            {required}
            {style}
            {value}
        />
    {/if}
</div>

<style>
    input,
    select {
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

    select {
        width: 22rem;
        height: 3rem;
    }

    input.invalid {
        transition: all 0.4s ease-out;
        box-shadow: 0px 0px 4px 1px var(--error);
    }

    input:read-only {
        color: var(--text-readonly);
        cursor: auto;
    }
</style>
