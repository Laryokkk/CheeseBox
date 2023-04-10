<script>
    import Menu from "$lib/components/menu/Menu.svelte";
    import Button from "$lib/components/button/Button.svelte";
    import HeaderSection from "../../../HeaderSection.svelte";
    import PreviewCaseificio from "../PreviewCaseificio.svelte";

    export let data;

    $: code = data.code.charAt(0).toUpperCase() + data.code.slice(1);
    $: links = data.links;
    $: caseifici = data.caseifici || [];

    const buttonHandlerClick = () => {
        window.location.href = `/gestione/consorzio/create?region=${data.code}`;
    };
</script>

<section class="container">
    <Menu {links} goBack={true} />

    <section class="wrapper">
        <HeaderSection content={`<h4 class="text">${code}</h4>`} />
        <div class="container">
            {#if caseifici.length > 0}
                {#each caseifici as { name, code }}
                    <PreviewCaseificio {name} {code} />
                {/each}
            {:else}
                <h4 class="text">
                    Non abbiamo i caseifici a seconda della ricerca ...
                </h4>
            {/if}
        </div>
        <Button text="Aggiungi" handlerClick={buttonHandlerClick} />
    </section>
</section>

<style>
    section.container {
        display: flex;
        flex-direction: row;
    }

    section.wrapper {
        width: 80vw;
        height: 90vh;

        padding: 2rem 4vw;

        display: flex;
        justify-content: space-between;
        flex-direction: column;
        gap: 2rem;
    }

    div.container {
        display: flex;
        flex-wrap: wrap;
        gap: 4rem;

        margin-top: 6vh;
    }
</style>
