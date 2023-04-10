<script>
    export let name;
    export let code;

    const href = `/gestione/caseificio/statistica?code=${code}`;
</script>

<a {href}>
    <section class="container">
        <div class="wrapper">
            <h3 class="text">
                {name}
            </h3>
            <h4 class="text text-accent">
                {code}
            </h4>
        </div>
        <img src="/assets/arrow-right-accent.svg" alt="enter" />
    </section>
</a>

<style>
    section.container {
        width: 250px;
        height: 200px;

        display: flex;
        justify-content: space-between;
        flex-direction: column;

        border-radius: 2rem;

        background-color: var(--background-input);

        padding: 2rem;
        z-index: 10;

        overflow: hidden;
        transition: all 0.4s ease-in-out;
    }

    section.container:hover,
    section.container:active {
        z-index: 0;

        scale: 1.1;
        box-shadow: 0px 0px 100px 10px var(--background-accent);
    }

    div.wrapper {
        display: flex;
        flex-direction: column;
        gap: 0.6rem;
    }

    img {
        height: 3rem;

        align-self: flex-end;
    }
</style>
