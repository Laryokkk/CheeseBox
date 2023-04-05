<script>
    import Menu from "$lib/components/menu/Menu.svelte";
    import Vendita from "../Vendita.svelte";
    import Statistica from "../Statistica.svelte";

    export let data;

    $: links = data.links;
    $: section = data.section;
    $: content = data.content;
</script>

<section class="container">
    <Menu {links} />
    <section class="wrapper">
        {#if section === "vendita"}
            <Vendita />
        {/if}
        {#if section === "statistica"}
            <Statistica {content} />
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
