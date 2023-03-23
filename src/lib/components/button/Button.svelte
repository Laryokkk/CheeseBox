<script>
    export let text;
    export let style;
    export let handlerClick;
</script>

<button {style} on:click={handlerClick}>
    <h4 class="text">
        {text}
    </h4>
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
