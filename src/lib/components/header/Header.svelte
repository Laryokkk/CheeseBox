<script>
    import { onMount } from "svelte";
    import { getCookie } from "$lib/utils/util-cookie.js";

    let user;
    let permission;

    onMount(() => {
        user = getCookie("id_user");
        permission = getCookie("permission");
    });
</script>

<section id="header">
    <div class="left">
        <a href="/">
            <h3 class="text">CheeseBox</h3>
        </a>
    </div>
    <div class="right">
        {#if permission === "consorzio"}
            <a href="/gestione/consorzio/statistica">
                <h4 class="text">Gestione</h4>
            </a>
        {:else if permission === "caseificio"}
            <a href="/gestione/caseificio/statistica">
                <h4 class="text">Gestione</h4>
            </a>
        {/if}
        {#if user}
            <a href="/sign-out/">
                <h4 class="text text-accent">Esci</h4>
            </a>
        {:else}
            <a href="/sign-in/">
                <h4 class="text text-accent">Accedi</h4>
            </a>
        {/if}
    </div>
</section>

<style>
    section#header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-direction: row;

        padding: 2rem 4rem;
    }

    div.right {
        display: flex;
        align-items: center;
        flex-direction: row;
        gap: 3rem;
    }
</style>
