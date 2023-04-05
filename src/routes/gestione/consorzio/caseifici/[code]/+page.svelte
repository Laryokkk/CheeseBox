<script>
    import Menu from "$lib/components/menu/Menu.svelte";
    import HeaderSection from "../../../HeaderSection.svelte";
    import PreviewCaseificio from "../PreviewCaseificio.svelte";

    export let data;

    $: code = data.code.charAt(0).toUpperCase() + data.code.slice(1);
    $: links = data.links;
    $: caseifici = data.caseifici || [];
</script>

<section class="container">
    <Menu {links} goBack={true} />

    <section class="wrapper">
        <HeaderSection content={`<h4 class="text">${code}</h4>`} />
        <div class="container">
            {#each caseifici as { name, code }}
                <PreviewCaseificio {name} {code} />
            {/each}
        </div>
    </section>
</section>

<style>
    section.container {
        display: flex;
        flex-direction: row;
    }

    section.wrapper {
        width: 80vw;
        height: 90%;

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
