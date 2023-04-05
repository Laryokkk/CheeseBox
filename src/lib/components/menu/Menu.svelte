<script>
    import { getCookie } from "$lib/utils/util-cookie.js";
    import { onMount } from "svelte";

    export let links = [];
    export let goBack = false;
    let username;

    onMount(() => {
        username = `${getCookie("firstname_user")} ${getCookie(
            "lastname_user"
        )}`;
    });
</script>

<section class="menu">
    <div class="heading">
        <a href="/">
            <h3 class="text text-extend">CheeseBox</h3>
        </a>
        <h5 class="text text-accent">{username}</h5>
    </div>
    <div class="container">
        {#each links as { title, href, active }}
            <a {href}>
                <h4 class="text text-extend {active ? 'text-accent' : ''}">
                    {title}
                </h4>
            </a>
        {/each}
    </div>
    <div class="footer">
        {#if goBack}
            <a href="/gestione/consorzio/vendita">
                <img src="/assets/arrow-right.svg" alt="go back arrow" class="go-back">
            </a>
        {/if}
    </div>
</section>

<style>
    section.menu {
        height: calc(100vh - 6rem);
        width: 16vw;
        max-width: 16vw;
        min-width: 16vw;

        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-direction: column;
        gap: 8rem;

        padding: 3rem;

        background-color: var(--background-extend);
    }

    div.heading,
    div.container,
    div.footer {
        display: flex;
        align-items: center;
        justify-content: space-around;
        flex-direction: column;
        gap: 1rem;
    }

    img.go-back {
        transition: all 0.2s ease-in-out;
    }

    img.go-back:hover {
        scale: 1.1;
    }
</style>
