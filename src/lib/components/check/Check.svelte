<script>
    export let value = '';
</script>

<section class="container">
    <textarea class="text" name="check" cols="30" rows="10" readonly {value} />
</section>

<style>
    textarea[name="check"] {
        width: calc(100% - 4rem);
        height: calc(25vh - 2rem);

        padding: 1rem 2rem;
        border: 0;
        border-radius: 2rem;

        background-color: var(--background-input);
        resize: none;
        writing-mode: unset;
        outline: none;
        cursor: auto;
    }
</style>
