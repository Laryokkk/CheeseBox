<script>
    import Menu from "$lib/components/menu/Menu.svelte";
    import Caseifici from "../Caseifici.svelte";
    import Vendita from "../Vendita.svelte";
    import Statistica from "../Statistica.svelte";

    export let data;

    const { links } = data;
    $: section = data.section;

</script>

<section class="container">
    <Menu {links} />
    <section class="wrapper">
        {#if section === "vendita"}
            <Vendita />
        {/if}
        {#if section === "statistica"}
            <Statistica />
        {/if}
        {#if section === "caseifici"}
            <Caseifici />
        {/if}
    </section>
</section>

<style>
    section.container {
        display: flex;
        flex-direction: row;
    }

    section.wrapper {
        width: 80vw;
        height: 100vh;
    }
</style>
