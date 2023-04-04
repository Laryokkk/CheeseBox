<script>
    export let text = "";
    export let style = undefined;
    export let handlerClick = undefined;
</script>

<button {style} on:click={handlerClick}>
    <h5 class="text">
        {text}
    </h5>
</button>

<style>
    button {
        text-align: center;
        cursor: pointer;

        padding: 1rem 3rem;
        border: 0;
        border-radius: 1rem;

        background-color: var(--background-accent);
    }

    button:hover:not(:disabled),
    button:active:not(:disabled) {
        background-color: var(--background-input);
    }
</style>
