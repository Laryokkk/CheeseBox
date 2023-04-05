<script>
    import Menu from "$lib/components/menu/Menu.svelte";
    import Statistica from "../Statistica.svelte";
    import Produzione from "../Produzione.svelte";
    import Gestione from "../Gestione.svelte";

    import { onMount } from "svelte";
    import { getCookie } from "$lib/utils/util-cookie.js";


    export let data;

    let permission;

    onMount(() => {
        permission = getCookie("permission");
    });

    $: links = permission === "caseificio" ? data.links : [];
    $: section = data.section;
    $: content = data.content;
</script>

<section class="container">
    {#if permission === "consorzio"}
        <Menu {links} goBack={true} />
    {:else}
        <Menu {links} />
    {/if}
    <section class="wrapper">
        {#if section === "produzione"}
            <Produzione />
        {/if}
        {#if section === "statistica"}
            <Statistica {content} />
        {/if}
        {#if section === "gestione"}
            <Gestione />
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
